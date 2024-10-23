return {
  'folke/noice.nvim',
  event = "VeryLazy",
  keys = { ':', '/', '?' }, -- lazy load cmp on more keys along with insert mode
  config = function()
    require("noice").setup({
      popupmenu = {
        enabled = false,
      },
      lsp = {
        signature = {
          enabled = false,
        },
        progress = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
      },
    })
  end
}
