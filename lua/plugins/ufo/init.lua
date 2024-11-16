local config = require("plugins.ufo.config")
return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPost",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				config.statuscol_config()
			end,
		},
	},
	init = function()
		config.ufo_init()
	end,
	config = function()
		config.ufo_config()
	end,
}
