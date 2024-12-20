---@diagnostic disable: assign-type-mismatch
-- [[ Store all color schemes for each theme ]]
--
local theme_maps = {
	tokyonight = {
		moon = "tokyonight-moon",
		day = "tokyonight-moon",
		night = "tokyonight-moon",
		storm = "tokyonight-moon",
	},
	catppuccin = {
		latte = "catppuccin-latte",
		frappe = "catppuccin-frappe",
		mocha = "catppuccin-mocha",
		macchiato = "catppuccin-macchiato",
	},
	github = {
		dark = "github_dark",
		light = "github_light",
		dark_dimmed = "github_dark_dimmed",
		dark_default = "github_dark_default",
		light_default = "github_light_default",
		dark_high_contrast = "github_dark_high_contrast",
		light_high_contrast = "github_light_high_contrast",
		dark_colorblind = "github_dark_colorblind",
		light_colorblind = "github_light_colorblind",
		dark_tritanopia = "github_dark_tritanopia",
		light_tritanopia = "github_light_tritanopia",
	},
	nightfox = {
		nightfox = "nightfox",
		dayfox = "dayfox",
		dawnfox = "dawnfox",
		duskfox = "duskfox",
		nordfox = "nordfox",
		terafox = "terafox",
		carbonfox = "carbonfox",
	},
	onedarkpro = {
		onedark = "onedark",
		onelight = "onelight",
		onedark_dark = "onedark_dark",
		onedark_vivid = "onedark_vivid",
	},
	everforest = {
		everforest = "everforest",
	},
}

for theme_key, theme_palettes in pairs(theme_maps) do
	for palette_key, paletee_value in pairs(theme_palettes) do
		theme_palettes[palette_key] = { theme_name = theme_key, value = paletee_value }
	end
end

return theme_maps
