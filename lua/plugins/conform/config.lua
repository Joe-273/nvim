require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		-- Disable "format_on_save lsp_fallback" for languages that don't
		-- have a well standardized coding style. You can add additional
		-- languages here or re-enable it for the disabled ones.
		local disable_filetypes = { c = true, cpp = true }
		local lsp_format_opt
		if disable_filetypes[vim.bo[bufnr].filetype] then
			lsp_format_opt = "never"
		else
			lsp_format_opt = "fallback"
		end
		return {
			timeout_ms = 500,
			lsp_format = lsp_format_opt,
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform can also run multiple formatters sequentially
		python = { "isort", "black" },
		--
		-- You can use 'stop_after_first' to run the first available formatter from the list
		javascript = { "eslint_d", "prettierd", stop_after_first = true },
		typescript = { "eslint_d", "prettierd", stop_after_first = true },
		vue = { "eslint_d", "prettierd", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		scss = { "prettierd", "prettier", stop_after_first = true },
		less = { "prettierd", "prettier", stop_after_first = true },
		postcss = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", stop_after_first = true },
		--
		yaml = { "prettierd" },
		markdown = { "prettierd" },
	},
})
