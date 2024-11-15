local register_theme = require("plugins.colorscheme.config")
local palette = require("plugins.colorscheme.themes-palette")

return {
	{
		"xiyaowong/transparent.nvim",
		priority = 2000, -- Make sure to load this before all the other start plugins.
		lazy = false,
		keys = {
			{ "<leader>tT", "<cmd>TransparentToggle<CR>", desc = "Theme: [T]oggle [T]ransparency" },
		},
		config = function()
			require("plugins.colorscheme.transparent")
		end,
	},
	-- [[ Register themes & Apply theme ]]
	register_theme(palette.catppuccin.macchiato),
	-- register_theme(),
}
