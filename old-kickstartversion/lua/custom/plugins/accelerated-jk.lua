return {
  "rhysd/accelerated-jk", -- fast jk move
  config = function()
    vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
    vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
  end,
}
