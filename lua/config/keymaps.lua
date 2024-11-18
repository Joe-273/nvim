-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keymaps to escape
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Terminal keymaps
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move focus to the upper window" })
vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move focus to the right window" })

-- Keybinds to process files
vim.keymap.set("n", "<C-q>", "<cmd>qall<CR>", { desc = "Quit all window" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>W", "<cmd>wall<CR>", { desc = "Save all buffers" })

-- Move to the head or end of the line
vim.keymap.set({ "n", "v" }, "<S-h>", "^", { desc = "Move to the head of the line" })
vim.keymap.set({ "n", "v" }, "<S-l>", "$", { desc = "Move to the end of the line" })

-- Keymap to adjust the window pane size
vim.keymap.set("n", "<S-A-l>", "3<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<S-A-h>", "3<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<S-A-j>", "2<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<S-A-k>", "2<C-w>-", { desc = "Decrease window height" })
