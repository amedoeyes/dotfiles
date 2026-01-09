require("eyes").setup({
	highlights = {
		plugins = { "mini.icons", "mini.pick" },
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

