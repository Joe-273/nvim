return {
	"folke/noice.nvim",
	event = "VeryLazy",
	keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
	config = function()
		require("plugins.noice.config")
		require("telescope").load_extension("noice")
	end,
}
