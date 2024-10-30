local normal_highlight = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
local bg_color = normal_highlight.bg and string.format("#%06X", normal_highlight.bg)

require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  highlights = {
    -- highlights which map to a highlight group name and a table of it's values
    -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
    Normal = {
      guibg = bg_color,
    },
    NormalFloat = {
      link = "Normal",
    },
  },
  shade_terminals = false,
  shell = "nu",
  winblend = 0,
})

-- Setting lazygit
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "rounded",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function()
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>gl",
  "<cmd>lua _lazygit_toggle()<CR>",
  { desc = "[G]it toggle [L]azygit", noremap = true, silent = true }
)
