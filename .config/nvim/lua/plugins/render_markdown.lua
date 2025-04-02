require("mini.deps").later(
	function()
		require("render-markdown").setup({
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
							conceallevel = { rendered = 3 },
							concealcursor = { rendered = "nvic" },
						},
					},
				},
			},
		})
	end
)
