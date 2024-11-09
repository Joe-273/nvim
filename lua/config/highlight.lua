---@diagnostic disable: assign-type-mismatch

local function __get_highlight_group(group)
	local success, hl_group = pcall(vim.api.nvim_get_hl, 0, { name = group })
	if success and hl_group then
		return hl_group
	else
		vim.notify("Highlight group '" .. group .. "' does not exist.", vim.log.levels.WARN)
	end
	return nil
end

local function get_highlight_group_fg(group)
	local color = __get_highlight_group(group).fg
	if color then
		return color
	end
	-- vim.notify("Highight group '" .. group .. "' does not have a [foreground] color.", vim.log.levels.WARN)
	return nil
end

local function get_highlight_group_bg(group)
	local color = __get_highlight_group(group).bg
	if color then
		return color
	end
	-- vim.notify("Highight group '" .. group .. "' does not have a [background] color.", vim.log.levels.WARN)
	return nil
end

local M = {}

M.get_colors = function()
	-- default value of onedarkpro
	local reserve = {
		base_bg = "#282c34",
		base_fg = "#abb2bf",
		dark_bg = "#282c34",
		dark_fg = "#5c6370",
		hl_constant = "#d19a66",
		hl_string = "#98c379",
		hl_statement = "#c678dd",
		hl_function = "#61afef",
		hl_special = "#61afef",
		hl_operator = "#56b6c2",
		diag_warn = "#e5c07b",
		diag_error = "#e06c75",
		diag_hint = "#56b6c2",
		diag_info = "#61afef",
		git_del = "#9a353d",
		git_add = "#109868",
		git_change = "#948b60",
	}

	local color_values = {
		base_bg = get_highlight_group_bg("Normal"),
		base_fg = get_highlight_group_fg("Normal"),
		dark_bg = get_highlight_group_bg("TablineFill"),
		dark_fg = get_highlight_group_fg("NonText"),
		hl_constant = get_highlight_group_fg("Constant"),
		hl_string = get_highlight_group_fg("String"),
		hl_statement = get_highlight_group_fg("Statement"),
		hl_function = get_highlight_group_fg("Function"),
		hl_special = get_highlight_group_fg("Special"),
		hl_operator = get_highlight_group_fg("Operator"),
		diag_warn = get_highlight_group_fg("DiagnosticWarn"),
		diag_error = get_highlight_group_fg("DiagnosticError"),
		diag_hint = get_highlight_group_fg("DiagnosticHint"),
		diag_info = get_highlight_group_fg("DiagnosticInfo"),
		git_del = get_highlight_group_fg("diffRemoved") or get_highlight_group_fg("GitSignsDelete"),
		git_add = get_highlight_group_fg("diffAdded") or get_highlight_group_fg("GitSignsAdd"),
		git_change = get_highlight_group_fg("diffChanged") or get_highlight_group_fg("GitSignsChange"),
	}

	for key, value in pairs(reserve) do
		color_values[key] = color_values[key] or value
	end

	return color_values
end

M.set_highlight = function()
	-- base highlight setting
	vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
	vim.api.nvim_set_hl(0, "FloatBorder", { link = "NonText" })
	vim.api.nvim_set_hl(0, "Matchparen", { link = "LspReferenceText" })

	-- native highlight
	vim.api.nvim_set_hl(0, "WinBar", { link = "FloatBorder" })
	vim.api.nvim_set_hl(0, "WinBarNC", { link = "FloatBorder" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Normal" })
	vim.api.nvim_set_hl(0, "WinSeparator", { link = "FloatBorder" })

	-- neo-tree highlight
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { link = "Normal" })
	vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "NormalNC" })
	vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { link = "Normal" })
	vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { link = "WinSeparator" })
	vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { link = "Directory" })
	vim.api.nvim_set_hl(0, "NeoTreeRootName", { link = "NeoTreeFileName" })

	-- dropbar highlight
	vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { link = "Visual" })
	vim.api.nvim_set_hl(0, "DropBarIconKindFolder", { link = "Directory" })

	-- telescope highlight
	vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })

	vim.api.nvim_set_hl(0, "TroubleCount", { link = "TroubleIconBoolean" })
	vim.api.nvim_set_hl(0, "WhichKeyTitle", { link = "FloatBorder" })
end

return M
