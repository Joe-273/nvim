local cmp = require "cmp"
local luasnip = require "luasnip"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local tab_mapping = cmp.mapping(function(fallback)
  if cmp.visible() then
    -- 如果补全菜单可见，优先进行选择或确认
    local entry = cmp.get_selected_entry()
    if not entry then
      cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
    else
      if has_words_before() then
        -- 如果有文字，使用 Replace 模式确认补全
        cmp.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }
      else
        -- 否则使用 Insert 模式确认补全
        cmp.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        }
      end
    end
  elseif luasnip.expand_or_jumpable() then
    -- 如果有可跳转的片段，跳转到下一个片段
    luasnip.expand_or_jump()
  else
    -- 默认行为
    fallback()
  end
end, { "i", "s" })

local shift_tab_mapping = cmp.mapping(function(fallback)
  if cmp.visible() then
    -- 如果补全菜单可见，选择上一个项目
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    -- 如果有可跳转的片段，跳转到上一个片段
    luasnip.jump(-1)
  else
    -- 默认行为
    fallback()
  end
end, { "i", "s" })

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
      ["<Tab>"] = tab_mapping,
      ["<S-Tab>"] = shift_tab_mapping,
    }

    return opts
  end,
}
