---@type vim.lsp.Config
return {
	cmd = {
		"omnisharp",
		"-z",
		"-hpid",
		tostring(vim.fn.getpid()),
		"DotNet:enablePackageRestore=false",
		"-lsp",
	},
	filetypes = { "cs" },
	root_markers = { "*.csproj" },
}
