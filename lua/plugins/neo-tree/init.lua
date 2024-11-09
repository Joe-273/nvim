return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<C-e>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree", mode = { "n", "t" } },
		{
			"<leader>e",
			"<cmd>Neotree filesystem reveal_force_cwd toggle<cr>",
			desc = "Toggle Neotree to CWD",
			mode = { "n", "t" },
		},
	},
	config = function()
		require("plugins.neo-tree.config")
	end,
}
