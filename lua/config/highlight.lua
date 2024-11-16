local theme_colors = require("config.theme-colors")

local hl_link = function(hl_group, target_group)
	-- hl_group link to target_group
	vim.api.nvim_set_hl(0, hl_group, { link = target_group })
end

local hl_change = function(hl_group, target_group, callback)
	local target_hl = nil
	if target_group then
		target_hl = vim.api.nvim_get_hl(0, { name = target_group })
	end
	vim.api.nvim_set_hl(0, hl_group, callback(target_hl))
end

local set_hlgroup_italic = function(groups)
	for i = 1, #groups do
		local hl_group = groups[i]
		hl_change(hl_group, hl_group, function(hl)
			return { fg = hl.fg, bg = hl.bg, italic = true }
		end)
	end
end

local M = {}

M.set_highlight = function()
	-- Base highlight setting
	hl_link("NormalFloat", "Normal")
	hl_link("FoldColumn", "Normal")
	hl_link("FloatBorder", "NonText")
	hl_link("Matchparen", "LspReferenceText")

	-- Native highlight
	hl_link("WinBar", "FloatBorder")
	hl_link("WinBarNC", "FloatBorder")
	hl_link("CursorLineNr", "Normal")
	hl_link("WinSeparator", "FloatBorder")

	-- Neo-tree highlight
	hl_link("NeoTreeNormal", "Normal")
	hl_link("NeoTreeEndOfBuffer", "Normal")
	hl_link("NeoTreeNormalNC", "NormalNC")
	hl_link("NeoTreeFloatTitle", "Normal")
	hl_link("NeoTreeWinSeparator", "WinSeparator")
	hl_link("NeoTreeDirectoryIcon", "Directory")
	hl_link("NeoTreeRootName", "NeoTreeFileName")

	-- Dropbar highlight
	hl_link("DropBarMenuHoverEntry", "Visual")
	hl_link("DropBarIconKindFolder", "Directory")

	-- Telescope highlight
	hl_link("TelescopeNormal", "Normal")
	hl_link("TelescopeBorder", "FloatBorder")

	hl_link("TroubleCount", "TroubleIconBoolean")
	hl_link("WhichKeyTitle", "FloatBorder")

	-- [[ Custom highlight group ]]
	-- Set keyword italic style
	set_hlgroup_italic({ "Keyword", "Statement", "Conditional", "Function", "Special" })
	-- Change comment color
	hl_change("Comment", "NonText", function(hl)
		return { fg = hl.fg, italic = true }
	end)
	-- Remove bold style from Visual hl_group
	hl_change("Visual", "Visual", function(hl)
		return { fg = hl.fg, bg = hl.bg, bold = false }
	end)
	-- Keep TabLineFill bg when set transparent style
	if vim.g.transparent_enabled then
		hl_change("TabLineFill", nil, function()
			return { bg = theme_colors.get_origin_theme_colors().dark_bg }
		end)
	end
end

return M
