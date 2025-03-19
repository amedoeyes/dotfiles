require("mini.deps").later(
	function()
		require("render-markdown").setup({
			render_modes = true,
			anti_conceal = {
				ignore = {
					bullet = { "n", "c" },
					callout = { "n", "c" },
					check_icon = { "n", "c" },
					check_scope = { "n", "c" },
					code_background = true,
					code_border = { "n", "c" },
					code_language = { "n", "c" },
					dash = { "n", "c" },
					head_background = true,
					head_border = { "n", "c" },
					head_icon = { "n", "c" },
					link = { "n", "c" },
					quote = { "n", "c" },
					table_border = { "n", "c" },
				},
			},
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
				left_pad = 2,
				right_pad = 2,
				min_width = 80,
				border = "thick",
				highlight_language = "Comment",
			},
			sign = { enabled = false },
			overrides = {
				buftype = {
					nofile = {
						heading = {
							position = "inline",
							border = false,
							border_virtual = false,
							border_prefix = false,
							backgrounds = {},
						},
						code = { style = "none" },
					},
				},
			},
			win_options = {
				conceallevel = { rendered = 2 },
				concealcursor = { rendered = "nc" },
			},
		})
	end
)
