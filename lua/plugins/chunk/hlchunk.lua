return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local theme_colors = require("config.theme-colors")
		-- set hlchuk color
		require("hlchunk").setup({
			chunk = {
				style = string.format("#%06X", theme_colors.get_origin_theme_colors().hl_constant),
				enable = true,
				duration = 50,
				delay = 150,
			},
			indent = {
				enable = true,
			},
			line_num = {
				enable = false,
			},
		})
	end,
}
