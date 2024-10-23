local cmp = require "cmp"
local compare = require "cmp.config.compare"
local luasnip = require "luasnip"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local close_cmp_mapping = cmp.mapping(function(fallback)
  if cmp.visible() then
    -- 如补全菜单可见，关闭补全菜单
    cmp.abort()
  else
    fallback()
  end
end, { "i", "s" })

-- ====== Tab Function ====== --
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
  elseif luasnip.locally_jumpable(1) then
    -- 如果有可跳转的片段，跳转到下一个片段
    luasnip.jump(1)
  else
    -- 默认行为
    fallback()
  end
end, { "i", "s" })

local shift_tab_mapping = cmp.mapping(function(fallback)
  if cmp.visible() then
    -- 如果补全菜单可见，选择上一个项目
    cmp.select_prev_item()
  elseif luasnip.locally_jumpable(-1) then
    -- 如果有可跳转的片段，跳转到上一个片段
    luasnip.jump(-1)
  else
    -- 默认行为
    fallback()
  end
end, { "i", "s" })

local kind_icons = {
  Text = "󰉿 ",
  Method = "󰆧 ",
  Function = "ƒ ",
  Constructor = " ",
  Field = "󰜢 ",
  Variable = "ɑ ",
  Class = "󰠱 ",
  Interface = " ",
  Module = " ",
  Property = "󰜢 ",
  Unit = "󰑭 ",
  Value = "󰎠 ",
  Enum = " ",
  Keyword = "󰌋 ",
  Snippet = "󰆐 ",
  Color = "󰏘 ",
  File = "󰈙 ",
  Reference = "󰈇 ",
  Folder = "󰉋 ",
  EnumMember = " ",
  Constant = "󰏿 ",
  Struct = "󰙅 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰅲 ",
}

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-calc",
    "f3fora/cmp-spell",
  },
  opts = function(_, opts)
    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local original_kind = vim_item.kind
        vim_item.kind = kind_icons[original_kind] or original_kind
        local kind = require("lspkind").cmp_format { mode = "symbol_text", maxwidth = 50 }(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    (" .. original_kind .. ")"
        return kind
      end,
    }
    -- 直接定义配置
    opts.completion = {
      completeopt = "menu,menuone,noinsert", -- 自动选中第一条
    }
    opts.sources = cmp.config.sources {
      {
        name = "nvim_lsp",
        ---@param entry cmp.Entry
        ---@param ctx cmp.Context
        entry_filter = function(entry, ctx)
          -- Check if the buffer type is 'vue'
          if ctx.filetype ~= "vue" then return true end

          local cursor_before_line = ctx.cursor_before_line
          -- For events
          if cursor_before_line:sub(-1) == "@" then
            return entry.completion_item.label:match "^@"
            -- For props also exclude events with `:on-` prefix
          elseif cursor_before_line:sub(-1) == ":" then
            return entry.completion_item.label:match "^:" and not entry.completion_item.label:match "^:on-"
          else
            return true
          end
        end,
        option = { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] } },
        priority = 1000,
      },
      { name = "luasnip", priority = 750 },
      { name = "pandoc_references", priority = 725 },
      { name = "latex_symbols", priority = 700 },
      { name = "emoji", priority = 700 },
      { name = "calc", priority = 650 },
      { name = "path", priority = 500 },
      { name = "buffer", priority = 250 },
    }
    opts.sorting = {
      comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find "^_+"
          local _, entry2_under = entry2.completion_item.label:find "^_+"
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    }
    opts.mapping = {
      ["<CR>"] = cmp.config.disable,
      ["<C-p>"] = cmp.mapping.scroll_docs(-4),
      ["<C-n>"] = cmp.mapping.scroll_docs(4),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }, { "i", "s" }),
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }, { "i", "s" }),
      ["<C-e>"] = close_cmp_mapping,
      ["<Tab>"] = tab_mapping,
      ["<S-Tab>"] = shift_tab_mapping,
    }
    return opts
  end,
}
