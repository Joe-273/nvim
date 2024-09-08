return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup {
      style = "storm", -- 选择你想要的主题风格
      transparent = true, -- 启用透明背景
      terminal_colors = true,
      styles = {
        sidebars = "transparent", -- 侧边栏透明
        floats = "transparent", -- 浮动窗口透明
      },
    }
    vim.cmd [[colorscheme tokyonight]]
  end,
}
