return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		-- Document existing key chains
		win = {
			title_pos = "center",
		},
		spec = {
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>h", group = "[H]unk", mode = { "n", "v" } },

			-- lsp group
			{ "<leader>l", group = "[L]SP" },
			{ "<leader>ls", group = "LSP [S]ymbols" },

			{ "<leader>o", group = "[O]utline" },
			{ "<leader>t", group = "[T]oggle" },

			-- single ability mapping
			{ "<leader>s", group = "Flash Pick Words", icon = "" },
			{ "<leader>S", group = "Flash Treesitter", icon = "" },
			{ "<leader>b", group = "Flash Pick Bar", icon = "" },
		},
	},
}
