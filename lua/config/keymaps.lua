-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- terminal keymaps
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move focus to the upper window" })
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move focus to the right window" })

-- Keybinds to process files
vim.keymap.set("n", "<C-q>", "<cmd>qall<CR>", { desc = "Quit all window" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>W", "<cmd>wall<CR>", { desc = "Save all buffers" })
vim.keymap.set("n", "<leader>c", function()
	require("bufdelete").bufdelete(0, false)
end, { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>C", function()
	local filetypes =
		{ "OverseerList", "toggleterm", "quickfix", "terminal", "trouble", "noice", "cmp_menu", "cmp_docs" }
	local buftypes = { "terminal", "nofile" }
	local current_buf = vim.fn.bufnr("%")
	local buffers = vim.fn.getbufinfo({ bufloaded = 1 })
	for _, buffer in ipairs(buffers) do
		local bufnr = buffer.bufnr
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
		local useless = { "[Preview]" }

		-- Close the buffer if it is not the current one and not in the specified filetypes
		if
			bufnr ~= current_buf
			and not vim.tbl_contains(filetypes, filetype)
			and not vim.tbl_contains(buftypes, buftype)
		then
			require("bufdelete").bufdelete(bufnr, vim.tbl_contains(useless, vim.fn.bufname(bufnr)))
		end
	end
end, { desc = "Delete other buffers" })

-- Move to the head or end of the line
vim.keymap.set({ "n", "v" }, "<S-h>", "^", { desc = "Move to the head of the line" })
vim.keymap.set({ "n", "v" }, "<S-l>", "$", { desc = "Move to the end of the line" })

-- Keymap to adjust the window pane size
vim.keymap.set("n", "<S-A-l>", "<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<S-A-h>", "<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-A-j>", "<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<S-A-k>", "<C-w>-", { desc = "Decrease window height" })

-- Paste without replacing the unnamed register in visual mode
vim.keymap.set("x", "p", '"_dP', { noremap = true })
-- Use <leader>p to paste with the original behavior (updating the register)
vim.keymap.set("x", "<leader>p", "p", { noremap = true })
