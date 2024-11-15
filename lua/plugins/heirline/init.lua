return {
	"rebelot/heirline.nvim",
	-- You can optionally lazy-load heirline on UiEnter
	-- to make sure all required plugins and colorschemes are loaded before setup
	event = "VeryLazy",

	config = function()
		local theme_colors = require("config.theme-colors")
		require("heirline").load_colors(theme_colors.get_origin_theme_colors())
		require("heirline").setup({
			statusline = require("plugins.heirline.statusline"),
			tabline = require("plugins.heirline.tabline"),
		})
	end,
}
