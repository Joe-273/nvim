return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.lsp = {
      -- 控制 LSP 相关的功能
      signature = {
        enabled = false, -- 启用 LSP 的签名帮助
        format = "short", -- 设定格式，如 "short" 或 "verbose"
      },
      hover = {
        enabled = false, -- 启用悬浮提示
      },
      progress = {
        enabled = true, -- 启用 LSP 进度显示
      },
    }
    opts.views = {
      cmdline_popup = {
        position = {
          row = 5,
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 8,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    }
  end,
}
