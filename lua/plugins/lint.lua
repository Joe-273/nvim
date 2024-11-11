return {
	"mfussenegger/nvim-lint",
	-- enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "stylelint", "eslint" },
			typescriptreact = { "stylelint", "eslint" },
			vue = { "eslint" },
			css = { "stylelint" },
			less = { "stylelint" },
			sass = { "stylelint" },
		}
		--
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
