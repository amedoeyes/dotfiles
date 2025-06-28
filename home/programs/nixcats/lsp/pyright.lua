---@type vim.lsp.Config
return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
	root_markers = { "pyproject.toml", "requirements.txt" },
}
