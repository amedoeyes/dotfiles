require("mini.deps").later(function()
	local fzf = require("fzf-lua")
	fzf.config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
	fzf.register_ui_select()
	fzf.setup({
		winopts = {
			border = "none",
			backdrop = 100,
			preview = { title = false, border = vim.o.winborder },
		},
	})

	vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find file" })
	vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Find recent file" })
	vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep<cr>", { desc = "Search files" })

	vim.keymap.set("n", "<leader>bf", "<cmd>FzfLua buffers<cr>", { desc = "Find buffer" })
	vim.keymap.set("n", "<leader>bs", "<cmd>FzfLua lines<cr>", { desc = "Search buffer" })

	vim.keymap.set("n", "<leader>ph", "<cmd>FzfLua helptags<cr>", { desc = "Help tags" })
	vim.keymap.set("n", "<leader>pm", "<cmd>FzfLua manpages<cr>", { desc = "Man pages" })
	vim.keymap.set("n", "<leader>pp", "<cmd>FzfLua<cr>", { desc = "Pickers" })
	vim.keymap.set("n", "<leader>pr", "<cmd>FzfLua resume<cr>", { desc = "Resume" })

	vim.keymap.set("n", "grD", "<cmd>FzfLua lsp_declarations<cr>", { desc = "Declaration" })
	vim.keymap.set("n", "grd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Definition" })
	vim.keymap.set("n", "gri", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Implementation" })
	vim.keymap.set(
		"n",
		"grr",
		"<cmd>FzfLua lsp_references<cr>",
		{ nowait = true, desc = "References" }
	)
	vim.keymap.set(
		"n",
		"grS",
		"<cmd>FzfLua lsp_workspace_symbols<cr>",
		{ desc = "Workspace symbols" }
	)
	vim.keymap.set("n", "grs", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Symbols" })
	vim.keymap.set("n", "grt", "<cmd>FzfLua lsp_typedefs<cr>", { desc = "Type definition" })
	vim.keymap.set({ "n", "x" }, "gW", "<cmd>FzfLua grep_cword<cr>", { desc = "grep word" })
end)
