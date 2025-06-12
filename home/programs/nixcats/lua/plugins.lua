if nixCats("general") then
	vim.cmd.colorscheme("eyes")

	local blink = require("blink.cmp")
	local fzf = require("fzf-lua")
	local ai = require("mini.ai")
	local align = require("mini.align")
	local clue = require("mini.clue")
	local diff = require("mini.diff")
	local icons = require("mini.icons")
	local move = require("mini.move")
	local operators = require("mini.operators")
	local pairs = require("mini.pairs")
	local splitjoin = require("mini.splitjoin")
	local surround = require("mini.surround")
	local null_ls = require("null-ls")
	local treesitter = require("nvim-treesitter.configs")
	local file_explorer = require("plugins.file_explorer")
	local terminal = require("plugins.terminal")
	local toggle = require("plugins.toggle")

	blink.setup({
		completion = {
			list = {
				selection = { auto_insert = false },
			},
		},
		appearance = {
			kind_icons = {
				Class = "",
				Color = "",
				Constant = "",
				Constructor = "",
				Enum = "",
				EnumMember = "",
				Event = "",
				Field = "",
				File = "",
				Folder = "",
				Function = "",
				Interface = "",
				Keyword = "",
				Method = "",
				Module = "",
				Operator = "",
				Property = "",
				Reference = "",
				Snippet = "",
				Struct = "",
				Text = "",
				TypeParameter = "",
				Unit = "",
				Value = "󰎠",
				Variable = "",
			},
		},
	})

	fzf.config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
	fzf.register_ui_select()
	fzf.setup({
		winopts = {
			border = "none",
			backdrop = 100,
			preview = { title = false, border = vim.o.winborder },
		},
	})

	ai.setup()

	align.setup()

	clue.setup({
		triggers = {
			{ keys = "'", mode = "n" },
			{ keys = "'", mode = "x" },
			{ keys = "<C-r>", mode = "c" },
			{ keys = "<C-r>", mode = "i" },
			{ keys = "<C-w>", mode = "n" },
			{ keys = "<C-x>", mode = "i" },
			{ keys = "<leader>", mode = "n" },
			{ keys = "<leader>", mode = "x" },
			{ keys = "[", mode = "n" },
			{ keys = "]", mode = "n" },
			{ keys = "`", mode = "n" },
			{ keys = "`", mode = "x" },
			{ keys = "g", mode = "n" },
			{ keys = "g", mode = "x" },
			{ keys = "z", mode = "n" },
			{ keys = "z", mode = "x" },
			{ keys = '"', mode = "n" },
			{ keys = '"', mode = "x" },
		},
		clues = {
			clue.gen_clues.builtin_completion(),
			clue.gen_clues.g(),
			clue.gen_clues.marks(),
			clue.gen_clues.registers(),
			clue.gen_clues.windows(),
			clue.gen_clues.z(),
		},
	})

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

	move.setup()

	operators.setup({
		evaluate = { prefix = "go=" },
		exchange = { prefix = "gox" },
		multiply = { prefix = "gom" },
		replace = { prefix = "gor" },
		sort = { prefix = "gos" },
	})

	pairs.setup()

	splitjoin.setup()

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

	null_ls.setup({
		border = vim.o.winborder,
		on_attach = function(client, buf)
			vim.bo[buf].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:1000})"
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("eyes.lsp.autoformat", { clear = false }),
				buffer = buf,
				callback = function()
					if not vim.g.autoformat then
						return
					end
					vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end,
		sources = {
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.stylua,
		},
	})

	treesitter.setup({
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	})

	file_explorer.setup()

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

	vim.keymap.set("n", "<leader>fe", function()
		local buf_name = vim.api.nvim_buf_get_name(0)
		if vim.fn.isdirectory(buf_name) ~= 1 then
			file_explorer.toggle(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h"))
		else
			file_explorer.toggle(buf_name)
		end
	end, { desc = "File explorer" })

	vim.keymap.set({ "n", "t" }, "<c-/>", function()
		terminal.toggle({ vim.env.SHELL }, { name = "shell" })
	end, { desc = "Terminal" })

	vim.keymap.set("n", "<leader>gg", function()
		terminal.toggle({ "lazygit" }, { name = "lazygit" })
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

	vim.keymap.set("n", "<leader>tp", function()
		toggle.create({
			name = "Auto-Pairs",
			get = function()
				return not vim.g.minipairs_disable
			end,
			set = function(state)
				vim.g.minipairs_disable = not state
			end,
		})()
	end, { desc = "Toggle auto-pair" })

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
	local render_markdown = require("render-markdown")
	local writemode = require("plugins.writemode")

	render_markdown.setup({
		render_modes = true,
		heading = {
			icons = {
				"█ ",
				"██ ",
				"███ ",
				"████ ",
				"█████ ",
				"██████ ",
			},
			border = true,
			border_virtual = true,
			border_prefix = true,
		},
		code = {
			style = "full",
			position = "right",
			disable_background = {},
			width = "block",
			border = "thick",
			inline_pad = 1,
			left_pad = 2,
			right_pad = 2,
			min_width = 80,
			highlight_language = "Comment",
		},
		sign = { enabled = false },
		latex = { enabled = false },
		overrides = {
			buftype = {
				nofile = {
					anti_conceal = {
						ignore = {
							bullet = { "n" },
							callout = { "n" },
							check_icon = { "n" },
							check_scope = { "n" },
							code_background = true,
							code_border = { "n" },
							code_language = { "n" },
							dash = { "n" },
							head_background = true,
							head_border = { "n" },
							head_icon = { "n" },
							link = { "n" },
							quote = { "n" },
							table_border = { "n" },
						},
					},
					heading = {
						position = "inline",
						border = false,
						border_virtual = false,
						border_prefix = false,
						backgrounds = {},
					},
					code = {
						language_icon = false,
						language_name = false,
						left_pad = 0,
						right_pad = 0,
						min_width = 0,
						inline_pad = 0,
						border = "hide",
						highlight = "None",
						highlight_language = "None",
						highlight_border = "None",
						highlight_fallback = "None",
						highlight_inline = "None",
					},
					win_options = {
						conceallevel = { default = 0, rendered = 3 },
						concealcursor = { default = "", rendered = "nvic" },
					},
				},
			},
		},
	})

	writemode.setup()
end
