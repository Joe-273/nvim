return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local function_highlight = vim.api.nvim_get_hl(0, { name = "Function", link = false })
		local fg_color = function_highlight.fg and string.format("#%06X", function_highlight.fg)
		require("hlchunk").setup({
			chunk = {
				enable = true,
				style = fg_color,
			},
			indent = {
				enable = true,
			},
			line_num = {
				enable = true,
				style = fg_color,
			},
		})
	end,
}
