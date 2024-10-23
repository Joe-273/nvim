local utils = require("heirline.utils")

local defaults = {
	bright_bg = "#2E3440",
	bright_fg = "#D8DEE9",
	red = "#BF616A",
	dark_red = "#BF616A",
	green = "#A3BE8C",
	blue = "#5E81AC",
	gray = "#4C566A",
	orange = "#D19A66",
	purple = "#B48EAD",
	cyan = "#88C0D0",
	diag_warn = "#EBCB8B",
	diag_error = "#BF616A",
	diag_hint = "#88C0D0",
	diag_info = "#A3BE8C",
	git_del = "#BF616A",
	git_add = "#A3BE8C",
	git_change = "#D19A66",
}

local colors = {
	bright_bg = utils.get_highlight("Folded").bg,
	bright_fg = utils.get_highlight("Folded").fg,
	red = utils.get_highlight("DiagnosticError").fg,
	dark_red = utils.get_highlight("DiffDelete").bg,
	green = utils.get_highlight("String").fg,
	blue = utils.get_highlight("Function").fg,
	gray = utils.get_highlight("NonText").fg,
	orange = utils.get_highlight("Constant").fg,
	purple = utils.get_highlight("Statement").fg,
	cyan = utils.get_highlight("Special").fg,
	diag_warn = utils.get_highlight("DiagnosticWarn").fg,
	diag_error = utils.get_highlight("DiagnosticError").fg,
	diag_hint = utils.get_highlight("DiagnosticHint").fg,
	diag_info = utils.get_highlight("DiagnosticInfo").fg,
	git_del = utils.get_highlight("diffDeleted").fg,
	git_add = utils.get_highlight("diffAdded").fg,
	git_change = utils.get_highlight("diffChanged").fg,
}

-- Merge two table
for key, value in pairs(defaults) do
	if colors[key] == nil or colors[key] == "" then
		colors[key] = value
	end
end

require("heirline").load_colors(colors)
