return {
	"famiu/bufdelete.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- close buffer
		vim.keymap.set("n", "<leader>c", function()
			require("bufdelete").bufdelete(0, false)
		end, { desc = "Delete current buffer" })
		vim.keymap.set("n", "<leader>C", function()
			local filetypes =
				{ "OverseerList", "toggleterm", "quickfix", "terminal", "trouble", "noice", "cmp_menu", "cmp_docs" }
			local buftypes = { "terminal", "nofile" }
			local current_buf = vim.fn.bufnr("%")
			local buffers = vim.fn.getbufinfo({ bufloaded = 1 })
			for _, buffer in ipairs(buffers) do
				local bufnr = buffer.bufnr
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
				local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
				local useless = { "[Preview]" }

				-- Close the buffer if it is not the current one and not in the specified filetypes
				if
					bufnr ~= current_buf
					and not vim.tbl_contains(filetypes, filetype)
					and not vim.tbl_contains(buftypes, buftype)
				then
					require("bufdelete").bufdelete(bufnr, vim.tbl_contains(useless, vim.fn.bufname(bufnr)))
				end
			end
		end, { desc = "Delete other buffers" })
	end,
}
