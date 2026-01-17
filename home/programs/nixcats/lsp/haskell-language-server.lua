---@type vim.lsp.Config
return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	filetypes = { "haskell" },
	root_markers = { "*.cabal" },
}
