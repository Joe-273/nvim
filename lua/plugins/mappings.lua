return {
  -- 插件配置格式
  {
    "AstroNvim/astrocore", -- 这是 AstroNvim 的核心插件
    opts = function(_, opts)
      -- 自定义映射
      opts.mappings = vim.tbl_deep_extend("force", opts.mappings, {
        n = {
          -- 普通模式下的自定义映射
          ["H"] = { ":bprevious<CR>", desc = "Previous buffer" },
          ["L"] = { ":bnext<CR>", desc = "Next buffer" },
        },
      })
    end,
  },
}
