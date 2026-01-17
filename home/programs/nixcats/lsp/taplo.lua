---@type vim.lsp.Config
return {
	cmd = { "taplo", "lsp", "stdio" },
	root_markers = { ".taplo.toml", "taplo.toml" },
	filetypes = { "toml" },
}
