return {
	"rainbow-delimiters.nvim",
	config = function()
		require("rainbow-delimiters.setup").setup({
			highlight = {
				"RainbowDelimiterOrange",
				"RainbowDelimiterBlue",
				"RainbowDelimiterYellow",
				"RainbowDelimiterViolet",
				"RainbowDelimiterGreen",
				"RainbowDelimiterRed",
				"RainbowDelimiterCyan",
			},
		})
	end,
}
