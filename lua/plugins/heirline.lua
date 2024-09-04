return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    local conditions = require "heirline.conditions" -- 引入 conditions 模块

    local WorkDir = {
      provider = function()
        local icon = " "
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~")
        -- 使用 conditions.width_percent_below 进行条件检查
        if not conditions.width_percent_below(#cwd, 0.25) then cwd = vim.fn.pathshorten(cwd) end
        local trail = cwd:sub(-1) == "/" and "" or "/"
        return icon .. cwd .. trail
      end,
      hl = { fg = "fg", bold = true },
    }

    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode { mode_text = { padding = { left = 1, right = 1 } }, hl = { fg = "#1e1e2e", bold = true } },
      status.component.git_branch(),
      status.component.file_info(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.builder(WorkDir),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
    }
  end,
}
