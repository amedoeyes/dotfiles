local M = {}

local state = {
	is_open = false,
	win = nil,
	opt = {
		number = false,
		relativenumber = false,
		signcolumn = "no",
		spell = true,
		statuscolumn = "",
		wrap = true,
	},
	hl = {
		win_seperator = { fg = "bg" },
	},
	padding = {
		width = 0,
		buf = nil,
		lwin = nil,
		rwin = nil,
	},
}

local function calc_padding_width()
	return math.floor((vim.o.columns - vim.o.textwidth - 80) / 2)
end

M.enable = function()
	state.is_open = true

	state.opt.statuscolumn = vim.opt.statuscolumn:get()
	state.opt.signcolumn = vim.opt.signcolumn:get()
	state.opt.spell = vim.opt.spell:get()
	state.opt.wrap = vim.opt.wrap:get()
	state.opt.number = vim.opt.number:get()
	state.opt.relativenumber = vim.opt.relativenumber:get()

	vim.opt.statuscolumn = ""
	vim.opt.signcolumn = "no"
	vim.opt.spell = true
	vim.opt.wrap = true
	vim.opt.number = false
	vim.opt.relativenumber = false

	state.hl.win_seperator = vim.api.nvim_get_hl(0, { name = "WinSeparator" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "bg" })

	state.win = vim.api.nvim_get_current_win()

	state.padding.buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(state.padding.buf, "padding")
	state.padding.width = calc_padding_width()

	state.padding.lwin = vim.api.nvim_open_win(state.padding.buf, false, {
		split = "left",
		focusable = false,
		style = "minimal",
	})
	state.padding.rwin = vim.api.nvim_open_win(state.padding.buf, false, {
		split = "right",
		focusable = false,
		style = "minimal",
	})

	vim.api.nvim_win_set_width(state.padding.lwin, state.padding.width)
	vim.api.nvim_win_set_width(state.padding.rwin, state.padding.width)

	local augroup = vim.api.nvim_create_augroup("writemode", { clear = false })

	vim.api.nvim_create_autocmd("VimResized", {
		group = augroup,
		callback = function()
			state.padding.width = calc_padding_width()
			vim.api.nvim_win_set_width(state.padding.lwin, state.padding.width)
			vim.api.nvim_win_set_width(state.padding.rwin, state.padding.width)
		end,
	})

	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(state.win),
		group = augroup,
		callback = function()
			M.disable()
			if #vim.api.nvim_list_wins() == 1 then
				vim.cmd("quit")
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "padding",
		group = augroup,
		callback = function()
			vim.api.nvim_set_current_win(state.win)
		end,
	})
end

M.disable = function()
	state.is_open = false

	vim.opt.statuscolumn = state.opt.statuscolumn
	vim.opt.signcolumn = state.opt.signcolumn
	vim.opt.spell = state.opt.spell
	vim.opt.wrap = state.opt.wrap
	vim.opt.number = state.opt.number
	vim.opt.relativenumber = state.opt.relativenumber

	state.opt.statuscolumn = ""
	state.opt.signcolumn = "no"
	state.opt.spell = true
	state.opt.wrap = true
	state.opt.number = false
	state.opt.relativenumber = false

	vim.api.nvim_set_hl(0, "WinSeparator", state.hl.win_seperator)
	state.hl.win_seperator = { fg = "bg" }

	vim.api.nvim_buf_delete(state.padding.buf, { force = true })
	vim.api.nvim_clear_autocmds({ group = "writemode" })
end

M.toggle = require("plugins.toggle").create({
	get = function()
		return state.is_open
	end,
	set = function(state)
		if state then
			M.enable()
		else
			M.disable()
		end
	end,
})

M.setup = function()
	vim.api.nvim_create_user_command("WriteMode", function()
		M.toggle()
	end, {})
end

return M
