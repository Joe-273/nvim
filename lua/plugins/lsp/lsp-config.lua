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
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Definition
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [d]efinition")

		-- Declaration.
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Reference
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [r]eferences")

		-- Implementation
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

		-- Type definition
		map("<leader>lt", require("telescope.builtin").lsp_type_definitions, "[L]SP [t]ype Definition")

		-- Document symbol
		map("<leader>lsd", require("telescope.builtin").lsp_document_symbols, "[L]SP [s]ymbols of [d]ocument")

		-- Workspace symbol
		map(
			"<leader>lsw",
			require("telescope.builtin").lsp_dynamic_workspace_symbols,
			"[L]SP [s]ymbols of [w]orkspace "
		)

		-- Rename
		map("<leader>lr", vim.lsp.buf.rename, "[L]SP [r]ename")

		-- Code action
		map("<leader>la", vim.lsp.buf.code_action, "[L]SP code [a]ction", { "n", "x" })

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
			end, "[T]oggle Inlay [h]ints")
		end
	end,
})

require("neoconf").setup()
require("lazydev").setup()
require("mason").setup({ ui = { border = "rounded" } })
-- extend LSP servers
local servers = require("plugins.lsp.lsp-server")
local ensure_installed = vim.tbl_keys(servers or {})

-- LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

require("mason-lspconfig").setup({
	ensure_installed = ensure_installed,
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})
