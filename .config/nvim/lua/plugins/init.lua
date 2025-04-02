local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--depth=1",
		"https://github.com/echasnovski/mini.nvim",
		mini_path,
	})
	vim.cmd("packadd mini.nvim | helptags ALL")
end

local deps = require("mini.deps")

deps.setup({ path = { package = path_package } })

deps.add({
	source = "saghen/blink.cmp",
	depends = { "rafamadriz/friendly-snippets" },
	checkout = "v1.0.0",
})
deps.add("amedoeyes/eyes.nvim")
deps.add({
	source = "MeanderingProgrammer/render-markdown.nvim",
	depends = { "nvim-treesitter/nvim-treesitter" },
})
deps.add("folke/snacks.nvim")
deps.add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = { post_checkout = function() vim.cmd.TSUpdate() end },
})
deps.add({
	source = "nvimtools/none-ls.nvim",
	depends = { "nvim-lua/plenary.nvim" },
})

require("plugins.blink_cmp")
require("plugins.eyes")
require("plugins.mini")
require("plugins.none_ls")
require("plugins.render_markdown")
require("plugins.snacks")
require("plugins.termdebug")
require("plugins.treesitter")
