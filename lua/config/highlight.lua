local theme_colors = require("config.theme-colors")

local M = {}

M.set_highlight = function()
	local set_hl = vim.api.nvim_set_hl

	-- Base highlight setting
	set_hl(0, "NormalFloat", { link = "Normal" })
	set_hl(0, "FoldColumn", { link = "Normal" })
	set_hl(0, "FloatBorder", { link = "NonText" })
	set_hl(0, "Matchparen", { link = "LspReferenceText" })

	-- Custom highlight group
	local NonText_Color = vim.api.nvim_get_hl(0, { name = "NonText" })
	set_hl(0, "Comment", { fg = NonText_Color.fg })
	if vim.g.transparent_enabled then
		set_hl(0, "TabLineFill", { bg = theme_colors.get_origin_theme_colors().dark_bg })
	end

	-- Native highlight
	set_hl(0, "WinBar", { link = "FloatBorder" })
	set_hl(0, "WinBarNC", { link = "FloatBorder" })
	set_hl(0, "CursorLineNr", { link = "Normal" })
	set_hl(0, "WinSeparator", { link = "FloatBorder" })

	-- Neo-tree highlight
	set_hl(0, "NeoTreeNormal", { link = "Normal" })
	set_hl(0, "NeoTreeEndOfBuffer", { link = "Normal" })
	set_hl(0, "NeoTreeNormalNC", { link = "NormalNC" })
	set_hl(0, "NeoTreeFloatTitle", { link = "Normal" })
	set_hl(0, "NeoTreeWinSeparator", { link = "WinSeparator" })
	set_hl(0, "NeoTreeDirectoryIcon", { link = "Directory" })
	set_hl(0, "NeoTreeRootName", { link = "NeoTreeFileName" })

	-- Dropbar highlight
	set_hl(0, "DropBarMenuHoverEntry", { link = "Visual" })
	set_hl(0, "DropBarIconKindFolder", { link = "Directory" })

	-- Telescope highlight
	set_hl(0, "TelescopeNormal", { link = "Normal" })
	set_hl(0, "TelescopeBorder", { link = "FloatBorder" })

	set_hl(0, "TroubleCount", { link = "TroubleIconBoolean" })
	set_hl(0, "WhichKeyTitle", { link = "FloatBorder" })
end

return M
