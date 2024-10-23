-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵 ", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
	close_if_last_window = true,
	enable_git_status = true,
	enable_diagnostics = false,
	popup_border_style = "rounded",
	sources = { "filesystem" },
	source_selector = {
		statusline = true,
	},
	window = {
		position = "left",
		width = 35,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["h"] = "close_node",
			["l"] = "open",
			["<Space>"] = false,
		},
	},
	default_component_configs = {
		git_status = {
			symbols = {
				-- Change type
				added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "", -- this can only be used in the git_status source
				renamed = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
	},
})
