---@type vim.lsp.Config
return {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = "typstyle",
	},
	capabilities = {
		textDocument = { formatting = {} },
	},
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = true
	end,
}
