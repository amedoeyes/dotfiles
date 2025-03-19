require("mini.deps").later(
	function()
		require("blink.cmp").setup({
			completion = {
				keyword = { range = "full" },
				list = {
					selection = {
						auto_insert = false,
					},
				},
				menu = { border = vim.o.winborder },
				documentation = {
					window = { border = vim.o.winborder },
				},
			},
			signature = {
				window = { border = vim.o.winborder },
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
	end
)
