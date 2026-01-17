---@type vim.lsp.Config
return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
				extraArgs = { "--no-deps" },
			},
			cargo = {
				allTargets = false,
			},
			diagnostics = {
				experimental = {
					enable = true,
				},
			},
			cachePriming = {
				enable = false,
			},
		},
	},
	capabilities = {
		experimental = {
			serverStatusNotification = true,
		},
	},
	before_init = function(init_params, config)
		init_params.initializationOptions = config.settings["rust-analyzer"]
	end,
	root_markers = { "Cargo.toml" },
}
