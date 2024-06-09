return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      diffview = true,
      show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "light",
        percentage = 0.75, -- percentage of the shade to apply to the inactive window
      },
      custom_highlights = function(colors)
        -- make diff colors more visible (magenta for removed, green for added, cyan for changed, yellow for DiffText)
        --
        return {
          DiffDelete = { bg = "#4D1920" },
          DiffAdd = { bg = "#194D33" },
          DiffChange = { bg = "#19314D" },
          DiffText = { bg = "#4D4919" },
          CursorLine = { bg = "#30194D" },
          CursorColumn = { bg = "#30194D" },
          Visual = { bg = "#4D1935" },
        }
      end,
    },
  },
  {
    "vigoux/notifier.nvim",
    opts = {}, -- needed to force call to setup
  },
}
