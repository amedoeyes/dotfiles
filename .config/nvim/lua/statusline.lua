local function padding(n, str)
	if not str then return string.rep(" ", n) end
	return str ~= "" and string.rep(" ", n) or ""
end

local modes = {
	n = "NOR",
	no = "ONR",
	nov = "ONR",
	noV = "ONR",
	["no\22"] = "ONR",
	niI = "NOR",
	niR = "NOR",
	niV = "NOR",
	nt = "NOR",
	v = "VIS",
	vs = "VIS",
	V = "VLN",
	Vs = "VLN",
	["\22"] = "VBL",
	["\22s"] = "VBL",
	s = "SEL",
	S = "SLN",
	["\19"] = "SBL",
	i = "INS",
	ic = "INS",
	ix = "INS",
	R = "REP",
	Rc = "REP",
	Rx = "REP",
	Rv = "REP",
	Rvc = "REP",
	Rvx = "REP",
	c = "CMD",
	cv = "CMD",
	r = "PRM",
	rm = "MOR",
	["r?"] = "CNF",
	["!"] = "SHL",
	t = "TRM",
}

function Statusline()
	local mode = modes[vim.fn.mode(1)]

	local git_branch = vim.g.git_branch and string.format(" %s", vim.g.git_branch) or ""

	local diagnostics_parts = {}
	for _, s in ipairs({
		vim.diagnostic.severity.ERROR,
		vim.diagnostic.severity.WARN,
		vim.diagnostic.severity.INFO,
		vim.diagnostic.severity.HINT,
	}) do
		local diag = #vim.diagnostic.get(0, { severity = s })
		local icon = vim.diagnostic.config().signs.text[s]
		if diag > 0 then table.insert(diagnostics_parts, icon .. diag) end
	end
	local diagnostics = table.concat(diagnostics_parts, " ")

	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
	if filename == "" then filename = "[No Name]" end

	local file_icon = require("mini.icons").get("file", filename)

	local file_status = ""
	if vim.bo.modified then
		file_status = "●"
	elseif vim.bo.readonly then
		file_status = ""
	end

	local recording = vim.fn.reg_recording()
	if recording ~= "" then recording = " recording @" .. recording end

	local search_count = ""
	if vim.v.hlsearch == 1 then
		local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
		if res.total and res.total > 0 then
			search_count =
				string.format(" %" .. #tostring(res.total) .. "d/%d", res.current, res.total)
		end
	end

	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1]
	local col = cursor[2] + 1
	local lines = vim.api.nvim_buf_line_count(0)
	local pos
	if row == 1 then
		pos = "TOP"
	elseif row == lines then
		pos = "BOT"
	else
		pos = string.format("%2d%%%%", math.floor((row / lines) * 100))
	end
	local ruler = string.format("%" .. #tostring(lines) .. "d:%-3d %s", row, col, pos)

	return table.concat({
		padding(1),
		"%#Title#",
		mode,
		"%#Normal#",
		padding(2),
		git_branch,
		padding(2, git_branch),
		diagnostics,
		padding(2, diagnostics),
		file_icon,
		padding(1),
		"%<",
		filename,
		padding(1),
		file_status,
		padding(1),
		"%=",
		padding(1),
		recording,
		padding(2, recording),
		search_count,
		padding(2, search_count),
		"%#Title#",
		ruler,
		padding(1),
	})
end

vim.opt.statusline = "%!v:lua.Statusline()"

vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged" }, { command = "redrawstatus" })
