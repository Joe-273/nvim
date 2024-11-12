local utils = require("heirline.utils")
local Public_Comp = require("plugins.heirline.public-comp")

local File_comp = Public_Comp.File_Components
local Vimode = Public_Comp.Vimode
local Specific_var = Public_Comp.Specific_var

local function get_color(color)
	if type(color) == "function" then
		return color()
	else
		return color
	end
end

local buffer_colors = {
	active_fg_color = function()
		return get_color(Vimode.current_color)
	end,
	active_bg_color = function()
		return get_color(Specific_var.active_filename_block_bg)
	end,
	inactive_fg_color = function()
		return get_color("base_fg")
	end,
	inactive_bg_color = function()
		return get_color("dark_bg")
	end,
}

local Buffer_Filename = function()
	return {
		{
			init = function(self)
				local bufnr = self.bufnr and self.bufnr or 0
				self.filename = vim.api.nvim_buf_get_name(bufnr)
			end,
			{
				provider = "",
				hl = function(self)
					return {
						fg = self.is_active and buffer_colors.active_bg_color() or buffer_colors.inactive_bg_color(),
						bg = buffer_colors.inactive_bg_color(),
					}
				end,
			},
			{
				provider = " ",
			},
			File_comp.Icon_block,
			{
				File_comp.Name_block,
				hl = function(self)
					return {
						fg = self.is_active and buffer_colors.active_fg_color() or buffer_colors.inactive_fg_color(),
						bold = self.is_active or self.is_visible,
						italic = self.is_active,
					}
				end,
			},
			hl = function(self)
				return {
					bg = self.is_active and buffer_colors.active_bg_color() or buffer_colors.inactive_bg_color(),
				}
			end,
		},
	}
end

local Buffer_Name_Flag = function()
	return {
		{
			condition = function(self)
				return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
			end,
			provider = "  ",
			on_click = {
				callback = function(_, minwid)
					vim.schedule(function()
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
			condition = function(self)
				return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
			end,
			provider = "  ",
			hl = { fg = get_color(Specific_var.buffer_modify_fg) },
		},
		{
			provider = "",
			hl = function(self)
				return {
					fg = self.is_active and buffer_colors.active_bg_color() or buffer_colors.inactive_bg_color(),
					bg = buffer_colors.inactive_bg_color(),
				}
			end,
		},
		hl = function(self)
			return {
				fg = self.is_active and buffer_colors.active_fg_color() or buffer_colors.inactive_fg_color(),
				bg = self.is_active and buffer_colors.active_bg_color() or buffer_colors.inactive_bg_color(),
			}
		end,
	}
end

local Buffer_Name_Block = function()
	return {
		Buffer_Filename(),
		Buffer_Name_Flag(),
	}
end
local BufferLine_Block = function()
	return utils.make_buflist(
		Buffer_Name_Block(),
		{ provider = "  ", hl = { fg = buffer_colors.inactive_fg_color(), bg = buffer_colors.inactive_bg_color() } },
		{ provider = "  ", hl = { fg = buffer_colors.inactive_fg_color(), bg = buffer_colors.inactive_bg_color() } }
	)
end

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

local neotree_seprator_fg = "dark_fg"
local TabLineOffset = {
	condition = function(self)
		local win = vim.api.nvim_tabpage_list_wins(0)[1]
		local bufnr = vim.api.nvim_win_get_buf(win)
		self.winid = win

		if vim.bo[bufnr].filetype == "neo-tree" then
			self.title = "[NEO-TREE]"
			self.hl = { fg = buffer_colors.inactive_fg_color(), bg = buffer_colors.inactive_bg_color() }
			return true
		end
	end,

	{
		provider = function(self)
			local title = self.title
			local width = vim.api.nvim_win_get_width(self.winid)
			local pad = math.ceil((width - #title) / 2)
			return string.rep(" ", pad - 1) .. title .. string.rep(" ", pad)
		end,
	},
	{
		provider = "│",
		hl = { fg = neotree_seprator_fg, bg = buffer_colors.inactive_bg_color() },
	},
}
return { TabLineOffset, BufferLine_Block() }
