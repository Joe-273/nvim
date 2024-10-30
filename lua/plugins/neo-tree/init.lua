return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = "VeryLazy",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<C-e>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree", mode = { "n", "t" } },
    { "<leader>R", "<cmd>Neotree reveal<cr>", desc = "Reveal in Neotree" },
  },
  config = function()
    require("plugins.neo-tree.config")
  end,
}
