require("notify").setup {
  background_colour = "#000000",
}

-- change highlight groups
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- 获取 Normal 高亮组的前景色
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local normal_fg = normal_hl.fg
    -- 设置 FloatBorder 和 NeoTreeFloatBorder 的前景色为 Normal 的前景色
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = normal_fg })
    vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = normal_fg })
    vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { fg = normal_fg })
  end,
})

local prefix = "<leader>u"
return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  opts = {
    extra_groups = { -- table/string: additional groups that should be cleared
      -- In particular, when you set it to 'all', that means all available groups
      "BqfPreviewFloat",
      "NormalFloat",
      "NormalNC",
      "NvimTreeNormal",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "NeoTreePreview",
      "NeoTreeTabInactive",
      "LineNr",
      "CursorColumn",
      "CursorLine",
      "CursorLineNr",
      "FloatBorder",
      "WinBar",
      "WinBarNC",
      "TreesitterContext",
      "DapUIPlayPause",
      "DapUIRestart",
      "DapUIStop",
      "DapUIStepOut",
      "DapUIStepBack",
      "DapUIStepInto",
      "DapUIStepOver",
      "DapUIPlayPauseNC",
      "DapUIRestartNC",
      "DapUIStopNC",
      "DapUIStepOutNC",
      "DapUIStepBackNC",
      "DapUIStepIntoNC",
      "DapUIStepOverNC",
      "SignColumn",
      "StatusLine",
      "TelescopeBorder",
      "TelescopeNormal",
      "TelescopePreviewNormal",
      "TelescopeResultsNormal",
      "TelescopePromptNormal",
      "TabLineFill",
      "TreesitterContextLineNumber",
      "QuickFixLine",
      "Pmenu",
      -- "PmenuSel",
      "PmenuSbar",
      "PmenuThumb",
      "NotifyINFOBody",
      "NotifyWARNBody",
      "NotifyERRORBody",
      "NotifyDEBUGBody",
      "NotifyTRACEBody",
      "NotifyINFOBorder",
      "NotifyWARNBorder",
      "NotifyERRORBorder",
      "NotifyDEBUGBorder",
      "NotifyTRACEBorder",
      "WhichKeyFloat",
    },
  },
  keys = {
    { prefix .. "T", "<cmd>TransparentToggle<CR>", desc = "Toggle transparency" },
  },
}
