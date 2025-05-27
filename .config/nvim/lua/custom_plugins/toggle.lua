local M = {}

---@param opts {
---	name: string?,
--- get: function,
--- set: fun(state: boolean)
---}
---@return fun(state:boolean?)
M.create = function(opts)
	return function(state)
		state = state ~= nil and state or opts.get()
		if state then
			opts.set(false)
			if opts.name then
				vim.notify(opts.name .. " disabled")
			end
		else
			opts.set(true)
			if opts.name then
				vim.notify(opts.name .. " enabled")
			end
		end
	end
end

---@param opt string
---@param opts {
--- name: string,
--- on: any?,
--- off: any?,
---}?
---@return fun(state:boolean?)
M.create_option = function(opt, opts)
	opts = opts or {}
	local on = opts.on ~= nil and opts.on or true
	local off = opts.off ~= nil and opts.off or false
	return M.create({
		name = opts and opts.name or nil,
		get = function()
			return vim.opt[opt]:get() == on
		end,
		set = function(state)
			vim.opt[opt] = state and on or off
		end,
	})
end

return M
