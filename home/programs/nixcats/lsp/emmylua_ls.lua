---@type vim.lsp.Config
return {
	cmd = { "emmylua_ls" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".emmyrc.json" },
	settings = {
		Lua = {
			format = {
				externalTool = {
					program = "stylua",
					args = {
						"--stdin-filepath=${file}",
						"-",
					},
				},
				externalToolRangeFormat = {
					program = "stylua",
					args = {
						"--stdin-filepath=${file}",
						"--indent-width=${indent_size}",
						"--indent-type=${use_tabs?Tabs:Spaces}",
						"--range-start=${start_offset}",
						"--range-end=${end_offset}",
						"-",
					},
				},
			},
		},
	},
}
