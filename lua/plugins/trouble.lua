return {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	keys = {
		{
			"<leader>os",
			"<cmd>Trouble toggle win={relative=win,position=right,size=35}<CR>",
			desc = "[O]utline Toggle",
		},
		{
			"<leader>os",
			"<cmd>Trouble lsp_document_symbols toggle pinned=true win={relative=win,position=right,size=35}<CR>",
			desc = "[O]utline document [S]ymble",
		},
		{
			"<leader>od",
			"<cmd>Trouble diagnostics toggle win={relative=win,position=right,size=35} filter.buf=0<CR>",
			desc = "[O]utline buffer [D]iagnostics",
		},
		{
			"<leader>oD",
			"<cmd>Trouble diagnostics toggle focus=true win={size=20}<CR>",
			desc = "[O]utline all [D]iagnostics",
		},
	},
	config = function()
		require("trouble").setup({
			modes = {
				lsp_document_symbols = {
					format = "{kind_icon}{symbol.name} ",
				},
			},
			icons = {
				indent = {
					last = "╰╴",
					fold_open = " ",
					fold_closed = " ",
				},
			},
		})
	end,
}
