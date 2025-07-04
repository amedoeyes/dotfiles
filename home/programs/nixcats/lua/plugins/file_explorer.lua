local M = {}

local terminal = require("plugins.terminal")

---@class FileExplorer
---@field path string
---@field terminal Terminal?
local FileExplorer = {}
FileExplorer.__index = FileExplorer

---@param path string
---@return FileExplorer
function FileExplorer.new(path)
	local self = setmetatable({}, FileExplorer)
	self.path = path
	self.terminal = nil
	return self
end

function FileExplorer:open()
	local curr_buf_name = vim.api.nvim_buf_get_name(vim.fn.bufnr("%"))

	self.terminal = terminal.new({
		cmd = {
			"vifm",
			"--on-choose",
			"nvim --server "
				.. vim.v.servername
				.. ' --remote-expr "nvim_exec2(\\"quit | args %f:p\\", {})"',
			"--select",
			curr_buf_name ~= "" and curr_buf_name or vim.env.PWD,
			self.path,
		},
	})

	self.terminal:open()
end

function FileExplorer:close()
	if self.terminal == nil then
		return
	end

	self.terminal:close()
end

function FileExplorer:toggle()
	if self.terminal == nil then
		self:open()
	else
		self.terminal:toggle()
	end
end

---@type FileExplorer?
local file_explorer = nil

---@param path string
M.open = function(path)
	if file_explorer ~= nil then
		M.close()
	end

	file_explorer = FileExplorer.new(path)
	file_explorer:open()
	file_explorer.terminal.on_exit = function()
		M.close()
	end
end

M.close = function()
	if file_explorer == nil then
		return
	end

	file_explorer:close()
	file_explorer = nil
end

---@param path string
M.toggle = function(path)
	if file_explorer ~= nil then
		M.close()
	else
		M.open(path)
	end
end

M.setup = function()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	vim.cmd("silent! autocmd! FileExplorer *")
	vim.cmd("autocmd VimEnter * ++once silent! autocmd! FileExplorer *")

	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("eyes.file_explorer", { clear = true }),
		callback = function(args)
			local path = vim.api.nvim_buf_get_name(args.buf)
			if vim.fn.isdirectory(path) ~= 1 then
				return
			end

			vim.bo[args.buf].buflisted = false
			vim.bo[args.buf].bufhidden = "wipe"

			vim.schedule(function()
				M.open(path)
			end)
		end,
	})
end

return M
