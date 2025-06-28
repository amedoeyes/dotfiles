vim.filetype.add({
	extension = {
		vifm = "vim",
		ebnf = "ebnf",
	},
	pattern = {
		vifmrc = "vim",
		[".*/sway/.*%.conf"] = "swayconfig",
	},
})
