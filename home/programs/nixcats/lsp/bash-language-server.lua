---@type vim.lsp.Config
return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "zsh" },
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
			shellcheckArguments = "--exclude=SC2164",
		},
	},
}
