return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts

	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	opts = {
		ensure_installed = require("plugins.treesitter.languages"),
		ignore_install = {},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			disable = {},
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	},
}
