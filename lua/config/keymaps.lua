-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- [[ Escape ]]
-- Keymaps to escape insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
-- Keymaps to escape terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- [[ Move ]]
-- Keymaps to move normal window
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Keymaps to move terminal window
vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move focus to the upper window" })
vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move focus to the right window" })

-- Keybinds to process files
vim.keymap.set({ "n", "t" }, "<C-q>", "<cmd>qall<CR>", { desc = "Quit all window" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>W", "<cmd>wall<CR>", { desc = "Save all buffers" })

-- Move to the head or end of the line
vim.keymap.set({ "n", "v" }, "<S-h>", "^", { desc = "Move to the head of the line" })
vim.keymap.set({ "n", "v" }, "<S-l>", "$", { desc = "Move to the end of the line" })

-- Keymap to adjust the window pane size
-- "M-S" here is:
--   Mac: Option + Command + Shift
--   Win: Win + Alt + Shift
vim.keymap.set("n", "<M-S-l>", "3<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-S-h>", "3<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-S-j>", "2<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<M-S-k>", "2<C-w>-", { desc = "Decrease window height" })
