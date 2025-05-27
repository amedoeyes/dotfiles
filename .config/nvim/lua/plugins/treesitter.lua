require("mini.deps").later(function()
	require("nvim-treesitter.configs").setup({
		auto_install = true,
		ensure_installed = "all",
		ignore_install = {},
		modules = {},
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	})
end)
