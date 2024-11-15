local M = {}
local origin_theme_colors = {}

local reserve_color_map = {
	-- Default value of onedarkpro
	base_bg = "#1e1e2e",
	base_fg = "#d9e0ee",
	dark_bg = "#181825",
	dark_fg = "#c7b7d2",
	hl_constant = "#ee99dd",
	hl_string = "#a6e3a1",
	hl_statement = "#b4beig",
	hl_function = "#82aaff",
	hl_special = "#82aaff",
	hl_operator = "#7e86c8",
	diag_warn = "#f7bd51",
	diag_error = "#f38ba8",
	diag_hint = "#7e86c8",
	diag_info = "#82aaff",
	git_del = "#f38ba8",
	git_add = "#a6e3a1",
	git_change = "#f9c859",
}

local get_highlight_group_color = function(group, attr)
	attr = attr or "fg"
	local success, hl_group = pcall(vim.api.nvim_get_hl, 0, { name = group })
	if success and hl_group then
		return hl_group[attr]
	else
		vim.notify(
			"Highlight group '" .. group .. "' does not exist or has no " .. attr .. " color.",
			vim.log.levels.WARN
		)
		return nil
	end
end

local function create_origin_theme_colors()
	return {
		base_bg = get_highlight_group_color("Normal", "bg"),
		base_fg = get_highlight_group_color("Normal"),
		dark_bg = get_highlight_group_color("TabLineFill", "bg"),
		dark_fg = get_highlight_group_color("NonText"),
		hl_constant = get_highlight_group_color("Constant"),
		hl_string = get_highlight_group_color("String"),
		hl_statement = get_highlight_group_color("Statement"),
		hl_function = get_highlight_group_color("Function"),
		hl_special = get_highlight_group_color("Special"),
		hl_operator = get_highlight_group_color("Operator"),
		diag_warn = get_highlight_group_color("DiagnosticWarn"),
		diag_error = get_highlight_group_color("DiagnosticError"),
		diag_hint = get_highlight_group_color("DiagnosticHint"),
		diag_info = get_highlight_group_color("DiagnosticInfo"),
		git_del = get_highlight_group_color("diffRemoved") or get_highlight_group_color("GitSignsDelete", "fg"),
		git_add = get_highlight_group_color("diffAdded") or get_highlight_group_color("GitSignsAdd", "fg"),
		git_change = get_highlight_group_color("diffChanged") or get_highlight_group_color("GitSignsChange", "fg"),
	}
end

local set_origin_theme_colors = function()
	origin_theme_colors = create_origin_theme_colors()
	for key, value in pairs(reserve_color_map) do
		origin_theme_colors[key] = origin_theme_colors[key] or value
	end
end

-- Call this function when setting the theme
M.__init__ = function()
	if not rawget(M, "__is_initialized") then
		set_origin_theme_colors()
		M.is_initialized = true
	end
end

M.get_origin_theme_colors = function()
	return origin_theme_colors
end

return M
