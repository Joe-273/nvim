local register_theme = require("plugins.colorscheme.config")
local palette = require("plugins.colorscheme.themes-palette")

return {
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		keys = {
			{ "<leader>tT", "<cmd>TransparentToggle<CR>", desc = "Colorscheme: Toggle [T]ransparency" },
		},
	},
	-- [[ Register themes & Apply theme ]]
	register_theme(palette.tokyonight.moon),
	-- register_theme(),
}
