return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
      },
    },
  },
  { "EdenEast/nightfox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dawnfox",
    },
  },
  -- {
  --   "lualine/lualine.nvim",
  --   opts = {
  --     options = {
  --       sections = {
  --         lualine_x = { { "searchcount", maxcount = 999999 } },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   opts = {
  --     flavour = "frappe",
  --     diffview = true,
  --     show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
  --     dim_inactive = {
  --       enabled = true, -- dims the background color of inactive window
  --       shade = "dark",
  --       percentage = 0.5, -- percentage of the shade to apply to the inactive window
  --     },
  --     custom_highlights = function(colors)
  --       -- make diff colors more visible (magenta for removed, green for added, cyan for changed, yellow for DiffText)
  --       --
  --       return {
  --         -- N.B. If change these colors, check the OptionSet autocmd in autocmds.lua
  --         DiffDelete = { bg = "#4D1920" },
  --         DiffAdd = { bg = "#194D33" },
  --         DiffChange = { bg = "#19314D" },
  --         DiffText = { bg = "#4D4919" },
  --         -- CursorLine = { bg = "#30194D" }, -- dark
  --         Visual = { bg = "#4D1935" }, --dark
  --         -- Visual = { bg = "#DAF7A6" }, -- light
  --       }
  --     end,
  --   },
  -- },
}
