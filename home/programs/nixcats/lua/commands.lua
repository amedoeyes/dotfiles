vim.api.nvim_create_user_command("Scratch", function(opts)
	local arg = opts.args ~= "" and opts.args or "txt"
	local name = string.format("/tmp/scratch-%d.%s", os.time(), arg)
	vim.cmd.enew()
	vim.cmd.file(name)
	vim.bo.bufhidden = "wipe"
	vim.bo.swapfile = false
	vim.bo.buflisted = false
	vim.bo.filetype = vim.filetype.match({ filename = name }) or "text"
end, { nargs = "?" })

vim.api.nvim_create_user_command("Watch", function(opts)
	local watcher = vim.uv.new_fs_event()

	local function watch_file()
		if watcher then
			watcher:start(
				vim.fn.fnamemodify(opts.args, ":p"),
				{},
				vim.schedule_wrap(function(err)
					if err then
						watcher:close()
						return
					end
					vim.cmd.checktime()
					watcher:stop()
					watch_file()
				end)
			)
		end
	end

	watch_file()
end, { nargs = 1, complete = "file" })
