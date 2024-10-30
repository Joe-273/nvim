return {
  "shellRaining/hlchunk.nvim",
  enabled = function()
    return vim.bo.filetype ~= "bigfile"
  end,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      line_num = {
        enable = true,
      },
    })
  end,
}
