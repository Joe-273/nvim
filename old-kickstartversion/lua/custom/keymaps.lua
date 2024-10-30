-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>q", "<cmd>:q<CR>", { desc = "Quit current window" })
vim.keymap.set("n", "<C-q>", "<cmd>:qall<CR>", { desc = "Quit all window" })
vim.keymap.set("n", "+", "<C-w>|<C-w>_")
vim.keymap.set("n", "=", "<C-w>=")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- close all other buffers except current one
vim.keymap.set("n", "<leader>bc", function()
  -- define filetypes not to be deleted
  local filetypes = { "OverseerList", "Terminal", "quickfix", "terminal" }
  local buftypes = { "terminal", "toggleterm" }

  local current_buf = vim.fn.bufnr("%")
  local buffers = vim.fn.getbufinfo({ bufloaded = 1 })

  for _, buffer in ipairs(buffers) do
    local bufnr = buffer.bufnr
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })

    -- Close the buffer if it is not the current one and not in the specified filetypes
    if
      bufnr ~= current_buf
      and not vim.tbl_contains(filetypes, filetype)
      and not vim.tbl_contains(buftypes, buftype)
    then
      vim.cmd("Bdelete " .. bufnr)
    end
  end
end, { noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move focus to the left window" })
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move focus to the lower window" })
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move focus to the upper window" })
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move focus to the right window" })
vim.keymap.set("x", "<leader>p", '"_dp', { desc = "Paste without overwriting default register" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
