local utils = require("heirline.utils")
local public_comp = require("plugins.heirline.public-comp")

local buffer_inactive_fg = "dark_fg"
local buffer_inactive_bg = "dark_bg"
local buffer_active_fg = require("plugins.heirline.public-comp").vimode_color
local buffer_active_bg = require("plugins.heirline.public-comp").active_filename_block_bg

-- [[ bufferline component ]] start
-- a nice "x" button to close the buffer
local TablineCloseButton = {
	condition = function(self)
		return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
	end,
	-- public_comp.Spacer,
	{
		provider = " ",
		on_click = {
			callback = function(_, minwid)
				vim.schedule(function()
					-- vim.api.nvim_buf_delete(minwid, { force = false })
					require("bufdelete").bufdelete(minwid, false) -- use bufdelete plugin
					vim.cmd.redrawtabline()
				end)
			end,
			minwid = function(self)
				return self.bufnr
			end,
			name = "heirline_tabline_close_buffer_callback",
		},
	},
	{
		provider = "",
		hl = function(self)
			return {
				fg = self.is_active and buffer_active_bg or buffer_inactive_bg,
				bg = buffer_inactive_bg,
			}
		end,
	},
}

-- [[ TablineFileNameBlock Component ]] start
local TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
		end,
		provider = "  ",
		hl = { fg = "hl_string" },
	},
}

local TablineFileNameBlock = {
	init = function(self)
		local bufnr = self.bufnr and self.bufnr or 0
		self.filename = vim.api.nvim_buf_get_name(bufnr)
	end,
	{
		provider = "",
		hl = function(self)
			return {
				fg = self.is_active and buffer_active_bg or buffer_inactive_bg,
				bg = buffer_inactive_bg,
			}
		end,
	},
	public_comp.FileIcon,
	{
		public_comp.FileName,
		hl = function(self)
			return {
				fg = self.is_active and buffer_active_fg() or buffer_inactive_fg,
				bold = self.is_active or self.is_visible,
				italic = self.is_active,
			}
		end,
	},
	TablineFileFlags,
	hl = function()
		return {
			fg = "dark_fg",
		}
	end,
}

TablineFileNameBlock = vim.tbl_extend("force", TablineFileNameBlock, {
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

-- The final touch!
local TablineBufferLeftIndicator = {
	{
		provider = "│",
		hl = function()
			return {
				fg = "dark_fg",
				bg = buffer_inactive_bg,
				bold = true,
			}
		end,
	},
}
local TablineBufferBlock = {
	TablineBufferLeftIndicator,
	TablineFileNameBlock,
	TablineCloseButton,
	hl = function(self)
		return {
			fg = self.is_active and buffer_active_fg() or buffer_inactive_fg,
			bg = self.is_active and buffer_active_bg or buffer_inactive_bg,
		}
	end,
}

-- and here we go
local BufferLine = utils.make_buflist(
	TablineBufferBlock,
	{ provider = "│← ", hl = { fg = "dark_fg" } }, -- left truncation, optional (defaults to "<")
	{ provider = " →│", hl = { fg = "dark_fg" } } -- right trunctation, also optional (defaults to ...... yep, ">")
	-- by the way, open a lot of buffers and try clicking them ;)
)

-- this is the default function used to retrieve buffers
local get_bufs = function()
	return vim.tbl_filter(function(bufnr)
		return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
	end, vim.api.nvim_list_bufs())
end

-- initialize the buflist cache
local buflist_cache = {}

-- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
vim.api.nvim_create_autocmd({ "UIEnter", "BufAdd", "BufDelete", "ModeChanged" }, {
	callback = function()
		vim.schedule(function()
			local buffers = get_bufs()
			for i, v in ipairs(buffers) do
				buflist_cache[i] = v
			end
			for i = #buffers + 1, #buflist_cache do
				buflist_cache[i] = nil
			end

			-- check how many buffers we have and set showtabline accordingly
			if #buflist_cache > 1 then
				vim.o.showtabline = 2 -- always
			elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
				vim.o.showtabline = 1 -- only when #tabpages > 1
			end
		end)
	end,
})
-- [[ bufferline component ]] end

local TabLineOffset = {
	condition = function(self)
		local win = vim.api.nvim_tabpage_list_wins(0)[1]
		local bufnr = vim.api.nvim_win_get_buf(win)
		self.winid = win

		if vim.bo[bufnr].filetype == "neo-tree" then
			self.title = "[NEO-TREE]"
			self.hl = { fg = buffer_inactive_fg, bg = buffer_inactive_bg }
			return true
			-- elseif vim.bo[bufnr].filetype == "TagBar" then
			--     ...
		end
	end,

	provider = function(self)
		local title = self.title
		local width = vim.api.nvim_win_get_width(self.winid)
		local pad = math.ceil((width - #title) / 2)
		return string.rep(" ", pad - 1) .. title .. string.rep(" ", pad)
	end,

	hl = function(self)
		if vim.api.nvim_get_current_win() == self.winid then
			return "TablineFill"
		else
			return "Tabline"
		end
	end,
}

return { TabLineOffset, BufferLine }
