---@diagnostic disable: need-check-nil

local open_item_and_close_menu = function()
	local utils = require("dropbar.utils")
	local menu = utils.menu.get_current()
	if not menu then
		return
	end

	local cursor = vim.api.nvim_win_get_cursor(menu.win)
	local entry = menu.entries[cursor[1]]
	-- stolen from https://github.com/Bekaboo/dropbar.nvim/issues/66
	local component = entry:first_clickable(entry.padding.left + entry.components[1]:bytewidth())
	if component then
		menu:click_on(component, nil, 1, "l")
	end
end
require("dropbar").setup({
	-- only display path in the winbar
	-- bar = { sources = { require('dropbar.sources').path } },
	icons = {
		enable = true,
		ui = {
			bar = {
				separator = " ",
				extends = "…",
			},
			menu = {
				separator = " ",
				indicator = "",
			},
		},
	},
	menu = {
		preview = false,
		quick_navigation = false,
		win_configs = {
			border = "rounded",
		},
		keymaps = {
			["h"] = function()
				local utils = require("dropbar.utils")
				local menu = utils.menu.get_current()
				if not menu then
					return
				end
				if menu.prev_menu then
					menu:close()
				else
					local bar = require("dropbar.utils.bar").get({ win = menu.prev_win })
					local barComponents = bar.components[1]._.bar.components
					for _, component in ipairs(barComponents) do
						if component.menu then
							local idx = component._.bar_idx
							menu:close()
							require("dropbar.api").pick(idx - 1)
						end
					end
				end
			end,
			["l"] = function()
				local utils = require("dropbar.utils")
				local menu = utils.menu.get_current()
				if not menu then
					return
				end
				local cursor = vim.api.nvim_win_get_cursor(menu.win)
				local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
				if component then
					menu:click_on(component, nil, 1, "l")
				end
			end,
			["<CR>"] = open_item_and_close_menu,
			["o"] = open_item_and_close_menu,
		},
	},
})

vim.keymap.set("n", "<leader>b", require("dropbar.api").pick, { desc = "[B]ar Pick" })
