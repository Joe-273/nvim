---@diagnostic disable: need-check-nil

return {
	"Bekaboo/dropbar.nvim",
	-- optional, but required for fuzzy finder support
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	config = function()
		require("plugins.dropbar.config")
	end,
}
