local M = {}

local state = {
	is_open = false,
	win = nil,
	opt = {
		cursorline = false,
		number = false,
		relativenumber = false,
		signcolumn = "no",
		spell = true,
		statuscolumn = "",
		wrap = true,
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

	state.opt.cursorline = vim.opt.cursorline:get()
	state.opt.number = vim.opt.number:get()
	state.opt.relativenumber = vim.opt.relativenumber:get()
	state.opt.signcolumn = vim.opt.signcolumn:get()
	state.opt.spell = vim.opt.spell:get()
	state.opt.statuscolumn = vim.opt.statuscolumn:get()
	state.opt.wrap = vim.opt.wrap:get()

	vim.opt.cursorline = false
	vim.opt.number = false
	vim.opt.relativenumber = false
	vim.opt.signcolumn = "no"
	vim.opt.spell = true
	vim.opt.statuscolumn = ""
	vim.opt.wrap = true

	state.win = vim.api.nvim_get_current_win()

	state.padding.buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(state.padding.buf, "padding")
	state.padding.width = calc_padding_width()

	if state.padding.width > 0 then
		state.padding.lwin = vim.api.nvim_open_win(state.padding.buf, false, {
			split = "left",
			focusable = false,
			style = "minimal",
			width = state.padding.width,
		})
		state.padding.rwin = vim.api.nvim_open_win(state.padding.buf, false, {
			split = "right",
			focusable = false,
			style = "minimal",
			width = state.padding.width,
		})
	end

	local augroup = vim.api.nvim_create_augroup("writemode", { clear = false })

	vim.api.nvim_create_autocmd("VimResized", {
		group = augroup,
		callback = function()
			state.padding.width = calc_padding_width()
			if state.padding.lwin ~= nil and state.padding.rwin ~= nil then
				if state.padding.width > 0 then
					vim.api.nvim_win_set_width(state.padding.lwin, state.padding.width)
					vim.api.nvim_win_set_width(state.padding.rwin, state.padding.width)
				else
					vim.api.nvim_win_close(state.padding.lwin, true)
					vim.api.nvim_win_close(state.padding.rwin, true)
					state.padding.lwin = nil
					state.padding.rwin = nil
				end
			elseif state.padding.width > 0 then
				state.padding.lwin = vim.api.nvim_open_win(state.padding.buf, false, {
					split = "left",
					focusable = false,
					style = "minimal",
					width = state.padding.width,
				})
				state.padding.rwin = vim.api.nvim_open_win(state.padding.buf, false, {
					split = "right",
					focusable = false,
					style = "minimal",
					width = state.padding.width,
				})
			end
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

	vim.opt.cursorline = state.opt.cursorline
	vim.opt.number = state.opt.number
	vim.opt.relativenumber = state.opt.relativenumber
	vim.opt.signcolumn = state.opt.signcolumn
	vim.opt.spell = state.opt.spell
	vim.opt.statuscolumn = state.opt.statuscolumn
	vim.opt.wrap = state.opt.wrap

	state.opt.cursorline = false
	state.opt.number = false
	state.opt.relativenumber = false
	state.opt.signcolumn = "no"
	state.opt.spell = true
	state.opt.statuscolumn = ""
	state.opt.wrap = true

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
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("writemode.command", { clear = true }),
		pattern = { "markdown", "text" },
		callback = function(e)
			vim.api.nvim_buf_create_user_command(e.buf, "WriteMode", function()
				M.toggle()
			end, {})
		end,
	})
end

return M
