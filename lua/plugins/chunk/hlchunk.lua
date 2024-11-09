---@diagnostic disable: assign-type-mismatch
return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local hl = require("config.highlight")
		-- set hlchuk color
		require("hlchunk").setup({
			chunk = {
				style = string.format("#%06X", hl.get_colors().hl_constant),
				enable = true,
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
