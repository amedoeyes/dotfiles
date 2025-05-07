require("mini.deps").later(
	function()
		require("blink.cmp").setup({
			fuzzy = {
				prebuilt_binaries = { force_version = "v1.2.0" },
			},
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
	end
)
