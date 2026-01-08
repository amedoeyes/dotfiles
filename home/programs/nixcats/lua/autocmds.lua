vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("eyes.treesitter", { clear = true }),
	callback = function(e)
		local ok = pcall(vim.treesitter.start, e.buf)
		if ok then
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("eyes.checktime", { clear = true }),
	command = "checktime",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("eyes.highlight_yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("eyes.last_loc", { clear = true }),
	callback = function(e)
		vim.b[e.buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(e.buf, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(e.buf) then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "VimEnter" }, {
	group = vim.api.nvim_create_augroup("eyes.git_branch", { clear = true }),
	callback = function()
		local git_dir = vim.fs.root(0, ".git")
		if git_dir then
			local fd = vim.uv.fs_open(git_dir .. "/.git/HEAD", "r", 438)
			if fd then
				local stat = vim.uv.fs_fstat(fd)
				if stat then
					local data = vim.uv.fs_read(fd, stat.size, 0)
					vim.uv.fs_close(fd)
					if data then
						vim.g.git_branch = data:match("ref: refs/heads/(.+)\n")
					end
				end
			end
		end
	end,
})
