require("noice").setup({
	presets = {
		lsp_doc_border = true,
	},
	views = {
		cmdline_popup = {
			position = {
				row = 15,
				col = "50%",
			},
		},
		mini = {
			win_options = {
				winblend = 0,
			},
		},
	},
	lsp = {
		signature = {
			enabled = false,
		},
		progress = {
			enabled = false,
		},
		hover = {
			enabled = true,
		},
	},
})
