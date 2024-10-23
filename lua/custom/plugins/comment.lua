return {
  {
    -- Smart and Powerful commenting plugin for neovim
    'numToStr/Comment.nvim',
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false
    }
  }
}
