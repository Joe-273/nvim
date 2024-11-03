local utils = require("heirline.utils")

local M = {}

-- specific colors
M.default_bg = vim.g.transparent_enabled and "NONE" or "dark_bg"

-- [[ Helper ]] start
M.Spacer = { provider = "  ", hl = { fg = "NONE", bg = M.default_bg } }
M.Fill = { provider = "%=", hl = { fg = "NONE", bg = M.default_bg } }
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
		c = "hl_operator",
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
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return {
			fg = self.icon_color,
			bg = (self.is_active or vim.g.transparent_enabled) and "NONE" or "dark_bg",
		}
	end,
}

-- We can now define some children separately and add them later
M.FileName = {
	provider = function(self)
		-- self.filename will be defined later, just keep looking at the example!
		local filename = vim.fn.fnamemodify(self.filename, ":t")

		if filename == "" then
			return "[NONE]"
		elseif filename == "neo-tree filesystem [1]" then
			return "[NEO-TREE]"
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
		provider = " ",
		hl = { fg = "hl_string", bg = M.default_bg },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = " ",
		hl = { fg = "hl_special", bg = M.default_bg },
	},
}

-- [[ StatuslineFileNameBlock Component ]] start
M.StatuslineFileNameBlock = {
	-- let's first set up some attributes needed by this component and its children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

M.StatuslineFileNameModifer = {
	hl = function()
		if vim.bo.modified then
			-- use `force` because we need to override the child's hl foreground
			return { fg = "hl_special", bg = M.default_bg, bold = true, force = true }
		end
	end,
}

-- let's add the children to our FileNameBlock component
M.StatuslineFileNameBlock = utils.insert(
	M.StatuslineFileNameBlock,
	M.FileIcon,
	utils.insert(M.StatuslineFileNameModifer, {
		M.FileName,
		hl = function(self)
			return {
				fg = "base_fg",
				bg = (self.is_active or vim.g.transparent_enabled) and "NONE" or "dark_bg",
				bold = self.is_active or self.is_visible,
			}
		end,
	}), -- a new table where FileName is a child of FileNameModifier
	M.FileFlags,
	{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)
-- [[ StatuslineFileNameBlock Component ]] end

-- [[ TablineFileNameBlock Component ]] start
M.TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
		end,
		provider = "  ",
		hl = { fg = "hl_string" },
	},
	{
		condition = function(self)
			return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
				or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
		end,
		provider = function(self)
			if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
				return "  "
			else
				return "  "
			end
		end,
		hl = { fg = M.mode_static.mode_colors[vim.fn.mode(1)] },
	},
}

M.TablineFileNameBlock = {
	init = function(self)
		local bufnr = self.bufnr and self.bufnr or 0
		self.filename = vim.api.nvim_buf_get_name(bufnr)
	end,
	M.FileIcon,
	{
		M.FileName,
		hl = function(self)
			return {
				fg = self.is_active and "hl_constant" or "dark_fg",
				bg = (self.is_active or vim.g.transparent_enabled) and "NONE" or "dark_bg",
				bold = self.is_active or self.is_visible,
				italic = self.is_active,
			}
		end,
	},
	M.TablineFileFlags,
	hl = function(self)
		return {
			bg = (self.is_active or vim.g.transparent_enabled) and "NONE" or "dark_bg",
		}
	end,
}

M.TablineFileNameBlock = vim.tbl_extend("force", M.TablineFileNameBlock, {
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then -- close on mouse middle click
				vim.schedule(function()
					-- vim.api.nvim_buf_delete(minwid, { force = false })
					require("bufdelete").bufdelete(minwid, false) -- use bufdelete plugin
				end)
			else
				vim.api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
})
-- [[ TablineFileNameBlock Component ]] end

return M
