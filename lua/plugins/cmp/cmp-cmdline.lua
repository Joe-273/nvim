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
