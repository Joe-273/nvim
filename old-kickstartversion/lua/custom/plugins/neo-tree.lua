-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "B", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
		{ "<leader>R", "<cmd>Neotree reveal<cr>", desc = "Reveal in Neotree" },
	},
	config = function()
		require("custom.config.neo-tree")
	end,
}
