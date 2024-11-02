local config = require("plugins.ufo.config")
return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				config.statuscol_config()
			end,
		},
	},
	event = "BufReadPost",
	init = function()
		config.ufo_init()
	end,
	config = function()
		config.ufo_config()
	end,
}
