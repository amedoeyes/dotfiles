---@type vim.lsp.Config
return {
	cmd = { "haskell-language-server-9.12.2", "--lsp" },
	filetypes = { "haskell" },
	root_markers = { "*.cabal" },
}
