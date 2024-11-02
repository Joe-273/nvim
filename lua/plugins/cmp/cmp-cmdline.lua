local cmp = require("cmp")
local cmdline_opts = {
	{
		type = "/",
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	},
	{
		type = ":",
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{
				name = "cmdline",
				option = {
					ignore_cmds = { "Man", "!" },
				},
			},
		}),
	},
}
vim.tbl_map(function(val)
	cmp.setup.cmdline(val.type, val)
end, cmdline_opts)

-- Fix invisible bugs when auto completion
local feedkeys = vim.api.nvim_feedkeys
local termcodes = vim.api.nvim_replace_termcodes
local function feed_space_backspace()
	feedkeys(termcodes(" <BS>", true, false, true), "n", true)
end
cmp.event:on("confirm_done", function()
	vim.schedule(feed_space_backspace)
end)
