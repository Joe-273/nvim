return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup {
      style = "storm",
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "transparent", -- 侧边栏透明
        floats = "transparent", -- 浮动窗口透明
      },
    }
    vim.cmd [[colorscheme tokyonight]]
  end,
}
