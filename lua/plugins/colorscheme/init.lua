return {
	{
		"xiyaowong/transparent.nvim",
		priority = 2000, -- Make sure to load this before all the other start plugins.
		lazy = false,
		keys = {
			{ "<leader>tt", "<cmd>TransparentToggle<CR>", desc = "Theme: [T]oggle [T]ransparency" },
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
						local separator_fg = vim.g.transparent_enabled and colors.surface1 or colors.crust
						return {
							NormalFloat = { bg = colors.base },
							NeoTreeNormal = { bg = colors.base },
							NeoTreeNormalNC = { bg = colors.base },
							NeoTreeWinSeparator = { fg = separator_fg, bg = colors.none },
						}
					end,
				},
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
	{
		"EdenEast/nightfox.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			-- Default options
			require("nightfox").setup({
				options = {
					transparent = vim.g.transparent_enabled, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = false, -- Non focused panes set to alternative background
					module_default = true, -- Default enable value for modules
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "italic,bold",
					},
				},
				groups = {
					all = {
						NormalFloat = { bg = "bg1" },
						NeoTreeNormal = { bg = "bg1" },
						NeoTreeNormalNC = { bg = "bg1" },
					},
				},
			})
			-- nightfox dayfox dawnfox duskfox nordfox terafox carbonfox
			vim.cmd.colorscheme("nordfox")
		end,
	},
}
