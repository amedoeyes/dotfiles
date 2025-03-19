vim.filetype.add({
	extension = {
		vifm = "vim",
	},
	pattern = {
		vifmrc = "vim",
		[".*/sway/.*%.conf"] = "swayconfig",
	},
})
