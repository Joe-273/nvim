local vimode_names = {
	n = "N",
	no = "N?",
	nov = "N?",
	noV = "N?",
	["no\22"] = "N?",
	niI = "Ni",
	niR = "Nr",
	niV = "Nv",
	nt = "Nt",
	v = "V",
	vs = "Vs",
	V = "V_",
	Vs = "Vs",
	["\22"] = "^V",
	["\22s"] = "^V",
	s = "S",
	S = "S_",
	["\19"] = "^S",
	i = "I",
	ic = "Ic",
	ix = "Ix",
	R = "R",
	Rc = "Rc",
	Rx = "Rx",
	Rv = "Rv",
	Rvc = "Rv",
	Rvx = "Rv",
	c = "C",
	cv = "Ex",
	r = "...",
	rm = "M",
	["r?"] = "?",
	["!"] = "!",
	t = "T",
}
local vimode_colors = {
	n = "hl_constant",
	i = "hl_string",
	v = "hl_statement",
	V = "hl_statement",
	["\22"] = "hl_statement",
	c = "hl_function",
	s = "hl_function",
	S = "hl_function",
	["\19"] = "hl_function",
	R = "hl_special",
	r = "hl_special",
	["!"] = "hl_operator",
	t = "hl_operator",
	nt = "hl_special",
}

local M = {}

-- [[ Specific variable ]] start
M.Specific_var = {
	default_dark_bg = vim.g.transparent_enabled and "NONE" or "dark_bg",
	active_filename_block_bg = "#444444",
	buffer_modify_fg = "hl_string",
	buffer_lockfile_fg = "hl_special",
}
-- [[ Specific variable ]] end

-- [[ Vimode ]] start
M.Vimode = {
	current_color = function()
		return vimode_colors[vim.fn.mode(1)]
	end,
	current_name = function()
		return vimode_names[vim.fn.mode(1)]
	end,
}
-- [[ Vimode ]] end

-- [[ File Components ]] start
M.File_Components = {
	Icon_block = {
		init = function(self)
			local filename = vim.fn.fnamemodify(self.filename, ":t")
			local extension = vim.fn.fnamemodify(self.filename, ":e")
			self.icon, self.icon_color =
				require("nvim-web-devicons").get_icon_color(filename, extension, { strict = true })
		end,
		provider = function(self)
			return self.icon and (self.icon .. " ")
		end,
		hl = function(self)
			return {
				fg = self.icon_color,
			}
		end,
	},
	Name_block = {
		provider = function(self)
			-- self.filename will be defined later, just keep looking at the example!
			local filename = vim.fn.fnamemodify(self.filename, ":t")

			if filename == "" then
				return "NONE"
			elseif filename == "neo-tree filesystem [1]" then
				return "NEO-TREE"
			else
				return filename
			end
		end,
	},
	Flag_block = {
		{
			condition = function()
				return vim.bo.modified
			end,
			provider = "  ",
			hl = { fg = M.Specific_var.buffer_modify_fg },
		},
		{
			condition = function()
				return not vim.bo.modifiable or vim.bo.readonly
			end,
			provider = "  ",
			hl = { fg = M.Specific_var.buffer_lockfile_fg },
		},
	},
}
-- [[ File Components ]] end

-- specific colors
M.default_dark_bg = vim.g.transparent_enabled and "NONE" or "dark_bg"
M.active_filename_block_bg = "#444444"
M.buffer_modify_fg = "hl_string"
M.buffer_lockfile_fg = "hl_special"
M.vimode_color = function()
	return M.mode_static.mode_colors[vim.fn.mode(1)]
end
M.vimode_name = function()
	return M.mode_static.mode_names[vim.fn.mode(1)]
end

-- [[ Helper ]] start
M.mode_static = {
	mode_names = { -- change the strings if you like it vvvvverbose!
		n = "N",
		no = "N?",
		nov = "N?",
		noV = "N?",
		["no\22"] = "N?",
		niI = "Ni",
		niR = "Nr",
		niV = "Nv",
		nt = "Nt",
		v = "V",
		vs = "Vs",
		V = "V_",
		Vs = "Vs",
		["\22"] = "^V",
		["\22s"] = "^V",
		s = "S",
		S = "S_",
		["\19"] = "^S",
		i = "I",
		ic = "Ic",
		ix = "Ix",
		R = "R",
		Rc = "Rc",
		Rx = "Rx",
		Rv = "Rv",
		Rvc = "Rv",
		Rvx = "Rv",
		c = "C",
		cv = "Ex",
		r = "...",
		rm = "M",
		["r?"] = "?",
		["!"] = "!",
		t = "T",
	},
	mode_colors = {
		n = "hl_constant",
		i = "hl_string",
		v = "hl_statement",
		V = "hl_statement",
		["\22"] = "hl_statement",
		c = "hl_function",
		s = "hl_function",
		S = "hl_function",
		["\19"] = "hl_function",
		R = "hl_special",
		r = "hl_special",
		["!"] = "hl_operator",
		t = "hl_operator",
		nt = "hl_special",
	},
}
-- [[ Helper ]] end

M.FileIcon = {
	init = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":t")
		local extension = vim.fn.fnamemodify(self.filename, ":e")
		self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { strict = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return {
			fg = self.icon_color,
		}
	end,
}

-- We can now define some children separately and add them later
M.FileName = {
	provider = function(self)
		-- self.filename will be defined later, just keep looking at the example!
		local filename = vim.fn.fnamemodify(self.filename, ":t")

		if filename == "" then
			return "NONE"
		elseif filename == "neo-tree filesystem [1]" then
			return "NEO-TREE"
		else
			return filename
		end
	end,
}

M.FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "  ",
		hl = { fg = M.buffer_modify_fg },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = "  ",
		hl = { fg = M.buffer_lockfile_fg },
	},
}

return M
