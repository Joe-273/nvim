local sign_icons = require("config.icons").sign

vim.diagnostic.config({
	virtual_text = { spacing = 2, prefix = "󰧞" },
	severity_sort = true,
	-- Diagnostic sign icons
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = sign_icons.error,
			[vim.diagnostic.severity.WARN] = sign_icons.warn,
			[vim.diagnostic.severity.INFO] = sign_icons.info,
			[vim.diagnostic.severity.HINT] = sign_icons.hint,
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LSP-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		-- Definition
		map("gd", require("telescope.builtin").lsp_definitions, "Goto [d]efinition")

		-- Declaration.
		map("gD", vim.lsp.buf.declaration, "Goto [D]eclaration")

		-- Reference
		map("gr", require("telescope.builtin").lsp_references, "Goto [r]eferences")

		-- Implementation
		map("gI", require("telescope.builtin").lsp_implementations, "Goto [I]mplementation")

		-- Type definition
		map("<leader>lt", require("telescope.builtin").lsp_type_definitions, "LSP [t]ype Definition")

		-- Document symbol
		map("<leader>lsd", require("telescope.builtin").lsp_document_symbols, "LSP Symbols of [d]ocument")

		-- Workspace symbol
		map("<leader>lsw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "LSP Symbols of [w]orkspace ")

		-- Rename
		map("<leader>lr", vim.lsp.buf.rename, "LSP [r]ename")

		-- Code action
		map("<leader>la", vim.lsp.buf.code_action, "LSP code [a]ction", { "n", "x" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- LSP hover highlight
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("LSP-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("LSP-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "LSP-highlight", buffer = event2.buf })
				end,
			})
		end

		-- Toggle inlay hints
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "LSP: Toggle inlay [h]ints")
		end
	end,
})

require("neoconf").setup()
require("lazydev").setup()
require("mason").setup({ ui = { border = "rounded" } })
-- extend LSP servers
local LSP_Server = require("plugins.lsp.lsp-server").LSP_Server
local Linter = require("plugins.lsp.lsp-server").Linter
local Formatter = require("plugins.lsp.lsp-server").Formatter
local ensure_installed = vim.tbl_keys(LSP_Server or {})
vim.list_extend(ensure_installed, Linter)
vim.list_extend(ensure_installed, Formatter)

-- LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

require("mason-tool-installer").setup({
	ensure_installed = ensure_installed,
})
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = LSP_Server[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})
