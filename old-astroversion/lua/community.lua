-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" }, -- Lua
  { import = "astrocommunity.pack.vue" }, -- JS TS Vue
  { import = "astrocommunity.pack.html-css" }, -- Html Css
  -- import/override with your plugins folder
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.lsp.lsp-signature-nvim" },
  { import = "astrocommunity.color.nvim-highlight-colors" },
  { import = "astrocommunity.color.transparent-nvim" },
}
