require("mini.deps").later(function()
	local null_ls = require("null-ls")
	null_ls.setup({
		border = vim.o.winborder,
		on_attach = function(client, buf)
			vim.bo[buf].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:1000})"
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("eyes.lsp.autoformat", { clear = false }),
				buffer = buf,
				callback = function()
					if not vim.g.autoformat then return end
					vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end,
		sources = {
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.stylua,
		},
	})
end)
