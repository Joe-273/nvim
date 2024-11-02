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
	local reserve = {
		base_bg = "#2d2d2d",
		base_fg = "#c9d1d9",
		dark_bg = "#1f1f1f",
		dark_fg = "#b9bbbe",
		hl_constant = "#e3b341",
		hl_string = "#a6d8e7",
		hl_statement = "#5f5fd5",
		hl_function = "#61afef",
		hl_special = "#d5a5d4",
		hl_operator = "#ff5c8e",
		diag_warn = "#e5c07b",
		diag_error = "#ff6c6b",
		diag_hint = "#56b6c2",
		diag_info = "#61afef",
		git_del = "#e06c75",
		git_add = "#98c379",
		git_change = "#e5c07b",
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
	-- native highlight
	vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
	vim.api.nvim_set_hl(0, "FloatBorder", { link = "NonText" })
	vim.api.nvim_set_hl(0, "WinSeparator", { link = "FloatBorder" })

	-- neo-tree highlight
	vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "NormalNC" })
	vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { link = "Normal" })
	vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { link = "WinSeparator" })

	vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
	vim.api.nvim_set_hl(0, "TroubleCount", { link = "TroubleIconBoolean" })

	vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { link = "Visual" })
end

return M
