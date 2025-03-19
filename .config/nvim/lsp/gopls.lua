---@type vim.lsp.Config
return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod" },
	settings = {
		gopls = {
			gofumpt = true,
			codelenses = { test = true },
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = { shadow = true },
			usePlaceholders = true,
			staticcheck = true,
			semanticTokens = true,
		},
	},
	root_markers = { "go.work", "go.mod" },
}
