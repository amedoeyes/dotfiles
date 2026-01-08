if nixCats("general") then
	vim.cmd.colorscheme("eyes")
	vim.api.nvim_set_hl(0, "FloatShadow", { bg = "#404040", blend = 80 })
	vim.api.nvim_set_hl(0, "FloatShadowThrough", { bg = "#404040", blend = 100 })
	vim.api.nvim_set_hl(0, "PmenuBorder", { link = "FloatBorder" })
	vim.api.nvim_set_hl(0, "PmenuShadow", { link = "FloatShadow" })
	vim.api.nvim_set_hl(0, "PmenuShadowThrough", { link = "FloatShadowThrough" })

	local fzf = require("fzf-lua")
	local ai = require("mini.ai")
	local diff = require("mini.diff")
	local icons = require("mini.icons")
	local surround = require("mini.surround")
	local terminal = require("plugins.terminal")
	local toggle = require("plugins.toggle")

	vim.opt.rtp:prepend(require("nixCats").pawsible.allPlugins.start["nvim-treesitter"] .. "/runtime")

	fzf.register_ui_select()
	fzf.setup({
		winopts = {
			width = 0.90,
			height = 0.90,
			row = 0.5,
			col = 0.5,
			border = "none",
			backdrop = 100,
			preview = {
				title = false,
				scrollbar = false,
				hidden = true,
				border = vim.o.winborder,
			},
		},
		fzf_opts = {
			["--list-border"] = "sharp",
			["--preview-border"] = "sharp",
		},
		fzf_colors = { true },
		keymap = {
			builtin = {
				["<C-/>"] = "toggle-preview",
			},
		},
	})

	ai.setup()

	diff.setup({
		view = {
			style = "sign",
			signs = {
				add = "▎",
				change = "▎",
				delete = "",
			},
		},
	})

	icons.setup({
		extension = {
			h = { glyph = "" },
			hpp = { glyph = "" },
		},
		filetype = {
			c = { glyph = "" },
			cpp = { glyph = "" },
			cs = { glyph = "" },
		},
	})

	package.preload["nvim-web-devicons"] = function()
		icons.mock_nvim_web_devicons()
		return package.loaded["nvim-web-devicons"]
	end

	surround.setup({
		mappings = {
			add = "gsa",
			delete = "gsd",
			find = "gsf",
			find_left = "gsF",
			highlight = "gsh",
			replace = "gsr",
			update_n_lines = "gsn",
		},
	})

	vim.keymap.set("n", "<leader>go", function()
		diff.toggle_overlay(0)
	end, { desc = "Git diff overlay" })

	vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find file" })
	vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Find recent file" })
	vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep<cr>", { desc = "Search files" })

	vim.keymap.set("n", "<leader>bf", "<cmd>FzfLua buffers<cr>", { desc = "Find buffer" })
	vim.keymap.set("n", "<leader>bs", "<cmd>FzfLua lines<cr>", { desc = "Search buffer" })

	vim.keymap.set("n", "<leader>ph", "<cmd>FzfLua helptags<cr>", { desc = "Help tags" })
	vim.keymap.set("n", "<leader>pm", "<cmd>FzfLua manpages<cr>", { desc = "Man pages" })
	vim.keymap.set("n", "<leader>pp", "<cmd>FzfLua<cr>", { desc = "Pickers" })
	vim.keymap.set("n", "<leader>pr", "<cmd>FzfLua resume<cr>", { desc = "Resume" })

	vim.keymap.set("n", "grD", "<cmd>FzfLua lsp_declarations<cr>", { desc = "Declaration" })
	vim.keymap.set("n", "grd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Definition" })
	vim.keymap.set("n", "gri", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Implementation" })
	vim.keymap.set(
		"n",
		"grr",
		"<cmd>FzfLua lsp_references<cr>",
		{ nowait = true, desc = "References" }
	)
	vim.keymap.set(
		"n",
		"grS",
		"<cmd>FzfLua lsp_workspace_symbols<cr>",
		{ desc = "Workspace symbols" }
	)
	vim.keymap.set("n", "grs", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Symbols" })
	vim.keymap.set("n", "grt", "<cmd>FzfLua lsp_typedefs<cr>", { desc = "Type definition" })
	vim.keymap.set({ "n", "x" }, "gW", "<cmd>FzfLua grep_cword<cr>", { desc = "grep word" })

	vim.keymap.set({ "n", "t" }, "<c-/>", function()
		terminal.toggle("shell")
	end, { desc = "Terminal" })

	vim.keymap.set("n", "<leader>fe", function()
		terminal.toggle("file_explorer", {
			cmd = function()
				local buf_name = vim.api.nvim_buf_get_name(0)
				return {
					"vifm",
					"--on-choose",
					"nvim --server "
						.. vim.v.servername
						.. ' --remote-expr "nvim_exec2(\\"quit | edit %f:p\\", {})"',
					"--select",
					buf_name ~= "" and buf_name or vim.env.PWD,
					vim.fn.isdirectory(buf_name) ~= 1 and vim.fn.fnamemodify(buf_name, ":h") or buf_name,
				}
			end,
		})
	end, { desc = "File explorer" })

	vim.keymap.set("n", "<leader>gg", function()
		terminal.toggle("lazygit", { cmd = "lazygit" })
	end, { desc = "Lazygit" })

	vim.keymap.set("n", "<leader>tf", function()
		toggle.create({
			name = "Auto-Format",
			get = function()
				return vim.g.autoformat
			end,
			set = function(state)
				vim.g.autoformat = state
			end,
		})()
	end, { desc = "Toggle auto-format" })

	vim.keymap.set("n", "<leader>tl", function()
		toggle.create({
			name = "Codelens",
			get = function()
				return vim.g.codelens
			end,
			set = function(state)
				vim.g.codelens = state
				if state then
					vim.lsp.codelens.refresh()
				else
					vim.lsp.codelens.clear()
				end
			end,
		})()
	end, { desc = "Toggle codelens" })

	vim.keymap.set("n", "<leader>td", function()
		toggle.create({
			name = "Diagnostics",
			get = function()
				return vim.diagnostic.is_enabled()
			end,
			set = function(state)
				vim.diagnostic.enable(state)
			end,
		})()
	end, { desc = "Toggle diagnostics" })

	vim.keymap.set("n", "<leader>ti", function()
		toggle.create({
			name = "Diagnostics",
			get = function()
				return vim.lsp.inlay_hint.is_enabled()
			end,
			set = function(state)
				vim.lsp.inlay_hint.enable(state)
			end,
		})()
	end, { desc = "Toggle inlay-hints" })

	vim.keymap.set("n", "<leader>ts", function()
		toggle.create_option("spell", { name = "Spell" })()
	end, { desc = "Toggle spell" })
end

if nixCats("markdown") then
	local writemode = require("plugins.writemode")

	writemode.setup()
end
