local M = {}

M.statuscol_config = function()
	local builtin = require("statuscol.builtin")
	require("statuscol").setup({
		ft_ignore = { "neo-tree", "terminal", "toggleterm", "trouble", "nioce" },
		relculright = true,
		-- segments = {
		-- 	{ text = { "%s", " " }, click = "v:lua.ScSa" },
		-- 	{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
		-- 	{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
		-- },
		segments = {
			{
				sign = { namespace = { "gitsigns" }, colwidth = 1, fillchar = " " },
				click = "v:lua.ScSa",
			},
			{
				sign = { namespace = { "diagnostic" }, fillchar = " " },
				click = "v:lua.ScSa",
			},
			{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
			{ text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
		},
	})
end

M.ufo_init = function()
	vim.o.foldcolumn = "1" -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
end

M.ufo_config = function()
	local handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = (" 󰁂 %d lins"):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end

	require("ufo").setup({
		fold_virt_text_handler = handler,
		open_fold_hl_timeout = 400,
		preview = {
			win_config = {
				winblend = 0,
			},
			mappings = {
				scrollU = "<C-u>",
				scrollD = "<C-d>",
			},
		},
		provider_selector = function()
			return { "treesitter", "indent" }
		end,
	})

	vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
	vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
	vim.keymap.set("n", "K", function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			vim.lsp.buf.hover()
		end
	end)
end

return M
