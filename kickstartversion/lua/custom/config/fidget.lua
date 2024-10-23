require("fidget").setup({
	-- Options related to LSP progress subsystem
	progress = {
		-- Options related to how LSP progress messages are displayed as notifications
		display = {
			done_icon = "✓", -- Icon shown when all LSP progress tasks are complete
		},
	},

	-- Options related to notification subsystem
	notification = {
		-- Options related to the notification window and buffer
		window = {
			winblend = 0, -- Background color opacity in the notification window
			border = "rounded", -- Border around the notification window
		},
	},
})
