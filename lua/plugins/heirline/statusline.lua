local conditions = require("heirline.conditions")
local public_comp = require("plugins.heirline.public-comp")
local utils = require("heirline.utils")
local sign_icons = require("config.icons").sign

-- Difined Colors Variable
local vimode_name = require("plugins.heirline.public-comp").vimode_name
local vimode_color = require("plugins.heirline.public-comp").vimode_color
local default_bg = require("plugins.heirline.public-comp").default_bg
local filename_bg = require("plugins.heirline.public-comp").active_filename_block_bg

-- [[ Helper Component ]]
local Spacer = { provider = "  ", hl = { fg = "NONE" } }
local Fill = { provider = "%=", hl = { fg = "NONE" } }

-- [[ ViMode Component ]] start
local ViMode = {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attributie
	{
		-- We can now access the value of mode() that, by now, would have been
		-- computed by `init()` and use it to index our strings dictionary.
		-- note how `static` fields become just regular attributes once the
		-- component is instantiated.
		-- To be extra meticulous, we can also add some vim statusline syntax to
		-- control the padding and make sure our string is always at least 2
		-- characters long. Plus a nice Icon.
		provider = function()
			return "  %2(" .. vimode_name() .. "%) "
		end,
		-- Same goes for the highlight. Now the foreground will change according to the current mode.
		hl = function()
			return { fg = "base_bg", bg = vimode_color(), bold = true }
		end,
		-- Re-evaluate the component only on ModeChanged event!
		-- Also allows the statusline to be re-evaluated when entering operator-pending mode
		-- update = {
		-- 	"ModeChanged",
		-- 	pattern = "*:*",
		-- 	callback = vim.schedule_wrap(function()
		-- 		vim.cmd("redrawstatus")
		-- 	end),
		-- },
	},
	{
		provider = "",
		hl = function()
			return { fg = vimode_color(), bold = true }
		end,
	},
}
-- [[ ViMode Component ]] end

-- [[ StatuslineFileNameBlock Component ]] start
local StatuslineFileNameBlock = {
	-- let's first set up some attributes needed by this component and its children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

-- let's add the children to our FileNameBlock component
StatuslineFileNameBlock = utils.insert(StatuslineFileNameBlock, {
	{
		public_comp.FileIcon,
		public_comp.FileName,
		public_comp.FileFlags,
		{
			provider = " ",
		},
		{
			provider = "",
			hl = { fg = filename_bg, bg = default_bg },
		},
	},
})
-- [[ StatuslineFileNameBlock Component ]] end

-- [[ Git Component ]] start
local Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = "hl_function" },

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
local Diagnostics = {

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

	hl = { fg = "hl_operator" },
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
-- [[ Diagnostics Component ]] end

-- [[ LSP Component ]] start
local LSPActive = {
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
	hl = { fg = "hl_string", bold = true },
	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
}
-- [[ LSP Component ]] end

-- [[ Ruler Component ]] start
local Ruler = {
	{
		provider = "",
		hl = function()
			return { fg = vimode_color(), bold = true }
		end,
	},
	{
		-- %l = current line number
		-- %L = number of lines in the buffer
		-- %c = column number
		-- %P = percentage through file of displayed window
		provider = " %7(%l/%3L%):%2c | %P ",
		hl = function()
			return { fg = "base_bg", bg = vimode_color(), bold = true }
		end,
	},
}
-- [[ Ruler Component ]] end

-- [[ FINAL COMPONENT ]] --
return {
	{
		ViMode,
		Spacer,
		StatuslineFileNameBlock,
		hl = function()
			return {
				bg = filename_bg,
				fg = vimode_color(),
			}
		end,
	},
	Spacer,
	Git,
	Spacer,
	Diagnostics,
	Fill,
	LSPActive,
	Spacer,
	Ruler,
	hl = { bg = default_bg },
}
