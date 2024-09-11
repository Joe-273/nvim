return {
  "hrsh7th/nvim-cmp",
  requires = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function(_, opts)
    local cmp = require "cmp"

    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    -- 直接定义配置
    opts.completion = {
      completeopt = "menu,menuone,noinsert", -- 自动选中第一条
    }
    opts.sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    }
    opts.mapping = {
      ["<CR>"] = cmp.config.disable,
      ["<C-p>"] = cmp.mapping.scroll_docs(-4),
      ["<C-n>"] = cmp.mapping.scroll_docs(4),
      ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          else
            if has_words_before() then
              cmp.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
              }
            else
              cmp.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = false,
              }
            end
          end
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.config.disable,
    }

    return opts
  end,
}
