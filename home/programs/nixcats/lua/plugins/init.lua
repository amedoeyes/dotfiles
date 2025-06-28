local fe = require("plugins.file_explorer")

fe.setup()

vim.keymap.set("n", "<leader>fe", function()
	local buf_name = vim.api.nvim_buf_get_name(0)
	if vim.fn.isdirectory(buf_name) ~= 1 then
		fe.toggle(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h"))
	else
		fe.toggle(buf_name)
	end
end, { desc = "File explorer" })

local term = require("plugins.terminal")

vim.keymap.set({ "n", "t" }, "<c-/>", function()
	term.toggle({ vim.env.SHELL }, { name = "shell" })
end, { desc = "Terminal" })

vim.keymap.set("n", "<leader>gg", function()
	term.toggle({ "lazygit" }, { name = "lazygit" })
end, { desc = "Lazygit" })

local toggle = require("plugins.toggle")

vim.keymap.set("n", "<leader>tf", function()
	toggle.create({
		name = "Auto-Format",
		get = function()
			return vim.g.autoformat
		end,
		set = function(state)
			vim.g.autoformat = state
		end,
	})()
end, { desc = "Toggle auto-format" })

vim.keymap.set("n", "<leader>tp", function()
	toggle.create({
		name = "Auto-Pairs",
		get = function()
			return not vim.g.minipairs_disable
		end,
		set = function(state)
			vim.g.minipairs_disable = not state
		end,
	})()
end, { desc = "Toggle auto-pair" })

vim.keymap.set("n", "<leader>tl", function()
	toggle.create({
		name = "Codelens",
		get = function()
			return vim.g.codelens
		end,
		set = function(state)
			vim.g.codelens = state
			if state then
				vim.lsp.codelens.refresh()
			else
				vim.lsp.codelens.clear()
			end
		end,
	})()
end, { desc = "Toggle auto-pair" })

vim.keymap.set("n", "<leader>td", function()
	toggle.create({
		name = "Diagnostics",
		get = function()
			return vim.diagnostic.is_enabled()
		end,
		set = function(state)
			vim.diagnostic.enable(state)
		end,
	})()
end, { desc = "Toggle diagnostics" })

vim.keymap.set("n", "<leader>ti", function()
	toggle.create({
		name = "Diagnostics",
		get = function()
			return vim.lsp.inlay_hint.is_enabled()
		end,
		set = function(state)
			vim.lsp.inlay_hint.enable(state)
		end,
	})()
end, { desc = "Toggle inlay-hints" })

vim.keymap.set("n", "<leader>ts", function()
	toggle.create_option("spell", { name = "Spell" })()
end, { desc = "Toggle spell" })

require("plugins.writemode").setup()
