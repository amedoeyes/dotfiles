---@type vim.lsp.Config
return {
	cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
	filetypes = { "c", "cpp" },
	root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json" },
}
