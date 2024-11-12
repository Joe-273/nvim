local conditions = require("heirline.conditions")
local Public_Comp = require("plugins.heirline.public-comp")

local Vimode = Public_Comp.Vimode
local File_comp = Public_Comp.File_Components

local function get_color(color)
	if type(color) == "function" then
		return color()
	else
		return color
	end
end

--- @param main_color function|string
--- @param dark_bg_color function|string
--- @param sub_bg_color function|string
--- @return table [[ Vimode & Current buffer ]] Component
local Vimode_Currentbuffer = function(main_color, dark_bg_color, sub_bg_color)
	-- Determine whether it is a function. If it is, call it. Otherwise, return the value directly

	local _Vimode = {
		{
			provider = function()
				return "  %2(" .. Vimode.current_name() .. "%) "
			end,
			hl = function()
				return { fg = get_color(dark_bg_color), bg = get_color(main_color), bold = true }
			end,
		},
		{
			provider = "",
			hl = function()
				return { fg = get_color(main_color), bold = true }
			end,
		},
	}
	local _Currentbuffer = {
		init = function(self)
			self.filename = vim.api.nvim_buf_get_name(0)
		end,
		{
			{
				provider = " ",
			},
			File_comp.Icon_block,
			File_comp.Name_block,
			File_comp.Flag_block,
			{
				provider = " ",
			},
			{
				provider = "",
				hl = { fg = get_color(sub_bg_color), bg = get_color(dark_bg_color) },
			},
		},
	}
	return {
		_Vimode,
		_Currentbuffer,
		hl = function()
			return { fg = get_color(main_color), bg = get_color(sub_bg_color) }
		end,
	}
end

--- @param main_color function|string
--- @return table [[ Git Block ]] Component
local Git_Block = function(main_color)
	return {
		condition = conditions.is_git_repo,

		init = function(self)
			self.status_dict = vim.b.gitsigns_status_dict
			self.has_changes = self.status_dict.added ~= 0
				or self.status_dict.removed ~= 0
				or self.status_dict.changed ~= 0
		end,

		hl = { fg = get_color(main_color) },

		{ -- git branch name
			provider = function(self)
				return " " .. self.status_dict.head
			end,
			hl = { bold = true },
		},
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
end

--- @param main_color function|string
--- @return table [[ Diagnostics Block ]] Component
local Diagnostics_Block = function(main_color)
	local sign_icons = require("config.icons").sign

	return {
		condition = conditions.has_diagnostics,

		static = {
			error_icon = sign_icons.error,
			warn_icon = sign_icons.warn,
			info_icon = sign_icons.info,
			hint_icon = sign_icons.hint,
		},

		init = function(self)
			self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
			self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
			self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		end,

		update = { "DiagnosticChanged", "BufEnter" },

		hl = { fg = get_color(main_color) },
		{
			provider = " [",
		},
		{
			provider = function(self)
				local dynamic_space = ""
				if self.warnings > 0 or self.info > 0 or self.hints > 0 then
					dynamic_space = " "
				end
				return self.errors > 0 and (self.error_icon .. self.errors .. dynamic_space)
			end,
			hl = { fg = "diag_error" },
		},
		{
			provider = function(self)
				local dynamic_space = ""
				if self.info > 0 or self.hints > 0 then
					dynamic_space = " "
				end
				return self.warnings > 0 and (self.warn_icon .. self.warnings .. dynamic_space)
			end,
			hl = { fg = "diag_warn" },
		},
		{
			provider = function(self)
				local dynamic_space = ""
				if self.hints > 0 then
					dynamic_space = " "
				end
				return self.info > 0 and (self.info_icon .. self.info .. dynamic_space)
			end,
			hl = { fg = "diag_info" },
		},
		{
			provider = function(self)
				return self.hints > 0 and (self.hint_icon .. self.hints)
			end,
			hl = { fg = "diag_hint" },
		},
		{
			provider = "]",
		},
	}
end

--- @param main_color function|string
--- @return table [[ LSP Block ]] Component
local LSP_Block = function(main_color)
	return {
		condition = conditions.lsp_attached,
		update = { "LspAttach", "LspDetach" },
		{
			provider = function()
				local names = {}
				for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " [" .. table.concat(names, " ") .. "]"
			end,
		},
		hl = { fg = get_color(main_color), bold = true },
	}
end

--- @param main_color function|string
--- @param dark_bg_color function|string
--- @return table [[ Ruler Block ]] Component
local Ruler_Block = function(main_color, dark_bg_color)
	return {
		{
			provider = "",
			hl = function()
				return { fg = get_color(main_color), bold = true }
			end,
		},
		{
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			-- %P = percentage through file of displayed window
			provider = " %7(%l/%3L%):%2c | %P ",
			hl = function()
				return { fg = get_color(dark_bg_color), bg = get_color(main_color), bold = true }
			end,
		},
	}
end

-- [[ FINAL COMPONENT ]] --
local Specific_var = Public_Comp.Specific_var -- public variable

local diagnostics_block_main_fg = "hl_operator"
local git_block_main_fg = "hl_function"
local lsp_block_main_fg = "hl_string"

-- Helper Component
local Spacer = { provider = "  " }
local Fill = { provider = "%=" }

return {
	Vimode_Currentbuffer(Vimode.current_color, Specific_var.default_dark_bg, Specific_var.active_filename_block_bg),
	Spacer,
	Git_Block(git_block_main_fg),
	Spacer,
	Diagnostics_Block(diagnostics_block_main_fg),
	Fill,
	LSP_Block(lsp_block_main_fg),
	Spacer,
	Ruler_Block(Vimode.current_color, Specific_var.default_dark_bg),

	hl = { bg = Specific_var.default_dark_bg },
}
