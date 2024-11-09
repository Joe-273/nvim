return {
	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "j-hui/fidget.nvim" },

			-- Allows extra capabilities provided by nvim-cmp
			{ "antosha417/nvim-lsp-file-operations", config = true },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("plugins.lsp.lsp-config")
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.lsp.lsp_signature")
		end,
	},
	-- require("plugins.lsp.lsp-typescript"),
}
