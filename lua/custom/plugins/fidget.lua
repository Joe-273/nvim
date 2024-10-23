return {
  'j-hui/fidget.nvim',
  opts = {
    -- Options related to LSP progress subsystem
    progress = {
      -- Options related to how LSP progress messages are displayed as notifications
      display = {
        done_icon = "✓", -- Icon shown when all LSP progress tasks are complete
      },
    },

    -- Options related to notification subsystem
    notification = {
      -- Options related to the notification window and buffer
      window = {
        x_padding = 1,      -- Padding from right edge of window boundary
        y_padding = 1,      -- Padding from bottom edge of window boundary
        winblend = 0,       -- Background color opacity in the notification window
        border = "rounded", -- Border around the notification window
        align = "top"       -- How to align the notification window
      },
    },
  }
}
