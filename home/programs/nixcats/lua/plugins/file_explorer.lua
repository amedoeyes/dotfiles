local M = {}

local function open(path, term_func)
	local tempname = vim.fn.tempname()

	local curr_buf = vim.fn.bufnr("%")
	local curr_buf_name = vim.api.nvim_buf_get_name(curr_buf)

	local curr_win = vim.api.nvim_get_current_win()

	term_func({
		"vifm",
		"--choose-files",
		tempname,
		"--select",
		curr_buf_name ~= "" and curr_buf_name or vim.env.PWD,
		path,
	}, {
		name = "file_explorer",
		on_exit = function()
			vim.api.nvim_set_current_win(curr_win)

			local has_files = false
			local tempfile = io.open(tempname, "r")
			if tempfile then
				local files = vim.split(tempfile:read("*all"), "\n", { trimempty = true })
				tempfile:close()
				os.remove(tempname)
				for _, file in ipairs(files) do
					if vim.fn.isdirectory(file) ~= 1 then
						has_files = true
						vim.cmd.edit(vim.fn.fnameescape(file))
					end
				end
			end

			if has_files and vim.api.nvim_buf_is_valid(curr_buf) then
				vim.fn.setreg("#", curr_buf)
			end
		end,
	})
end

---@param path string
M.open = function(path)
	open(path, require("plugins.terminal").open)
end

M.close = function()
	require("plugins.terminal").close("file_explorer")
end

---@param path string
M.toggle = function(path)
	open(path, require("plugins.terminal").toggle)
end

M.setup = function()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	vim.cmd("silent! autocmd! FileExplorer *")
	vim.cmd("autocmd VimEnter * ++once silent! autocmd! FileExplorer *")

	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("eyes.file_explorer", { clear = true }),
		callback = function(args)
			if vim.b[args.buf].opened then
				return
			end
			local path = vim.api.nvim_buf_get_name(args.buf)
			if vim.fn.isdirectory(path) ~= 1 then
				return
			end
			vim.bo[args.buf].buflisted = false
			vim.bo[args.buf].bufhidden = "wipe"
			vim.b[args.buf].opened = true
			vim.schedule(function()
				M.open(path)
			end)
		end,
	})
end

return M
