return {
  {
    "rhysd/accelerated-jk", -- fast jk move
    config = function()
      vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
      vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "ethanholz/nvim-lastplace", -- recur last place
    config = true,
  },
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
    specs = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          return require("astrocore").extend_tbl(opts, {
            options = {
              g = {
                ["VM_default_mappings"] = 0,
                ["Find Under"] = "<C-n>",
                ["Find Subword Under"] = "<C-n>",
                ["Add Cursor Up"] = "<C-S-k>",
                ["Add Cursor Down"] = "<C-S-j>",
                ["Select All"] = "<C-S-n>",
                ["Skip Region"] = "<C-x>",
              },
            },
          })
        end,
      },
    },
  },
}
