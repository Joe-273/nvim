-- [[ Store the configuration for each theme ]]
local M = {}

M.tokyonight = {
	"folke/tokyonight.nvim",
	event = "VimEnter",
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
	end,
}

M.catppuccin = {
	"catppuccin/nvim",
	event = "VimEnter",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		require("catppuccin").setup({
			transparent_background = vim.g.transparent_enabled,
		})
	end,
}

M.github = {
	"projekt0n/github-nvim-theme",
	event = "VimEnter",
	name = "github-theme",
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("github-theme").setup({
			options = {
				transparent = vim.g.transparent_enabled,
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "italic,bold",
				},
				darken = { -- Darken floating windows and sidebar-like windows
					floats = false,
					sidebars = {
						enable = false,
					},
				},
			},
		})
	end,
}

M.nightfox = {
	"EdenEast/nightfox.nvim",
	event = "VimEnter",
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
		})
	end,
}

M.onedarkpro = {
	"olimorris/onedarkpro.nvim",
	event = "VimEnter",
	priority = 1000, -- Ensure it loads first
	config = function()
		require("onedarkpro").setup({
			options = {
				transparency = vim.g.transparent_enabled,
				cursorline = true,
			},
		})
	end,
}

M.everforest = {
	"sainnhe/everforest",
	event = "VimEnter",
	priority = 1000,
	config = function()
		-- Optionally configure and load the colorscheme
		-- directly inside the plugin declaration.
		vim.g.everforest_enable_italic = true
	end,
}

return M
