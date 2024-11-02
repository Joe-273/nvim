return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {
		preset = "modern",
		-- Document existing key chains
		spec = {
			-- { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			-- { "<leader>d", group = "[D]ocument" },
			-- { "<leader>r", group = "[R]ename" },
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>g", group = "[G]it", mode = { "n", "v" } },

			-- lsp group
			{ "<leader>l", group = "[L]SP" },
			{ "<leader>ld", group = "[L]SP [D]ocument" },
			{ "<leader>lw", group = "[L]SP [W]orkspace" },

			{ "<leader>o", group = "[O]utline" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>w", group = "[W]orkspace" },

			-- single ability mapping
			{ "<leader>s", group = "[F]lask Toggle", icon = "" },
			{ "<leader>S", group = "[F]lask Treesitter", icon = "" },
			{ "<leader>b", group = "[B]ar Pick", icon = "" },
		},
	},
}
