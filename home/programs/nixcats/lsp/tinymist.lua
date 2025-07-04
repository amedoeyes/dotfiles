---@type vim.lsp.Config
return {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = "typstyle",
	},
	capabilities = {
		textDocument = { formatting = {} },
	},
}
