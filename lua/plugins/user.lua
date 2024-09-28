-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "User AstroFile",
    main = "lsp_signature",
    opts = {
      hint_enable = false, -- disable hints as it will crash in some terminal
      toggle_key = "<C-e>",
    },
    specs = {
      {
        "folke/noice.nvim",
        optional = true,
        ---@type NoiceConfig
        opts = {
          lsp = {
            signature = { enabled = false },
            hover = { enabled = false },
          },
        },
      },
      { "AstroNvim/astrolsp", optional = true, opts = { features = { signature_help = false } } },
    },
  },

  -- == Examples of Overriding Plugins ==

  -- You can disable default plugins as follows:
  {
    "max397574/better-escape.nvim",
    opts = function(_, opts)
      opts.mappings.i = {
        j = {
          k = "<Esc>",
          j = "<Esc>",
        },
        k = {
          k = "<Esc>", -- Press 'kk' to exit input mode
        },
      }
    end,
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
