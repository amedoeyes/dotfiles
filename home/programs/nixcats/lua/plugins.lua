if nixCats("general") then
	require("eyes").setup({
		extend = {
			highlights = {
				FloatShadow = { bg = "#404040", blend = 80 },
				FloatShadowThrough = { bg = "#404040", blend = 100 },
				PmenuBorder = { link = "FloatBorder" },
				PmenuShadow = { link = "FloatShadow" },
				PmenuShadowThrough = { link = "FloatShadowThrough" },

				MiniPickBorder = { link = "Border" },
				MiniPickBorderBusy = { link = "MiniPickBorderBusy" },
				MiniPickBorderText = { link = "Mute" },
				MiniPickCursor = { blend = 100 },
				MiniPickIconDirectory = { link = "Icon" },
				MiniPickIconFile = { link = "Icon" },
				MiniPickHeader = { link = "Title" },
				MiniPickMatchCurrent = { link = "PmenuMatchSel" },
				MiniPickMatchMarked = { link = "Visual" },
				MiniPickMatchRanges = { link = "MiniPickMatchRanges" },
				MiniPickNormal = { link = "Normal" },
				MiniPickPreviewLine = { link = "CursorLine" },
				MiniPickPreviewRegion = { link = "MiniPickPreviewLine" },
				MiniPickPrompt = { fg = "fg" },
				MiniPickPromptCaret = { fg = "fg" },
				MiniPickPromptPrefix = { link = "Mute" },
			},
		},
	})

	vim.cmd.colorscheme("eyes")

	vim.opt.rtp:prepend(require("nixCats").pawsible.allPlugins.start["nvim-treesitter"] .. "/runtime")

	require("mini.ai").setup()

	require("mini.diff").setup({
		view = {
			style = "sign",
			signs = {
				add = "▎",
				change = "▎",
				delete = "",
			},
		},
	})

	require("mini.extra").setup()

	require("mini.icons").setup()

	require("mini.pick").setup({
		mappings = {
			choose = "<C-y>",
			choose_marked = "<M-y>",
		},
		window = {
			config = function()
				local padding = (vim.o.winborder == "" or vim.o.winborder == "none") and 0 or 2

				local width = math.floor(vim.o.columns * 0.9)
				local height = math.floor(vim.o.lines * 0.9)
				local row = math.floor((vim.o.lines - height) * 0.5)
				local col = math.floor((vim.o.columns - width) * 0.5)

				width = math.max(1, width - padding)
				height = math.max(1, height - padding)

				return {
					anchor = "NW",
					height = height,
					width = width,
					row = row,
					col = col,
				}
			end,
			prompt_prefix = " ",
		},
	})

	require("mini.surround").setup({
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

	vim.keymap.set("n", "<leader>go", require("mini.diff").toggle_overlay)

	vim.keymap.set("n", "<leader>ff", require("mini.pick").builtin.files)
	vim.keymap.set("n", "<leader>fo", require("mini.extra").pickers.oldfiles)
	vim.keymap.set("n", "<leader>fs", require("mini.pick").builtin.grep_live)
	vim.keymap.set("n", "<leader>bf", require("mini.pick").builtin.buffers)
	vim.keymap.set("n", "<leader>ph", require("mini.pick").builtin.help)
	vim.keymap.set("n", "<leader>pr", require("mini.pick").builtin.resume)

	local function on_list(opts)
		vim.fn.setqflist({}, " ", opts)

		if #opts.items == 1 then
			vim.cmd.cfirst()
		else
			require("mini.extra").pickers.list({ scope = "quickfix" }, { source = { name = opts.title } })
		end

		vim.fn.setqflist({})
	end

	vim.keymap.set("n", "grD", function()
		vim.lsp.buf.declaration({ on_list = on_list })
	end)

	vim.keymap.set("n", "grd", function()
		vim.lsp.buf.definition({ on_list = on_list })
	end)

	vim.keymap.set("n", "gri", function()
		vim.lsp.buf.implementation({ on_list = on_list })
	end)

	vim.keymap.set("n", "grr", function()
		vim.lsp.buf.references(nil, { on_list = on_list })
	end)

	vim.keymap.set("n", "grt", function()
		vim.lsp.buf.type_definition({ on_list = on_list })
	end)
end
