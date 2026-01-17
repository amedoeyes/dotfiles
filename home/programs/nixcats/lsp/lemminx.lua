---@type vim.lsp.Config
return {
	cmd = { "lemminx" },
	filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
	settings = {
		xml = {
			server = {
				workDir = vim.env.XDG_CACHE_HOME .. "/lemminx",
			},
		},
	},
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = true
	end,
}
