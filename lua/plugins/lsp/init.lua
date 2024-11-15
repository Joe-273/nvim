return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{ -- Main LSP Configuration
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"folke/lazydev.nvim",
			"folke/neoconf.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("plugins.lsp.lsp-config")
		end,
	},
}
