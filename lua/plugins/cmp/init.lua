return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		lazy = "VeryLazy",
		event = "InsertEnter",
		dependencies = {
			"onsails/lspkind.nvim",
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			{ "hrsh7th/cmp-buffer", lazy = true },
			{
				"hrsh7th/cmp-cmdline",
				keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
				dependencies = { "hrsh7th/nvim-cmp" },
				config = function()
					require("plugins.cmp.cmp-cmdline")
				end,
			},
		},
		config = function()
			require("plugins.cmp.config")
		end,
	},
}
