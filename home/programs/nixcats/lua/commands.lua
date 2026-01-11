vim.api.nvim_create_user_command("Scratch", function(opts)
	local ft = opts.args ~= "" and opts.args or "text"
	local name = string.format("/tmp/scratch-%d.%s", os.time(), ft)
	vim.cmd.enew()
	vim.cmd.file(name)
	vim.bo.bufhidden = "wipe"
	vim.bo.swapfile = false
	vim.bo.buflisted = false
	vim.bo.filetype = ft
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
