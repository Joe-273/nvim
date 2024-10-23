return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		init = function()
			-- vim.cmd.colorscheme("tokyonight-storm")
		end,
		opts = {
			transparent = false,
			styles = {
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "transparent", -- style for floating windows
			},
		},
	},
	{
		"catppuccin/nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
			})
			-- vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					transparent = false,
					darken = { -- Darken floating windows and sidebar-like windows
						floats = false,
						sidebars = {
							enable = true,
						},
					},
				},
			})
			vim.cmd("colorscheme github_dark")
		end,
	},
}
