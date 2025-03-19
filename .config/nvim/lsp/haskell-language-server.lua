---@type vim.lsp.Config
return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	filetypes = { "haskell" },
	settings = {
		haskell = {
			formattingProvider = "ormolu",
			cabalFormattingProvider = "cabalfmt",
		},
	},
	root_markers = { "*.cabal" },
}
