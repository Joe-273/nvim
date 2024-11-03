-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*" },
	callback = function()
		vim.cmd('silent! normal! g`"zv')
	end,
})

-- Load custom and fix colors colors when switching themes
local hl = require("config.highlight")
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		-- [[ apply theme ]]
		-- vim.cmd.colorscheme("tokyonight-moon")
		-- vim.cmd.colorscheme("catppuccin-frappe")
		-- vim.cmd.colorscheme("github_dark_dimmed")
		vim.cmd.colorscheme("nordfox")
		-- vim.cmd.colorscheme("nightfox")

		hl.set_highlight()
	end,
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	callback = function()
		hl.set_highlight()
		require("lazy").reload({ plugins = { "heirline.nvim" } })
		require("lazy").reload({ plugins = { "hlchunk.nvim" } })
	end,
})

-- Set winfixbuf to the noice window
vim.api.nvim_create_augroup("IrreplaceableWindows", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "IrreplaceableWindows",
	pattern = "*",
	callback = function()
		local filetypes = { "noice" }
		local buftypes = { "nofile" }
		if vim.tbl_contains(buftypes, vim.bo.buftype) and vim.tbl_contains(filetypes, vim.bo.filetype) then
			vim.cmd("set winfixbuf")
		end
	end,
})
