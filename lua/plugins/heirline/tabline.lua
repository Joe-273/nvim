local utils = require("heirline.utils")
local public_comp = require("plugins.heirline.public-comp")

local default_bg = public_comp.default_bg

-- [[ bufferline component ]] start
-- a nice "x" button to close the buffer
local TablineCloseButton = {
	condition = function(self)
		return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
	end,
	-- public_comp.Spacer,
	{
		provider = "  ",
		hl = function(self)
			return {
				fg = self.is_active and "hl_constant" or "dark_fg",
				bg = (self.is_active or vim.g.transparent_enabled) and "NONE" or "dark_bg",
			}
		end,
		on_click = {
			callback = function(_, minwid)
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
					vim.cmd.redrawtabline()
				end)
			end,
			minwid = function(self)
				return self.bufnr
			end,
			name = "heirline_tabline_close_buffer_callback",
		},
	},
}

-- The final touch!
local TablineBufferLeftIndicator = {
	{
		provider = "│",
		hl = function(self)
			return {
				fg = self.is_active and "hl_constant" or "dark_fg",
				bg = default_bg,
				bold = true,
			}
		end,
	},
	{
		provider = " ",
		hl = function(self)
			return {
				fg = self.is_active and "hl_constant" or "dark_fg",
				bg = (self.is_active or vim.g.transparent_enabled) and "NONE" or "dark_bg",
				bold = true,
			}
		end,
	},
}
local TablineBufferBlock = { TablineBufferLeftIndicator, public_comp.TablineFileNameBlock, TablineCloseButton }

-- and here we go
local BufferLine = utils.make_buflist(
	TablineBufferBlock,
	{ provider = "│← ", hl = { fg = "dark_fg", bg = default_bg } }, -- left truncation, optional (defaults to "<")
	{ provider = " →│", hl = { fg = "dark_fg", bg = default_bg } } -- right trunctation, also optional (defaults to ...... yep, ">")
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
vim.api.nvim_create_autocmd({ "UIEnter", "BufAdd", "BufDelete" }, {
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
			self.title = "[ NEO-TREE ]"
			self.hl = { bg = default_bg }
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
