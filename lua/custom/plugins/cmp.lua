return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
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
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
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
				opts = function()
					local cmp = require("cmp")
					return {
						{
							type = "/",
							mapping = cmp.mapping.preset.cmdline(),
							sources = {
								{ name = "buffer" },
							},
						},
						{
							type = ":",
							mapping = cmp.mapping.preset.cmdline(),
							sources = cmp.config.sources({
								{ name = "path" },
							}, {
								{
									name = "cmdline",
									option = {
										ignore_cmds = { "Man", "!" },
									},
								},
							}),
						},
					}
				end,
				config = function(_, opts)
					local cmp = require("cmp")
					vim.tbl_map(function(val)
						cmp.setup.cmdline(val.type, val)
					end, opts)
				end,
			},
		},
		config = function()
			require("custom.config.cmp")
		end,
	},
}
