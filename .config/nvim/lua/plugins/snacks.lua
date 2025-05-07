require("mini.deps").now(function()
	Snacks.setup({
		notifier = {
			enabled = true,
			style = function(buf, notif)
				local lines = vim.split(notif.icon .. " " .. notif.msg, "\n")
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			end,
		},
		picker = {
			sources = {
				command_history = { layout = "select" },
				icons = { layout = "select" },
				search_history = { layout = "select" },
				spelling = { layout = "select" },
			},
			layouts = {
				default = {
					layout = {
						box = "horizontal",
						width = 0.8,
						min_width = 120,
						height = 0.8,
						{
							box = "vertical",
							border = vim.o.winborder,
							title = "{title} {live} {flags}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list" },
						},
						{ win = "preview", title = "{preview}", border = vim.o.winborder, width = 0.5 },
					},
				},
				vertical = { layout = { border = vim.o.winborder } },
				select = { layout = { border = vim.o.winborder } },
			},
			win = {
				input = {
					keys = {
						["<c-y>"] = { "confirm", mode = { "n", "i" } },
					},
				},
			},
		},
		statuscolumn = { enabled = true },
		styles = {
			blame_line = { border = vim.o.winborder },
			lazygit = { border = vim.o.winborder },
			notification = { border = vim.o.winborder },
			terminal = { border = vim.o.winborder },
		},
	})

	vim.g.snacks_animate = false

	local toggle = Snacks.toggle

	toggle.option("spell", { name = "Spell", global = true })
	toggle.option("wrap", { global = true })
	toggle.option("statuscolumn", { on = vim.o.statuscolumn, off = "", global = true })

	toggle.new({
		name = "Auto-Pairs",
		get = function() return not vim.g.minipairs_disable end,
		set = function(state) vim.g.minipairs_disable = not state end,
	})
	toggle.new({
		name = "Auto-Format",
		get = function() return vim.g.autoformat end,
		set = function(state) vim.g.autoformat = state end,
	})
	toggle.new({
		name = "Codelens",
		get = function() return vim.g.codelens end,
		set = function(state)
			vim.g.codelens = state
			if state then
				vim.lsp.codelens.refresh()
			else
				vim.lsp.codelens.clear()
			end
		end,
	})
	toggle.new({
		id = "writemode",
		name = "Write mode",
		get = function() return vim.g.writemode end,
		set = function(state)
			if state then
				toggle.get("spell"):set(true)
				toggle.get("wrap"):set(true)
				toggle.get("statuscolumn"):set(false)
				toggle.get("line_number"):set(false)
				vim.g.writemodebuf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_name(vim.g.writemodebuf, "padding")
				local lwin = vim.api.nvim_open_win(vim.g.writemodebuf, false, {
					split = "left",
					focusable = false,
					style = "minimal",
				})
				local rwin = vim.api.nvim_open_win(vim.g.writemodebuf, false, {
					split = "right",
					focusable = false,
					style = "minimal",
				})
				local set_width = function()
					local width = math.floor((vim.o.columns - vim.o.textwidth - 80) / 2)
					vim.api.nvim_win_set_width(lwin, width)
					vim.api.nvim_win_set_width(rwin, width)
				end
				set_width()
				vim.g.writemodehl = vim.api.nvim_get_hl(0, { name = "WinSeparator" })
				vim.api.nvim_set_hl(0, "WinSeparator", { fg = "bg" })
				vim.api.nvim_create_autocmd("VimResized", {
					group = vim.api.nvim_create_augroup("writemode", { clear = false }),
					callback = function() set_width() end,
				})
				vim.api.nvim_create_autocmd("WinClosed", {
					pattern = tostring(vim.api.nvim_get_current_win()),
					group = vim.api.nvim_create_augroup("writemode", { clear = false }),
					callback = function()
						toggle.get("writemode"):set(false)
						if #vim.api.nvim_list_wins() == 1 then vim.cmd("quit") end
					end,
				})
				local win = vim.api.nvim_get_current_win()
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = "padding",
					group = vim.api.nvim_create_augroup("writemode", { clear = false }),
					callback = function() vim.api.nvim_set_current_win(win) end,
				})
			else
				toggle.get("spell"):set(false)
				toggle.get("wrap"):set(false)
				toggle.get("statuscolumn"):set(true)
				toggle.get("line_number"):set(true)
				vim.api.nvim_buf_delete(vim.g.writemodebuf, { force = true })
				vim.api.nvim_set_hl(0, "WinSeparator", vim.g.writemodehl)
				vim.api.nvim_clear_autocmds({ group = "writemode" })
			end
			vim.g.writemode = state
		end,
	})

	toggle.get("auto_format"):map("<leader>tf")
	toggle.get("auto_pairs"):map("<leader>tp")
	toggle.get("codelens"):map("<leader>tl")
	toggle.get("diagnostics"):map("<leader>td")
	toggle.get("inlay_hints"):map("<leader>th")
	toggle.get("spell"):map("<leader>ts")

	vim.api.nvim_create_user_command("WriteMode", function()
		local writemode = Snacks.toggle.get("writemode")
		if writemode then writemode:set(not writemode:get()) end
	end, {})

	local picker = Snacks.picker

	vim.keymap.set("n", "<leader><space>", picker.smart, { desc = "Smart find file" })

	vim.keymap.set("n", "<leader>ff", picker.files, { desc = "Find file" })
	vim.keymap.set("n", "<leader>fr", picker.recent, { desc = "Find recent file" })
	vim.keymap.set("n", "<leader>fs", picker.grep, { desc = "Search files" })

	vim.keymap.set("n", "<leader>gL", picker.git_log_line, { desc = "Git blame line" })
	vim.keymap.set("n", "<leader>gd", picker.git_diff, { desc = "Git diff" })
	vim.keymap.set("n", "<leader>gf", picker.git_log_file, { desc = "Git log file" })
	vim.keymap.set("n", "<leader>gg", Snacks.lazygit.open, { desc = "Lazygit" })
	vim.keymap.set("n", "<leader>gl", picker.git_log, { desc = "Git log" })

	vim.keymap.set("n", "<leader>bD", picker.diagnostics_buffer, { desc = "Buffer diagnostics" })
	vim.keymap.set("n", "<leader>bf", picker.buffers, { desc = "Find buffer" })
	vim.keymap.set("n", "<leader>bs", picker.lines, { desc = "Search buffer" })

	vim.keymap.set("n", "<leader>pd", picker.diagnostics, { desc = "Diagnostics" })
	vim.keymap.set("n", "<leader>ph", picker.help, { desc = "Help tags" })
	vim.keymap.set("n", "<leader>pm", picker.man, { desc = "Man pages" })
	vim.keymap.set("n", "<leader>pp", picker.pickers, { desc = "Pickers" })
	vim.keymap.set("n", "<leader>pr", picker.resume, { desc = "Resume" })
	vim.keymap.set("n", "<leader>pu", picker.undo, { desc = "Undolist" })

	vim.keymap.set("n", "gO", picker.lsp_symbols, { desc = "Document symbols" })
	vim.keymap.set("n", "grD", picker.lsp_declarations, { desc = "Declaration" })
	vim.keymap.set("n", "grd", picker.lsp_definitions, { desc = "Definition" })
	vim.keymap.set("n", "gri", picker.lsp_implementations, { desc = "Implementation" })
	vim.keymap.set("n", "grr", picker.lsp_references, { nowait = true, desc = "References" })
	vim.keymap.set("n", "grS", picker.lsp_workspace_symbols, { desc = "Workspace symbols" })
	vim.keymap.set("n", "grs", picker.lsp_symbols, { desc = "Symbols" })
	vim.keymap.set("n", "grt", picker.lsp_type_definitions, { desc = "Type definition" })
	vim.keymap.set({ "n", "x" }, "gW", picker.grep_word, { desc = "grep word" })

	vim.keymap.set(
		{ "n", "t" },
		"<c-/>",
		function() Snacks.terminal.toggle(vim.env.SHELL) end,
		{ desc = "Terminal" }
	)

	vim.keymap.set(
		"n",
		"[[",
		function() Snacks.words.jump(-vim.v.count1, true) end,
		{ desc = "Previous reference" }
	)
	vim.keymap.set(
		"n",
		"]]",
		function() Snacks.words.jump(vim.v.count1, true) end,
		{ desc = "Next reference" }
	)
end)
