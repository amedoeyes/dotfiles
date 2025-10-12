---@type vim.lsp.Config
return {
	cmd = { "lemminx" },
	filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = true
	end,
	settings = {
		xml = {
			server = {
				workDir = vim.env.HOME .. "/.cache/lemminx",
			},
		},
	},
}
