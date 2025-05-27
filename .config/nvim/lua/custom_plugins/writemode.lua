local M = {}

local state = {
	statuscolumn = "",
	signcolumn = "no",
	spell = true,
	wrap = true,
	number = false,
	relativenumber = false,
	sephl = { fg = "bg" },
	is_open = false,
	padding_buf = -1,
}

local function set(enabled)
	if enabled then
		state.statuscolumn = vim.opt.statuscolumn:get()
		state.signcolumn = vim.opt.signcolumn:get()
		state.spell = vim.opt.spell:get()
		state.wrap = vim.opt.wrap:get()
		state.number = vim.opt.number:get()
		state.relativenumber = vim.opt.relativenumber:get()
		state.sephl = vim.api.nvim_get_hl(0, { name = "WinSeparator" })

		vim.opt.statuscolumn = ""
		vim.opt.signcolumn = "no"
		vim.opt.spell = true
		vim.opt.wrap = true
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.api.nvim_set_hl(0, "WinSeparator", { fg = "bg" })

		state.padding_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(state.padding_buf, "padding")
		local width = math.floor((vim.o.columns - vim.o.textwidth - 80) / 2)
		local lwin = vim.api.nvim_open_win(state.padding_buf, false, {
			split = "left",
			focusable = false,
			style = "minimal",
			width = width,
		})
		local rwin = vim.api.nvim_open_win(state.padding_buf, false, {
			split = "right",
			focusable = false,
			style = "minimal",
			width = width,
		})

		vim.api.nvim_create_autocmd("VimResized", {
			group = vim.api.nvim_create_augroup("writemode", { clear = false }),
			callback = function()
				local new_width = math.floor((vim.o.columns - vim.o.textwidth - 80) / 2)
				vim.api.nvim_win_set_width(lwin, new_width)
				vim.api.nvim_win_set_width(rwin, new_width)
			end,
		})

		local augroup = vim.api.nvim_create_augroup("writemode", { clear = false })
		vim.api.nvim_create_autocmd("WinClosed", {
			pattern = tostring(vim.api.nvim_get_current_win()),
			group = augroup,
			callback = function()
				set(false)
				if #vim.api.nvim_list_wins() == 1 then
					vim.cmd("quit")
				end
			end,
		})

		local win = vim.api.nvim_get_current_win()
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "padding",
			group = augroup,
			callback = function()
				vim.api.nvim_set_current_win(win)
			end,
		})
	else
		vim.opt.statuscolumn = state.statuscolumn
		vim.opt.signcolumn = state.signcolumn
		vim.opt.spell = state.spell
		vim.opt.wrap = state.wrap
		vim.opt.number = state.number
		vim.opt.relativenumber = state.relativenumber
		vim.api.nvim_set_hl(0, "WinSeparator", state.sephl)

		state.statuscolumn = ""
		state.signcolumn = "no"
		state.spell = true
		state.wrap = true
		state.number = false
		state.relativenumber = false
		state.sephl = { fg = "bg" }

		vim.api.nvim_buf_delete(state.padding_buf, { force = true })
		vim.api.nvim_clear_autocmds({ group = "writemode" })
	end

	state.is_open = enabled
end

local toggle = require("custom_plugins.toggle").create({
	get = function()
		return state.is_open
	end,
	set = set,
})

M.setup = function()
	vim.api.nvim_create_user_command("WriteMode", function()
		toggle()
	end, {})
end

return M
