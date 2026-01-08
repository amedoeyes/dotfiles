vim.lsp.enable({
	"bash-language-server",
	"clangd",
	"efm-langserver",
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
				local max_width = 80

				local show_docs = false
				local complete_item = nil
				local docs_win = nil

				local open_docs = function()
					vim.opt.completeopt:append("popup")

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

					local info = nil

					if detail and docs then
						info = detail .. "\n\n" .. docs
					elseif detail then
						info = detail
					elseif docs then
						info = docs
					end

					if not info then
						return
					end

					local data = vim.api.nvim__complete_set(
						vim.fn.complete_info({ "selected" }).selected,
						{ info = info }
					)

					vim.wo[data.winid].conceallevel = 2
					vim.bo[data.bufnr].filetype = "markdown"

					vim.keymap.set("i", "<C-f>", function()
						if vim.fn.pumvisible() == 0 then
							return "<C-f>"
						end
						if not vim.api.nvim_win_is_valid(data.winid) then
							return
						end
						vim.api.nvim_win_call(data.winid, function()
							local v = vim.fn.winsaveview()
							v.topline = math.max(1, (v.topline or 1) + 3)
							vim.fn.winrestview(v)
						end)
					end, { silent = true, expr = true })

					vim.keymap.set("i", "<C-b>", function()
						if vim.fn.pumvisible() == 0 then
							return "<C-b>"
						end
						if not vim.api.nvim_win_is_valid(data.winid) then
							return
						end
						vim.api.nvim_win_call(data.winid, function()
							local v = vim.fn.winsaveview()
							v.topline = math.max(1, (v.topline or 1) - 3)
							vim.fn.winrestview(v)
						end)
					end, { silent = true, expr = true })

					local win_cfg = vim.api.nvim_win_get_config(data.winid)

					local pum = vim.fn.pum_getpos()
					local cur = vim.fn.screenpos(0, vim.fn.line("."), vim.fn.col("."))

					local signcolumn_width = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff
					local view_width = vim.o.columns - signcolumn_width
					local view_height = vim.o.lines - vim.o.cmdheight - 1

					local docs_win_padding = (vim.o.winborder == "" or vim.o.winborder == "none") and 0 or 2
					local pum_padding = (vim.o.pumborder == "" or vim.o.pumborder == "none") and 0 or 2
					local pum_end_row = pum.row + pum.height + pum_padding

					local max_line_len = vim
						.iter(vim.split(info, "\n"))
						:filter(function(v)
							return not vim.startswith(v, "```")
						end)
						:map(function(v)
							return #v
						end)
						:fold(0, function(acc, v)
							return math.max(acc, v)
						end)

					win_cfg.width = math.min(max_width, max_line_len)

					vim.wo[data.winid].wrap = win_cfg.width == max_width or win_cfg.width > view_width

					if win_cfg.width > view_width then
						win_cfg.width = view_width - docs_win_padding
					end

					if detail and docs then
						vim.api.nvim_buf_set_extmark(data.bufnr, 1, #vim.split(detail, "\n"), 0, {
							virt_text = { { string.rep("─", win_cfg.width), "FloatBorder" } },
							virt_text_pos = "overlay",
						})
					end

					local space_right = view_width - (pum.col + pum.width)
					local space_top = view_height - (view_height - pum.row)
					local space_bottom = view_height - pum_end_row

					win_cfg.height = vim.api.nvim_win_text_height(data.winid, {}).all

					if space_right >= win_cfg.width + docs_win_padding then
						if cur.row == pum.row then
							win_cfg.height = math.min(win_cfg.height, view_height - pum.row - docs_win_padding)
							win_cfg.row = pum.row
						else
							win_cfg.height = math.min(
								win_cfg.height,
								view_height - (view_height - pum_end_row) - docs_win_padding
							)
							win_cfg.row = pum_end_row
						end
					else
						if space_bottom >= space_top then
							if cur.row == pum.row then
								win_cfg.height = math.min(win_cfg.height, space_bottom - docs_win_padding)
								win_cfg.row = pum_end_row
							else
								win_cfg.height = math.min(win_cfg.height, view_height - cur.row - docs_win_padding)
								win_cfg.row = cur.row + win_cfg.height + docs_win_padding
							end
						else
							if cur.row == pum.row then
								win_cfg.height = math.min(win_cfg.height, (cur.row - 1) - docs_win_padding)
								win_cfg.row = (cur.row - 1) - win_cfg.height - docs_win_padding
							else
								win_cfg.height = math.min(win_cfg.height, pum.row - docs_win_padding)
								win_cfg.row = pum.row
							end
						end
						win_cfg.col = pum.col - 1
					end

					win_cfg.border = vim.o.winborder

					vim.api.nvim_win_set_config(data.winid, win_cfg)

					docs_win = data.winid
				end

				local close_docs = function()
					vim.opt.completeopt:remove("popup")
					if docs_win and vim.api.nvim_win_is_valid(docs_win) then
						vim.api.nvim_win_close(docs_win, true)
						docs_win = nil
					end
				end

				vim.lsp.completion.enable(true, client.id, buf, {
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
						vim.lsp.completion.get()
					else
						show_docs = not show_docs
						if show_docs then
							open_docs()
						else
							close_docs()
						end
					end
				end, { buffer = buf })

				vim.api.nvim_create_autocmd("CompleteChanged", {
					buffer = buf,
					callback = function()
						if vim.v.event.completed_item then
							complete_item = vim.tbl_get(
								vim.v.event.completed_item,
								"user_data",
								"nvim",
								"lsp",
								"completion_item"
							)
						end
						if show_docs then
							open_docs()
						end
					end,
				})

				vim.api.nvim_create_autocmd("CompleteDone", {
					buffer = buf,
					callback = function()
						complete_item = nil
						show_docs = false
						close_docs()
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
