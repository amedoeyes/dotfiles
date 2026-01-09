vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true })
vim.keymap.set({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "gK", function()
	vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end)

vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>")

vim.keymap.set("i", "<C-Space>", function()
	if vim.fn.pumvisible() == 0 then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n", true)
	end
end)

local terminal = require("terminal")

vim.keymap.set({ "n", "t" }, "<c-/>", function()
	terminal.toggle("shell")
end)

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
end)

vim.keymap.set("n", "<leader>gg", function()
	terminal.toggle("lazygit", { cmd = "lazygit" })
end)

local toggle = require("toggle")

vim.keymap.set(
	"n",
	"<leader>tf",
	toggle.create({
		name = "Auto-Format",
		get = function()
			return vim.g.autoformat
		end,
		set = function(state)
			vim.g.autoformat = state
		end,
	})
)

vim.keymap.set(
	"n",
	"<leader>tl",
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
	})
)

vim.keymap.set(
	"n",
	"<leader>td",
	toggle.create({
		name = "Diagnostics",
		get = vim.diagnostic.is_enabled,
		set = vim.diagnostic.enable,
	})
)

vim.keymap.set(
	"n",
	"<leader>ti",
	toggle.create({
		name = "Diagnostics",
		get = vim.lsp.inlay_hint.is_enabled,
		set = vim.lsp.inlay_hint.enable,
	})
)

vim.keymap.set("n", "<leader>ts", toggle.create_option("spell", { name = "Spell" }))

vim.keymap.set("n", "<leader>go", require("mini.diff").toggle_overlay)

vim.keymap.set("n", "<leader>ff", require("mini.pick").builtin.files)
vim.keymap.set("n", "<leader>fo", require("mini.extra").pickers.oldfiles)
vim.keymap.set("n", "<leader>fs", require("mini.pick").builtin.grep_live)
vim.keymap.set("n", "<leader>bf", require("mini.pick").builtin.buffers)
vim.keymap.set("n", "<leader>ph", require("mini.pick").builtin.help)
vim.keymap.set("n", "<leader>pr", require("mini.pick").builtin.resume)

local function on_list(opts)
	vim.fn.setqflist({}, " ", opts)

	if #opts.items == 1 then
		vim.cmd.cfirst()
	else
		require("mini.extra").pickers.list({ scope = "quickfix" }, { source = { name = opts.title } })
	end

	vim.fn.setqflist({})
end

vim.keymap.set("n", "grD", function()
	vim.lsp.buf.declaration({ on_list = on_list })
end)

vim.keymap.set("n", "grd", function()
	vim.lsp.buf.definition({ on_list = on_list })
end)

vim.keymap.set("n", "gri", function()
	vim.lsp.buf.implementation({ on_list = on_list })
end)

vim.keymap.set("n", "grr", function()
	vim.lsp.buf.references(nil, { on_list = on_list })
end)

vim.keymap.set("n", "grt", function()
	vim.lsp.buf.type_definition({ on_list = on_list })
end)
