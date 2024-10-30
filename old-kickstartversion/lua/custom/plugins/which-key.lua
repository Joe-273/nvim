return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup({
      ---@param ctx { mode: string, operator: string }
      defer = function(ctx)
        if vim.list_contains({ "d", "y" }, ctx.operator) then
          return true
        end
        return vim.list_contains({ "v", "<C-V>", "V" }, ctx.mode)
      end,
      preset = "modern",
      icons = {
        colors = true,
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },
    })

    -- Document existing key chains
    require("which-key").add({
      { "<leader>n", group = "Note", mode = "n", icon = " " },
      { "<leader>g", group = "Git" },
      { "<leader>b", group = "Buffer", mode = "n", icon = " " },
      { "<leader>l", group = "Lsp", mode = "n", icon = "󰿘 " },
      { "<leader>o", group = "[Deprecate] Overseer tasks", mode = "n", icon = "󰑮 " },
      { "<leader>r", group = "Overseer tasks", mode = "n", icon = "󰑮 " },
      { "<leader>f", group = "Find", mode = "n" },
      { "<leader>s", group = "Search", mode = "n" },
      { "<leader>x", group = "Trouble", mode = "n", icon = " " },
      { "<leader>t", group = "Toggle" },
      { "<leader>h", group = "Git Hunk", mode = { "n", "v" } },
    })
  end,
}
