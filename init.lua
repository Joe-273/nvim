require("config.options")
require("config.keymaps")
require("config.autocmds")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- [[ Configure and install plugins ]]
	--
	--  To check the current status of your plugins, run
	--    :Lazy
	--
	--  You can press `?` in this menu for help. Use `:q` to close the window
	--
	--  To update plugins you can run
	--    :Lazy update
	--
	-- NOTE: Here is where you install your plugins.
	--
	-- Detect tabstop and shiftwidth automatically
	spec = {
		"tpope/vim-sleuth",

		-- quick remedy when tab-complete-then-enter fails you, e.g. `nvim init.l`
		{ "mong8se/actually.nvim", lazy = false },

		-- Use `opts = {}` to force a plugin to be loaded.
		{ "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },

		-- current best multicursor IMHO
		{ "mg979/vim-visual-multi", lazy = true, keys = { { "<C-n>", mode = { "n", "x" } } } },

		-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
		{ import = "plugins" },
	},
	ui = {
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "rounded",
		backdrop = 100,
	},
})
