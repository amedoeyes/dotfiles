---@type vim.lsp.Config
return {
	cmd = {
		"clangd",
		"--all-scopes-completion",
		"--background-index",
		"--background-index-priority=normal",
		"--clang-tidy",
		"--completion-style=detailed",
		"--enable-config",
		"--experimental-modules-support",
		"--fallback-style=llvm",
		"--function-arg-placeholders",
		"--header-insertion=never",
		"--limit-references=0",
		"--limit-results=0",
		"--pch-storage=memory",
		"--rename-file-limit=0",
		"-j=4",
	},
	filetypes = { "c", "cpp" },
	root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json" },
}
