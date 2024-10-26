-- setup base colors
require("plugins.heirline.colors")

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- Difined Components Table
local M = {}

-- [[ Helper ]] start
M.Spacer = { provider = "  ", hl = { fg = "NONE" } }
M.Fill = { provider = "%=", hl = { fg = "NONE" } }
M.__modeStatic__ = {
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
		n = "blue",
		i = "green",
		v = "cyan",
		V = "cyan",
		["\22"] = "cyan",
		c = "red",
		s = "purple",
		S = "purple",
		["\19"] = "purple",
		R = "orange",
		r = "orange",
		["!"] = "red",
		t = "red",
	},
}

-- [[ Helper ]] end

-- [[ ViMode Component ]] start
M.ViMode = {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	{
		provider = " ",
		hl = function(self)
			local mode = self.mode:sub(1, 1) -- get only the first mode character
			return { bg = "NONE", fg = M.__modeStatic__.mode_colors[mode], bold = true }
		end,
	},
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	provider = function(self)
		return "  %2(" .. M.__modeStatic__.mode_names[self.mode] .. "%) "
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = "bright_bg", bg = M.__modeStatic__.mode_colors[mode], bold = true }
	end,
	-- Re-evaluate the component only on ModeChanged event!
	-- Also allows the statusline to be re-evaluated when entering operator-pending mode
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}
-- [[ ViMode Component ]] end

-- [[ Git Component ]] start
M.Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = "orange" },

	{ -- git branch name
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		hl = { bold = true },
	},
	-- You could handle delimiters, icons and counts similar to Diagnostics
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = "[",
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("+" .. count)
		end,
		hl = { fg = "git_add" },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("-" .. count)
		end,
		hl = { fg = "git_del" },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("~" .. count)
		end,
		hl = { fg = "git_change" },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = "]",
	},
}
-- [[ Git Component ]] end

-- [[ Diagnostics Component ]] start
M.Diagnostics = {

	condition = conditions.has_diagnostics,

	static = {
		error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = "diag_error" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = "diag_warn" },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = "diag_info" },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = "diag_hint" },
	},
}
-- [[ Diagnostics Component ]] end

-- [[ FileNameBlock Component ]] start
M.FileNameBlock = {
	-- let's first set up some attributes needed by this component and its children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

local function __shorten_path__(path)
	local separator = package.config:sub(1, 1)

	local head_separator = path:match("^(.-)" .. separator)
	local parent_dir = vim.fn.fnamemodify(path, ":h:t")
	local file_name = vim.fn.fnamemodify(path, ":t")

	if head_separator == nil then
		-- not a normal path
		return file_name
	end
	return head_separator .. separator .. "..." .. separator .. parent_dir .. separator .. file_name
end

-- 使用这个函数来替代 `vim.fn.pathshorten`
local __FileNameBlockHelper__ = {
	-- We can now define some children separately and add them later
	FileIcon = {
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
			return { fg = self.icon_color }
		end,
	},

	FileName = {
		provider = function(self)
			-- first, trim the pattern relative to the current directory. For other
			-- options, see :h filename-modifers
			local filename = vim.fn.fnamemodify(self.filename, ":.")
			if filename == "" then
				return "[No Name]"
			end
			-- now, if the filename would occupy more than 1/4th of the available
			-- space, we trim the file path to its initials
			-- See Flexible Components section below for dynamic truncation
			if not conditions.width_percent_below(#filename, 0.25) then
				filename = __shorten_path__(filename)
			end
			-- replace backslashes with greater-than symbol
			filename = filename:gsub("\\", " ")
			return "[" .. filename .. "]"
		end,
		hl = { fg = "NONE" },
	},

	FileFlags = {
		{
			condition = function()
				return vim.bo.modified
			end,
			provider = "",
			hl = { fg = "green" },
		},
		{
			condition = function()
				return not vim.bo.modifiable or vim.bo.readonly
			end,
			provider = "",
			hl = { fg = "orange" },
		},
	},

	-- Now, let's say that we want the filename color to change if the buffer is
	-- modified. Of course, we could do that directly using the FileName.hl field,
	-- but we'll see how easy it is to alter existing components using a "modifier"
	-- component

	FileNameModifer = {
		hl = function()
			if vim.bo.modified then
				-- use `force` because we need to override the child's hl foreground
				return { fg = "cyan", bold = true, force = true }
			end
		end,
	},
}

-- let's add the children to our FileNameBlock component
M.FileNameBlock = utils.insert(
	M.FileNameBlock,
	__FileNameBlockHelper__.FileIcon,
	utils.insert(__FileNameBlockHelper__.FileNameModifer, __FileNameBlockHelper__.FileName), -- a new table where FileName is a child of FileNameModifier
	__FileNameBlockHelper__.FileFlags,
	{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)
-- [[ FileNameBlock Component ]] end

-- [[ LSP Component ]] start
M.LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },

	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
	provider = function()
		local names = {}
		for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " [" .. table.concat(names, " ") .. "]"
	end,
	hl = { fg = "green", bold = true },
}
-- [[ LSP Component ]] end

-- [[ Ruler Component ]] start
M.Ruler = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	{
		provider = " ",
		hl = function(self)
			local mode = self.mode:sub(1, 1) -- get only the first mode character
			return { bg = "NONE", fg = M.__modeStatic__.mode_colors[mode], bold = true }
		end,
	},
	{
		-- %l = current line number
		-- %L = number of lines in the buffer
		-- %c = column number
		-- %P = percentage through file of displayed window
		provider = " %7(%l/%3L%):%2c  %P ",
		hl = function(self)
			local mode = self.mode:sub(1, 1) -- get only the first mode character
			return { fg = "bright_bg", bg = M.__modeStatic__.mode_colors[mode], bold = true }
		end,
	},
}
-- [[ Ruler Component ]] end

return M
