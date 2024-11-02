--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
local M = {}
-- [[ config for format ]]
M.ensure_installed = {
	"stylua", -- Used to format Lua code
	"eslint_d",
	"prettierd",
}
-- [[ config for LSP ]]
M.server = {
	-- clangd = {},
	-- gopls = {},
	pyright = {},
	-- rust_analyzer = {},
	-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
	--
	-- Some languages (like typescript) have entire language plugins that can be useful:
	--    https://github.com/pmizio/typescript-tools.nvim
	--
	-- But for many setups, the LSP (`ts_ls`) will work just fine
	--
	jsonls = {},
	html = {},
	cssls = {},
	ts_ls = {},
	volar = {},

	emmet_ls = {
		filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "less", "svelte" },
	},

	lua_ls = {
		-- cmd = {...},
		-- filetypes = { ...},
		-- capabilities = {},
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
				-- diagnostics = { disable = { 'missing-fields' } },
			},
		},
	},
}

return M
