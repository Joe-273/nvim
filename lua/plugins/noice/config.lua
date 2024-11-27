local function toggle_noice()
	-- set noice flag
	local noice_opened = false
	local noice_win_id = nil

	-- Check if the noice window is open
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local win_config = vim.api.nvim_win_get_config(win)

		if vim.bo[buf].filetype == "noice" and vim.bo[buf].buftype == "nofile" then
			if win_config.anchor == nil and win_config.focusable then
				-- ignore float window
				noice_opened = true
				noice_win_id = win
				break
			end
		end
	end

	if noice_opened and noice_win_id then
		vim.api.nvim_win_close(noice_win_id, true)
	else
		-- NOTE: If there is no historical record, the 'no' window will not open
		require("noice").cmd("history")
	end
end

vim.keymap.set("n", "<leader>on", toggle_noice, { desc = "Outline history [n]oice", noremap = true, silent = true })

local function set_width(percent)
	return math.ceil(vim.o.columns * percent)
end

require("noice").setup({
	presets = {
		lsp_doc_border = true,
	},
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
		signature = {
			-- Resolve conflicts with other plugins
			enabled = false,
		},
	},
	messages = { enabled = true },
	views = {
		cmdline_popup = {
			position = { row = 15, col = "50%" },
		},
		mini = { -- Set the transparency of the mini view to 0
			size = {
				max_width = set_width(0.8),
			},
			border = {
				style = "rounded",
			},
			position = {
				row = -2,
			},
			win_options = {
				winblend = 0,
			},
		},
		hover = {
			size = {
				max_width = set_width(0.8),
			},
		},
	},
	format = {
		lsp_progress = {
			"({data.progress.percentage}%) ",
			{ "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
			{ "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
			{ "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
		},
		lsp_progress_done = {
			{ "✨ ", hl_group = "NoiceLspProgressSpinner" },
			{ "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
			{ "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
		},
	},
})
