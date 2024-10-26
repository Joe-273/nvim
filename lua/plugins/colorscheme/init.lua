return {
	{
		"xiyaowong/transparent.nvim",
		priority = 2000, -- Make sure to load this before all the other start plugins.
		lazy = false,
		keys = {
			{ "<leader>t" .. "T", "<cmd>TransparentToggle<CR>", desc = "[T]oggle [T]ransparency" },
		},
		config = function()
			require("plugins.colorscheme.transparent")
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = vim.g.transparent_enabled,
				styles = {
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
			})
			-- vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
	{
		"catppuccin/nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			require("catppuccin").setup({
				transparent_background = vim.g.transparent_enabled,
				highlight_overrides = {
					all = function(colors)
						return {
							NormalFloat = { bg = colors.base },
							NeoTreeNormal = { bg = colors.base },
							NeoTreeNormalNC = { bg = colors.base },
							NeoTreeWinSeparator = { fg = colors.surface1, bg = colors.none },
						}
					end,
				},
			})
			vim.cmd.colorscheme("catppuccin-macchiato")
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
					transparent = vim.g.transparent_enabled,
					darken = { -- Darken floating windows and sidebar-like windows
						floats = false,
						sidebars = {
							enable = false,
						},
					},
				},
			})
			-- vim.cmd.colorscheme("github_dark")
		end,
	},
}
