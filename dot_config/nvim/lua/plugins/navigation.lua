local M = {
  {
    "aerial.nvim",
    opts = {
      float = {
        relative = "win",
      },
      nav = {
        preview = true,
      },
    },
    keys = {
      { "n", "<leader>n", require("aerial").nav_toggle, desc = "Toggle Aerial" },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
    config = function()
      require("symbols-outline").setup({})
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "AI" },
        { "<leader>ag", group = "generate into..." },
        { "<leader>au", group = "user's prompts" },
        { "<leader>m", group = "Marks" },
      },
    },
  },
  {
    "willothy/flatten.nvim",
    opts = {
      window = { open = "alternate" },
    },
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  {
    "tris203/precognition.nvim",
    opts = {
      hints = {
        Caret = { text = "_", prio = 2 },
      },
    },
  },
  {
    "tomasky/bookmarks.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VimEnter",
    config = function()
      require("bookmarks").setup({
        sign_priority = 8, --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand("$HOME/.cache/nvim/bookmarks"), -- bookmarks save file path
        keywords = {
          ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
          ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
          ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
          ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
        },
        on_attach = function(bufnr)
          local bm = require("bookmarks")
          local map = vim.keymap.set
          map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
          map("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
          map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
          map("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
          map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
        end,
      })
      require("telescope").load_extension("bookmarks")
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
  },
}
return M
