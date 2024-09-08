return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    local conditions = require "heirline.conditions" -- 引入 conditions 模块

    local WorkDir = {
      provider = function()
        local icon = " "
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~") -- 替换 ~ 为 Home

        -- 替换路径中的 \ 和 / 为 >
        cwd = cwd:gsub("[\\/]", ">")

        -- 计算路径的长度
        local max_length = 30 -- 最大显示长度，这个值可以根据需要调整
        if #cwd > max_length then
          local parts = {}
          for part in cwd:gmatch "[^>]+" do
            table.insert(parts, part)
          end

          -- 只保留前一个盘符、一个路径部分、中间的省略号和最后两个路径部分
          local shortened_cwd = parts[1] -- 保留盘符
          if #parts > 2 then
            shortened_cwd = shortened_cwd .. ">" .. "..." -- 添加省略号
            shortened_cwd = shortened_cwd .. ">" .. parts[#parts]
          else
            -- 如果路径部分少于3个，直接拼接
            shortened_cwd = table.concat(parts, ">")
          end

          cwd = shortened_cwd
        end

        return icon .. cwd
      end,
      hl = { fg = "fg" },
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
