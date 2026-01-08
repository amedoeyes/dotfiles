vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true })
vim.keymap.set({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "gK", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })

vim.keymap.set("i", "<C-Space>", function()
	if vim.fn.pumvisible() == 0 then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n", true)
	end
end)

local terminal = require("terminal")

vim.keymap.set({ "n", "t" }, "<c-/>", function()
	terminal.toggle("shell")
end, { desc = "Terminal" })

vim.keymap.set("n", "<leader>fe", function()
	terminal.toggle("file_explorer", {
		cmd = function()
			local buf_name = vim.api.nvim_buf_get_name(0)
			return {
				"vifm",
				"--on-choose",
				"nvim --server "
					.. vim.v.servername
					.. ' --remote-expr "nvim_exec2(\\"quit | edit %f:p\\", {})"',
				"--select",
				buf_name ~= "" and buf_name or vim.env.PWD,
				vim.fn.isdirectory(buf_name) ~= 1 and vim.fn.fnamemodify(buf_name, ":h") or buf_name,
			}
		end,
	})
end, { desc = "File explorer" })

vim.keymap.set("n", "<leader>gg", function()
	terminal.toggle("lazygit", { cmd = "lazygit" })
end, { desc = "Lazygit" })

local toggle = require("toggle")

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
end, { desc = "Toggle codelens" })

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
