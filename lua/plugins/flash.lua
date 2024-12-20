return {
	"folke/flash.nvim",
	keys = {
		{
			"<leader>s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"<leader>S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"<leader>R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
	},
	config = function()
		require("flash").setup({
			jump = {
				autojump = true,
			},
			modes = {
				char = {
					autohide = true,
				},
			},
			exclude = {
				"notify",
				"cmp_menu",
				"noice",
				"lazy",
				"flash_prompt",
				function(win)
					-- exclude non-focusable windows
					return not vim.api.nvim_win_get_config(win).focusable
				end,
			},
			prompt = {
				prefix = { { "", "FlashPromptIcon" } },
			},
		})
	end,
}
