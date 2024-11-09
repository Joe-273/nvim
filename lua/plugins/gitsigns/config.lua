require("gitsigns").setup({
	signs = {
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "┃" },
	},
	signs_staged = {
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "┃" },
	},
	preview_config = {
		-- Options passed to nvim_open_win
		border = "rounded",
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]h", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "Jump to next git [H]unk" })

		map("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[h", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Jump to previous git [H]unk" })

		-- Hunk Actions
		-- visual mode
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "[H]unk [S]tage hunk" })
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "[H]unk [R]eset hunk" })
		-- normal mode
		map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [s]tage" })
		map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[H]unk [S]tage buffer" })
		map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [r]eset hunk" })
		map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[H]unk [R]eset buffer" })
		map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "[H]unk [u]ndo stage hunk" })
		map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [p]review hunk" })
		map("n", "<leader>hb", gitsigns.blame_line, { desc = "[H]unk [b]lame line" })
		-- Git Actions
		map("n", "<leader>gd", gitsigns.diffthis, { desc = "[G]it [d]iff against index" })
		map("n", "<leader>gD", function()
			gitsigns.diffthis("@")
		end, { desc = "[G]it [D]iff against last commit" })
		-- Toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git: [T]oggle show [b]lame line" })
		map("n", "<leader>ts", gitsigns.toggle_signs, { desc = "Git: [T]oggle [s]ign" })
		map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Git: [T]oggle [d]eleted" })
	end,
})
