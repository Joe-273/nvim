-- [[ Configure Telescope ]]

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = { prompt_position = "top", preview_width = 0.55 },
			vertical = { mirror = false },
			width = 0.80,
			height = 0.70,
			preview_cutoff = 120,
		},
		mappings = {
			i = {
				["<C-q>"] = false,
				["<esc>"] = require("telescope.actions").close,
				["<C-y>"] = require("telescope.actions").select_default,
			},
			n = { ["<C-q>"] = false },
		},
	},
	-- pickers = {},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find [h]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find [k]eymaps" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find [f]iles" })
vim.keymap.set("n", "<leader>fT", builtin.builtin, { desc = "Find Select [T]elescope" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find current [w]ord" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by [g]rep" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find [r]esume" })
vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Choose existing buffer" })

vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find [t]odo" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Document [s]ymbols" })
vim.keymap.set("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols, { desc = "Find Workspace [S]ymbols" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>fn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find [n]eovim files" })
