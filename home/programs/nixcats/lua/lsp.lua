vim.g.autoformat = true
vim.g.codelens = false

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
	"taplo",
	"tinymist",
	"typescript-language-server",
	"vscode-css-language-server",
	"vscode-eslint-language-server",
	"vscode-html-language-server",
	"vscode-json-language-server",
	"wgsl-analyzer",
	"zk",
})

vim.lsp.config("*", {
	root_markers = { ".git" },
	on_attach =
		---@param client vim.lsp.Client
		---@param buf integer
		function(client, buf)
			if client.server_capabilities.completionProvider then
				local kind_icons = {
					"", -- Text
					"", -- Method
					"", -- Function
					"", -- Constructor
					"", -- Field
					"", -- Variable
					"", -- Class
					"", -- Interface
					"", -- Module
					"", -- Property
					"", -- Unit
					"󰎠", -- Value
					"", -- Enum
					"", -- Keyword
					"", -- Snippet
					"", -- Color
					"", -- File
					"", -- Reference
					"", -- Folder
					"", -- EnumMember
					"", -- Constant
					"", -- Struct
					"", -- Event
					"", -- Operator
					"", -- TypeParameter
				}

				vim.bo[buf].complete = "o"

				local show_docs = false
				local complete_item = nil
				local docs_win = nil

				vim.lsp.completion.enable(true, client.id, buf, {
					autotrigger = true,
					convert = function(item)
						return {
							abbr = string.format(
								"%s %s",
								kind_icons[item.kind or 1],
								item.label:gsub("^%s*(.-)%s*$", "%1")
									.. (item.labelDetails and item.labelDetails.detail or "")
							),
							kind = "",
							menu = "",
						}
					end,
				})

				vim.keymap.set("i", "<C-Space>", function()
					if vim.fn.pumvisible() == 0 then
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
							"n",
							true
						)
					else
						show_docs = not show_docs
						if show_docs then
							vim.opt.completeopt:append("popup")
							vim.api.nvim_exec_autocmds("CompleteChanged", {})
						else
							vim.opt.completeopt:remove("popup")
							if docs_win ~= nil and vim.api.nvim_win_is_valid(docs_win) then
								vim.api.nvim_win_close(docs_win, true)
								docs_win = nil
							end
						end
					end
				end, { buffer = buf })

				vim.api.nvim_create_autocmd("CompleteChanged", {
					buffer = buf,
					callback = function()
						if vim.v.event.completed_item ~= nil then
							complete_item = vim.tbl_get(
								vim.v.event.completed_item,
								"user_data",
								"nvim",
								"lsp",
								"completion_item"
							)
						end

						if not show_docs then
							return
						end

						local detail = complete_item and complete_item.detail
						local docs = complete_item and vim.tbl_get(complete_item, "documentation", "value")

						if
							(not detail or not docs)
							and client.server_capabilities.completionProvider.resolveProvider
						then
							local res = vim.lsp.buf_request_sync(
								buf,
								vim.lsp.protocol.Methods.completionItem_resolve,
								complete_item
							)
							detail = res and vim.tbl_get(res[client.id], "result", "detail") or detail
							docs = res and vim.tbl_get(res[client.id], "result", "documentation", "value")
						end

						detail = detail and ("```" .. vim.bo[buf].filetype .. "\n" .. detail .. "\n```")

						if not detail and not docs then
							return
						end

						local info = table.concat(
							vim.tbl_filter(function(i)
								return i ~= nil
							end, { detail, docs }),
							"\n\n"
						)

						local data = vim.api.nvim__complete_set(
							vim.fn.complete_info({ "selected" })["selected"],
							{ info = info }
						)
						if not data.winid or not vim.api.nvim_win_is_valid(data.winid) then
							return
						end

						vim.treesitter.start(data.bufnr, "markdown")

						if detail and docs then
							vim.api.nvim_buf_set_extmark(
								data.bufnr,
								vim.api.nvim_create_namespace("line"),
								#vim.split(detail, "\n"),
								0,
								{
									virt_text = { { string.rep("─", 80), "FloatBorder" } },
									virt_text_pos = "overlay",
								}
							)
						end

						vim.api.nvim_win_set_config(data.winid, { border = "single" })
						vim.wo[data.winid].conceallevel = 2
						vim.wo[data.winid].wrap = true
						vim.api.nvim_win_set_width(data.winid, 80)
						vim.api.nvim_win_set_height(
							data.winid,
							vim.api.nvim_win_text_height(data.winid, {}).all
						)

						local win_config = vim.api.nvim_win_get_config(data.winid)
						local pum = vim.fn.pum_getpos()

						if win_config.width > vim.o.columns * 0.5 then
							win_config.height =
								math.min(win_config.height, vim.o.lines - (pum.row + pum.height) - 5)
							win_config.row = pum.row + pum.height + 2
							win_config.col = pum.col - 1
							vim.api.nvim_win_set_config(data.winid, win_config)
						else
							win_config.height = math.min(win_config.height, vim.o.lines - pum.row - 3)
							vim.api.nvim_win_set_config(data.winid, win_config)
						end

						docs_win = data.winid
					end,
				})

				vim.api.nvim_create_autocmd("CompleteDone", {
					buffer = buf,
					callback = function()
						vim.opt.completeopt:remove("popup")
						show_docs = false
						docs_win = nil
						complete_item = nil
					end,
				})
			end

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

				vim.keymap.set("n", "grlr", vim.lsp.codelens.run, { desc = "Codelens run" })
				vim.keymap.set("n", "grlc", vim.lsp.codelens.clear, { desc = "Codelens clear" })
				vim.keymap.set("n", "grlf", vim.lsp.codelens.refresh, { desc = "Codelens refresh" })
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

vim.lsp.log.set_level("off")
