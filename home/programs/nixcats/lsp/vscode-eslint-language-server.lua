---@type vim.lsp.Config
return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	settings = {
		codeAction = {
			disableRuleComment = { enable = true },
			showDocumentation = {},
		},
		codeActionOnSave = { enable = false },
		experimental = {},
		format = false,
		nodePath = "",
		onIgnoredFiles = "off",
		problems = {},
		quiet = false,
		rulesCustomizations = {},
		run = "onType",
		validate = "on",
		workingDirectory = { mode = "location" },
	},
}
