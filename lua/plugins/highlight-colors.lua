return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		---Render style
		---@usage 'background'|'foreground'|'virtual'
		render = "virtual",

		---Set virtual symbol (requires render to be set to 'virtual')
		virtual_symbol = "",
	},
}
