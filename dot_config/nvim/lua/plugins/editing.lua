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
}

return M
