require("mini.deps").later(function()
	vim.g.termdebug_config = { sign = "" }
	vim.cmd.packadd("termdebug")
end)
