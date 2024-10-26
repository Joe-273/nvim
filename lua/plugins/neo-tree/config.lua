require("neo-tree").setup({
	close_if_last_window = true,
	use_libuv_file_watcher = true,
	enable_diagnostics = false,
	popup_border_style = "rounded",
	sources = {
		"filesystem",
	},
	source_selector = {
		statusline = false,
	},
	window = {
		position = "left",
		width = 35,
		show_line_numbers = false,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["h"] = "close_node",
			["l"] = "open",
			["Z"] = "expand_all_nodes",
			["<Space>"] = false,
		},
	},
	default_component_configs = {
		modified = {
			symbol = "",
		},
		git_status = {
			symbols = {
				-- Change type
				added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "M", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "D", -- this can only be used in the git_status source
				renamed = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "U",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
	},
})
