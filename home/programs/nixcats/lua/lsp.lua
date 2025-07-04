vim.lsp.set_log_level("off")

vim.g.autoformat = true
vim.g.codelens = false

vim.lsp.config("*", {
	root_markers = { ".git" },
	on_attach =
		---@param client vim.lsp.Client
		---@param buf integer
		function(client, buf)
			if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, buf) then
				vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
					group = vim.api.nvim_create_augroup("eyes.lsp.codelens", { clear = false }),
					buffer = buf,
					callback = function()
						if vim.g.codelens then
							vim.lsp.codelens.refresh({ bufnr = buf })
						end
					end,
				})
			end

			if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, buf) then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					group = vim.api.nvim_create_augroup("eyes.lsp.highlight", { clear = false }),
					buffer = buf,
					callback = function()
						vim.lsp.buf.clear_references()
						vim.lsp.buf.document_highlight()
					end,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "ModeChanged" }, {
					group = vim.api.nvim_create_augroup("eyes.lsp.highlight", { clear = false }),
					buffer = buf,
					callback = function()
						vim.lsp.buf.clear_references()
					end,
				})
			end

			if vim.tbl_contains({ "typescript-language-server" }, client.name) then
				client.server_capabilities.documentFormattingProvider = false
			end

			if vim.tbl_contains({ "tinymist" }, client.name) then
				client.server_capabilities.documentFormattingProvider = true
			end

			if
				not client:supports_method(vim.lsp.protocol.Methods.textDocument_willSaveWaitUntil, buf)
				and client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting, buf)
			then
				vim.bo[buf].formatexpr = "v:lua.vim.lsp.formatexpr()"
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("eyes.lsp.autoformat", { clear = false }),
					buffer = buf,
					callback = function()
						if not vim.g.autoformat then
							return
						end
						vim.lsp.buf.format({ bufnr = buf, id = client.id })
					end,
				})
			end

			if client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange, buf) then
				vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
			end
		end,
})

vim.lsp.enable({
	"bash-language-server",
	"clangd",
	"gopls",
	"haskell-language-server",
	"lua-language-server",
	"marksman",
	"nixd",
	"pyright",
	"ruff",
	"rust-analyzer",
	"typescript-language-server",
	"tinymist",
	"vscode-css-language-server",
	"vscode-eslint-language-server",
	"vscode-html-language-server",
	"vscode-json-language-server",
	"zk",
})

vim.keymap.set("n", "grlr", vim.lsp.codelens.run, { desc = "Codelens run" })
vim.keymap.set("n", "grlc", vim.lsp.codelens.clear, { desc = "Codelens clear" })
vim.keymap.set("n", "grlf", vim.lsp.codelens.refresh, { desc = "Codelens refresh" })
