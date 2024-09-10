return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    local conditions = require "heirline.conditions"
    local utils = require "heirline.utils"

    -- configure palettes
    local mocha = require("catppuccin.palettes").get_palette "mocha"
    require("heirline").load_colors(mocha)

    --====== FileNameBlock ======--
    local FileNameBlock = {
      -- let's first set up some attributes needed by this component and its children
      init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
    }
    -- We can now define some children separately and add them later
    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
          require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self) return self.icon and (self.icon .. " ") end,
      hl = function(self) return { fg = self.icon_color } end,
    }
    local FileName = {
      provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        filename = filename:gsub("[\\/]", ">")
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then filename = vim.fn.pathshorten(filename) end
        return "[" .. filename .. "]"
      end,
      hl = { fg = utils.get_highlight("Directory").fg, bold = false },
    }
    local FileFlags = {
      {
        condition = function() return vim.bo.modified end,
        provider = "[+]",
        hl = { fg = "green" },
      },
      {
        condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
        provider = "",
        hl = { fg = "orange" },
      },
    }
    -- Now, let's say that we want the filename color to change if the buffer is
    -- modified. Of course, we could do that directly using the FileName.hl field,
    -- but we'll see how easy it is to alter existing components using a "modifier"
    -- component
    local FileNameModifer = {
      hl = function()
        if vim.bo.modified then
          -- use `force` because we need to override the child's hl foreground
          return { fg = "cyan", bold = false, force = true }
        end
      end,
    }
    -- let's add the children to our FileNameBlock component
    FileNameBlock = utils.insert(
      FileNameBlock,
      FileIcon,
      utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
      FileFlags,
      { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
    )

    --====== LSPActive ======--
    local LSPActive = {
      condition = conditions.lsp_attached,
      update = { "LspAttach", "LspDetach" },
      provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
          table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
      end,
      hl = { fg = "green", bold = false },
    }

    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode { mode_text = { padding = { left = 1, right = 1 } }, hl = { fg = "base", bold = true } },
      status.component.git_branch(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.builder(FileNameBlock),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.builder(LSPActive),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
    }
  end,
}
