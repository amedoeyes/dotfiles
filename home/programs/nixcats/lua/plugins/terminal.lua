local M = {}

---@class TermWindow
---@field win integer
---@field buf integer
---@field on_exit function
---@field is_open boolean
---@field is_valid boolean
local TermWindow = {}
TermWindow.__index = TermWindow

function TermWindow._calc_dims()
	local ui = vim.api.nvim_list_uis()[1]
	local width = math.floor(ui.width * 0.9)
	local height = math.floor(ui.height * 0.9)
	local row = math.floor((ui.height - height) / 2)
	local col = math.floor((ui.width - width) / 2)
	return row - 1, col, width, height
end

function TermWindow:_create_window()
	local row, col, width, height = self._calc_dims()
	self.win = vim.api.nvim_open_win(self.buf, true, {
		style = "minimal",
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
	})

	vim.api.nvim_buf_set_keymap(self.buf, "n", "q", "", {
		silent = true,
		callback = function()
			if vim.api.nvim_win_is_valid(self.win) then
				vim.api.nvim_win_close(self.win, true)
			end
		end,
	})

	vim.defer_fn(function()
		vim.cmd.startinsert()
	end, 10)
end

function TermWindow:_register_autocmd()
	self._resize_autocmd = vim.api.nvim_create_autocmd("VimResized", {
		callback = function()
			local row, col, width, height = self._calc_dims()
			vim.api.nvim_win_set_config(self.win, {
				relative = "editor",
				width = width,
				height = height,
				row = row,
				col = col,
			})
		end,
	})
end

function TermWindow.new()
	local self = setmetatable({}, TermWindow)
	self.buf = vim.api.nvim_create_buf(false, true)
	self.win = nil
	self.is_open = true
	self.is_valid = true
	self._resize_autocmd = nil

	vim.bo[self.buf].bufhidden = "wipe"
	self:_create_window()
	self:_register_autocmd()

	return self
end

function TermWindow:close()
	if self._resize_autocmd then
		vim.api.nvim_del_autocmd(self._resize_autocmd)
		self._resize_autocmd = nil
	end
	if vim.api.nvim_win_is_valid(self.win) then
		vim.api.nvim_win_close(self.win, true)
	end
	self.is_valid = false
	self.is_open = false
end

function TermWindow:hide()
	if self._resize_autocmd then
		vim.api.nvim_del_autocmd(self._resize_autocmd)
		self._resize_autocmd = nil
	end
	if vim.api.nvim_win_is_valid(self.win) then
		vim.api.nvim_win_hide(self.win)
	end
	self.is_open = false
end

function TermWindow:show()
	self:_create_window()
	self:_register_autocmd()
	self.is_open = true
end

---@type table<string,TermWindow>
local terms = {}
local tid = 0

---@param cmd string[]
---@param opts table
M.open = function(cmd, opts)
	opts = opts or {}

	local id = opts.name or ("term" .. tid)
	tid = tid + 1
	terms[id] = TermWindow.new()

	vim.fn.jobstart(cmd, {
		term = true,
		on_exit = vim.schedule_wrap(function()
			if opts.on_exit then
				opts.on_exit()
			end

			terms[id]:close()
		end),
	})
end

---@param name string
M.close = function(name)
	local term = terms[name]
	if term then
		term:close()
	end
end

---@param cmd string[]
---@param opts table
M.toggle = function(cmd, opts)
	local opts = opts or {}
	opts.name = opts.name or "scratch"

	local term = terms[opts.name]
	if not term or not term.is_valid then
		M.open(cmd, opts)
		return
	end

	if not term.is_open then
		term:show()
	else
		term:hide()
	end
end

return M
