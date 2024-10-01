local M = {
  { "sindrets/diffview.nvim" },
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
    enabled = vim.fn.has("nvim-0.10") ~= 1,
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
  { -- use Ctrl+Enter to confirm in place of Enter
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      local complete = cmp.mapping.complete()
      local confirm = cmp.mapping.confirm({ select = true })

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-Space>"] = function(fallback)
          if cmp.visible() then
            return confirm(fallback)
          else
            return complete(fallback)
          end
        end,
      })

      opts.mapping["<CR>"] = nil
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        todo = { enabled = true }, -- if set to "true", todo-comments.nvim highlights will be disabled
        wezterm = { enabled = true, font = "+4" },
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 1, -- turn off the statusline in zen mode
        },
      },
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 0.5, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          signcolumn = "yes", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      on_open = function(win)
        -- set spelllang to it-IT
        vim.api.nvim_set_option_value("spelllang", "it", {})
        -- disable diagnostics
        vim.diagnostic.enable(false)
        -- disable autocomplete
        require("cmp").setup.buffer({ enabled = false })
        -- limit maximum number of characters per line
        vim.api.nvim_set_option_value("textwidth", 60, {})
        -- disable tmux statusline and panes
        vim.fn.system([[tmux set status off]])
        vim.fn.system([[tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z]])
      end,
      on_close = function()
        -- enable diagnostics
        vim.diagnostic.enable(true)
        require("cmp").setup.buffer({ enabled = true })
        -- restore tmux statusline and panes
        vim.fn.system([[tmux set status on]])
        vim.fn.system([[tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z]])
      end,
    },
    dependencies = { "folke/twilight.nvim" },
  },
}

return M
