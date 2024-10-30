return {
	"rmagatti/auto-session",
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>wr", "<cmd>SessionSearch<CR>", desc = "[W]orkspace Session [R]eload" },
		{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "[W]orkspace [S]ave session" },
		{ "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "[W]orkspace Toggle [a]utosave" },
	},
	config = function()
		require("auto-session").setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
		})
	end,
}
