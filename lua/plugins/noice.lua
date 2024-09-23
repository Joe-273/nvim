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
    -- 配置 UI 视图
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

    -- 配置命令行和搜索格式
    opts.cmdline = {
      enabled = true, -- 启用 Noice 命令行 UI
      view = "cmdline_popup", -- 使用弹出窗口
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", view = "cmdline_popup" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", view = "cmdline_popup" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
        input = { view = "cmdline_input", icon = "󰥻 " },
      },
    }
  end,
}
