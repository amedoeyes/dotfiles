---@type vim.lsp.Config
return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json", "tsconfig.json" },
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
}
