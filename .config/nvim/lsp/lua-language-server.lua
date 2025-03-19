---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			codeLens = { enable = true },
			completion = {
				callSnippet = "Replace",
				keywordSnippet = "Both",
			},
			format = { enable = false },
			hint = { enable = true },
			window = {
				progressBar = false,
				statusBar = false,
			},
			workspace = {
				checkThirdParty = "ApplyInMemory",
				userThirdParty = { vim.env.HOME .. "/development/lls_addons" },
			},
		},
	},
}
