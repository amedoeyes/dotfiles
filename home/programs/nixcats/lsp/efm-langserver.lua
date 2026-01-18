---@param parser string
---@return table
local function prettier(parser)
	return {
		formatCommand = string.format(
			"prettier --parser %s --stdin --stdin-filepath '${INPUT}' ${--range-start:charStart} ${--range-end:charEnd} --config-precedence prefer-file",
			parser
		),
		formatCanRange = true,
		formatStdin = true,
		rootMarkers = {
			".prettierrc",
			".prettierrc.cjs",
			".prettierrc.js",
			".prettierrc.json",
			".prettierrc.json5",
			".prettierrc.mjs",
			".prettierrc.toml",
			".prettierrc.yaml",
			".prettierrc.yml",
			"prettier.config.cjs",
			"prettier.config.js",
			"prettier.config.mjs",
		},
	}
end

---@return table
local function shfmt()
	return {
		formatCommand = "shfmt -filename '${INPUT}' -",
		formatStdin = true,
	}
end

---@type vim.lsp.Config
return {
	cmd = { "efm-langserver" },
	filetypes = {
		"bash",
		"css",
		"html",
		"javascript",
		"json",
		"less",
		"lua",
		"markdown",
		"sass",
		"scss",
		"sh",
		"typescript",
		"yaml",
	},
	settings = {
		languages = {
			bash = { shfmt() },
			css = { prettier("css") },
			html = { prettier("html") },
			javascript = { prettier("babel") },
			json = { prettier("json") },
			less = { prettier("less") },
			markdown = { prettier("markdown") },
			sass = { prettier("sass") },
			scss = { prettier("scss") },
			sh = { shfmt() },
			typescript = { prettier("typescript") },
			yaml = { prettier("yaml") },
		},
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}
