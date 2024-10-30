return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local function_highlight = vim.api.nvim_get_hl(0, { name = "Boolean", link = false })
		local fg_color = function_highlight.fg and string.format("#%06X", function_highlight.fg)
		require("hlchunk").setup({
			chunk = {
				enable = true,
				style = fg_color,
				duration = 50,
				delay = 150,
			},
			indent = {
				enable = true,
			},
			line_num = {
				enable = false,
			},
		})
	end,
}
