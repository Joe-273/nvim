return {
  "max397574/better-escape.nvim",
  event = "VeryLazy",
  opts = {
    timeout = 300,
    default_mappings = false,
    mappings = {
      -- use jj/jk escape
      i = { j = { k = "<Esc>", j = "<Esc>" } },
    },
  },
}
