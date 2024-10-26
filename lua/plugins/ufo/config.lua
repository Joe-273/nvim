-- set statuscolumn for target buffer
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local ft = vim.bo.filetype
		if ft ~= "neo-tree" then
			vim.o.foldcolumn = "1"
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.statuscolumn =
				'%s%{printf("%3d", v:lnum)} %{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " " } '
		else
			vim.opt_local.statuscolumn = ""
		end
	end,
})

require("ufo").setup({
	provider_selector = function(_, _, _)
		return { "treesitter", "indent" }
	end,
})
