return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    opts = {
      style = "storm",
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "transparent", -- 侧边栏透明
        floats = "transparent", -- 浮动窗口透明
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        cmp = true,
        neotree = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
      },
    },
  },
}
