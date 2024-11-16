-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("Highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		vim.cmd('silent! normal! g`"zv')
	end,
})

-- Fix colors when switching themes
local hl = require("config.highlight")
local theme_colors = require("config.theme-colors")
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	callback = function()
		theme_colors.__init__() -- Set theme_colors
		hl.set_highlight()

		require("lazy").reload({ plugins = { "heirline.nvim" } })
		require("lazy").reload({ plugins = { "hlchunk.nvim" } })
	end,
})

-- Set winfixbuf to the noice window
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("IrreplaceableWindows", { clear = true }),
	pattern = "*",
	callback = function()
		local filetypes = { "noice" }
		local buftypes = { "nofile" }
		if vim.tbl_contains(buftypes, vim.bo.buftype) and vim.tbl_contains(filetypes, vim.bo.filetype) then
			vim.cmd("set winfixbuf")
		end
	end,
})
