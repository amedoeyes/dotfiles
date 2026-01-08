local M = {}

---@class Terminal
---@field win integer
---@field buf integer
---@field cmd string|string[]|function(): string|string[]?
---@field on_exit function?
---@field on_stdout function?
---@field is_open boolean
local Terminal = {}
Terminal.__index = Terminal

function Terminal._calc_dims()
	local padding = (vim.o.winborder == "" or vim.o.winborder == "none") and 0 or 2

	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	local row = math.floor((vim.o.lines - height) * 0.5)
	local col = math.floor((vim.o.columns - width) * 0.5)

	width = math.max(1, width - padding)
	height = math.max(1, height - padding)

	return row, col, width, height
end

function Terminal:_open_window()
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
			self:close()
		end,
	})

	vim.defer_fn(function()
		vim.cmd.startinsert()
	end, 10)
end

function Terminal:_close_window()
	if vim.api.nvim_win_is_valid(self.win) then
		vim.api.nvim_win_close(self.win, true)
	end
end

function Terminal:_hide_window()
	if vim.api.nvim_win_is_valid(self.win) then
		vim.api.nvim_win_hide(self.win)
	end
end

function Terminal:_create_autocmds()
	if self._autocmds ~= nil then
		return
	end

	self._autocmds = {
		resize = vim.api.nvim_create_autocmd("VimResized", {
			callback = function()
				local new_row, new_col, new_width, new_height = self._calc_dims()
				vim.api.nvim_win_set_config(self.win, {
					relative = "editor",
					width = new_width,
					height = new_height,
					row = new_row,
					col = new_col,
				})
			end,
		}),

		close = vim.api.nvim_create_autocmd("WinClosed", {
			pattern = tostring(self.win),
			callback = function()
				self:close()
			end,
		}),
	}
end

function Terminal:_delete_autocmds()
	if self._autocmds == nil then
		return
	end

	vim.api.nvim_del_autocmd(self._autocmds.resize)
	vim.api.nvim_del_autocmd(self._autocmds.close)
	self._autocmds = nil
end

---@param opts table?
---@return Terminal
function Terminal.new(opts)
	local self = setmetatable({}, Terminal)
	opts = opts or {}
	self.buf = nil
	self.win = nil
	self.cmd = opts.cmd
	self.on_exit = opts.on_exit
	self.on_stdout = opts.on_stdout
	self.is_open = false
	self._autocmds = nil
	return self
end

function Terminal:open()
	if self.is_open then
		return
	end

	if self.buf == nil then
		local cmd = (type(self.cmd) == "string" or type(self.cmd) == "table") and self.cmd
			or type(self.cmd) == "function" and self.cmd()
			or vim.env.SHELL

		self.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[self.buf].bufhidden = "wipe"

		self:_open_window()

		vim.fn.jobstart(cmd, {
			term = true,
			on_exit = vim.schedule_wrap(function()
				if self.on_exit then
					self.on_exit()
				end

				self:close()
			end),
			on_stdout = vim.schedule_wrap(function(_, data)
				if self.on_stdout then
					self.on_stdout(data)
				end
			end),
		})
	else
		self:_open_window()
	end

	self:_create_autocmds()

	self.is_open = true
end

function Terminal:close()
	if not self.is_open then
		return
	end

	self.buf = nil
	self:_delete_autocmds()
	self:_close_window()

	self.is_open = false
end

function Terminal:hide()
	if not self.is_open then
		return
	end

	self:_delete_autocmds()
	self:_hide_window()

	self.is_open = false
end

function Terminal:toggle()
	if self.is_open then
		self:hide()
	else
		self:open()
	end
end

---@type table<string,Terminal>
local terminals = {}

---@param opts table?
---@return Terminal
M.new = function(opts)
	return Terminal.new(opts)
end

---@param name string
---@param opts table?
M.open = function(name, opts)
	terminals[name] = Terminal.new(opts)
	terminals[name]:open()
end

---@param name string
M.close = function(name)
	local term = terminals[name]
	if term then
		term:close()
	end
end

---@param name string
---@param opts table?
M.toggle = function(name, opts)
	local term = terminals[name]
	if term then
		term:toggle()
	else
		M.open(name, opts)
	end
end

return M
