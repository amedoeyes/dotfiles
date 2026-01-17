local function signs()
	local win = vim.g.statusline_winid
	local buf = vim.api.nvim_win_get_buf(win)

	local res = {}

	for _, sign in ipairs(vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs) do
		local defined = vim.fn.sign_getdefined(sign.name)[1]
		if defined then
			table.insert(res, {
				name = defined.name,
				text = defined.text,
				texthl = defined.texthl,
				priority = sign.priority,
			})
		end
	end

	for _, extmark in
		pairs(
			vim.api.nvim_buf_get_extmarks(
				buf,
				-1,
				{ vim.v.lnum - 1, 0 },
				{ vim.v.lnum - 1, -1 },
				{ details = true, type = "sign" }
			)
		)
	do
		table.insert(res, {
			name = extmark[4].sign_hl_group or "",
			text = extmark[4].sign_text,
			texthl = extmark[4].sign_hl_group,
			priority = extmark[4].priority,
		})
	end

	table.sort(res, function(a, b)
		return (a.priority or 0) < (b.priority or 0)
	end)

	return res
end

local function icon(sign)
	local text = vim.fn.strcharpart(sign.text or "", 0, 1)
	if sign.texthl then
		return string.format("%%#%s#%s%%*", sign.texthl, text)
	end
	return text
end

local function diagnostic()
	if vim.v.virtnum ~= 0 then
		return nil
	end

	local res = nil

	local highest_severity = 5
	for _, s in ipairs(signs()) do
		if s.name:find("DiagnosticSign") then
			local severity = ({
				DiagnosticSignError = 1,
				DiagnosticSignWarn = 2,
				DiagnosticSignInfo = 3,
				DiagnosticSignHint = 4,
			})[s.name]
			if severity < highest_severity then
				highest_severity = severity
				res = s
			end
		end
	end

	return res and icon(res) or nil
end

local function mark()
	if vim.v.virtnum ~= 0 then
		return nil
	end

	local res = nil

	local win = vim.g.statusline_winid
	local buf = vim.api.nvim_win_get_buf(win)
	local marks = {}
	vim.list_extend(marks, vim.fn.getmarklist(buf))
	vim.list_extend(marks, vim.fn.getmarklist())
	for _, m in ipairs(marks) do
		if m.pos[1] == buf and m.pos[2] == vim.v.lnum and m.mark:match("[a-zA-Z]") then
			res = { text = m.mark:sub(2), texthl = "Icon" }
		end
	end

	return res and icon(res) or nil
end

local function number()
	local win = vim.g.statusline_winid
	local buf = vim.api.nvim_win_get_buf(win)
	local nu = vim.wo[win].number
	local rnu = vim.wo[win].relativenumber
	local num = nil
	if rnu and nu and vim.v.relnum == 0 then
		num = vim.v.lnum
	elseif rnu then
		num = vim.v.relnum
	elseif nu then
		num = vim.v.lnum
	else
		return ""
	end

	local pad = #tostring(vim.api.nvim_buf_line_count(buf))
	if vim.v.virtnum ~= 0 then
		return string.rep(" ", pad)
	end
	return string.format("%" .. pad .. "d", num)
end

local function git()
	if not vim.g.git_branch then
		return nil
	end

	local res = nil

	for _, s in ipairs(signs()) do
		if s.name:find("MiniDiffSign") then
			res = s
		end
	end

	return res and icon(res) or nil
end

local function fold()
	local res = nil

	if vim.fn.foldclosed(vim.v.lnum) >= 0 then
		res = { text = vim.opt.fillchars:get().foldclose }
	end

	return res and icon(res) or nil
end

function StatusColumn()
	return (mark() or diagnostic() or " ") .. " " .. number() .. " " .. (fold() or git() or " ")
end
