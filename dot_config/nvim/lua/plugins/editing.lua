local M = {
  { "sindrets/diffview.nvim" },
  {
    "andrewferrier/debugprint.nvim",
    dependencies = {
      "echasnovski/mini.nvim", -- Needed to enable :ToggleCommentDebugPrints for NeoVim <= 0.9
      "nvim-treesitter/nvim-treesitter", -- Needed to enable treesitter for NeoVim 0.8
    },
    opts = {
      keymaps = {
        normal = {
          plain_below = "<leader>dp",
          plain_above = "<leader>dP",
          variable_below = "<leader>dv",
          variable_above = "<leader>dV",
          variable_below_alwaysprompt = nil,
          variable_above_alwaysprompt = nil,
          textobj_below = "<leader>do",
          textobj_above = "<leader>dO",
          toggle_comment_debug_prints = nil,
          delete_debug_prints = nil,
        },
        visual = {
          variable_below = "<leader>dv",
          variable_above = "<leader>dV",
        },
      },
    },
    keys = {
      { "<leader>d", mode = "n", desc = "Debug print" },
      { "<leader>d", mode = "x", desc = "Debug print" },
    },
    cmd = {
      "ToggleCommentDebugPrints",
      "DeleteDebugPrints",
    },
    -- avoid development versions
    version = "*",
  },
  {
    "cosmicboots/unicode_picker.nvim",
    dependencies = {
      "uga-rosa/utf8.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local unicode_picker = require("unicode_picker")
      vim.keymap.set("i", "<c-u>", unicode_picker.unicode_chars, { noremap = true, silent = true })
    end,
  },
  {
    "max397574/better-escape.nvim",
    opts = {},
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
  },
  {
    "Mr-LLLLL/interestingwords.nvim",
    opts = {
      colors = {
        "#ff4538",
        "#ffe438",
        "#7bff38",
        "#38ff95",
        "#38caff",
        "#4538ff",
        "#e438ff",
        "#ff387b",
        "#ff9538",
        "#caff38",
        "#9538ff",
      },
      --"#aeee00", "#ff0000", "#0000ff", "#b88823", "#ffa724", "#ff2c4b" },
      search_count = true,
      navigation = true,
      search_key = "<leader>m",
      cancel_search_key = "<leader>M",
      color_key = "<leader>k",
      cancel_color_key = "<leader>K",
    },
    keys = { -- added for lazyloading
      "<leader>m",
      "<leader>M",
      "<leader>k",
      "<leader>K",
    },
  },
  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({
        max_length = 0, -- Maximum length of selection (0 for no limit)
        silent = false, -- Disable message on successful copy
        trim = false, -- Trim surrounding whitespaces before copy
      })
      local function copy()
        if (vim.v.event.operator == "y" or vim.v.event.operator == "d") and vim.v.event.regname == "" then
          require("osc52").copy_register("")
        end
      end

      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
    end,
  },
}

return M
