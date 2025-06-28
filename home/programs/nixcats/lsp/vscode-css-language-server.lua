---@type vim.lsp.Config
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
	root_markers = { "package.json" },
}
