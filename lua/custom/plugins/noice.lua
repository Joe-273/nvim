return {
	"folke/noice.nvim",
	event = "VeryLazy",
	keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
	config = function()
		require("noice").setup({
			views = {
				cmdline_popup = {
					position = {
						row = 15,
						col = "50%",
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
					enabled = false,
				},
			},
		})
	end,
}
