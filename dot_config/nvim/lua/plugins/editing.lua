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
    config = function()
      require("better_escape").setup({
        mapping = { "jk", "kj" }, -- a table with mappings to use
        clear_empty_lines = true, -- clear line after escaping if there is only whitespace
        keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
        -- example(recommended)
        -- keys = function()
        --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
        -- end,
      })
    end,
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaWrite", "SudaRead" },
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at < EOF > when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end,
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
