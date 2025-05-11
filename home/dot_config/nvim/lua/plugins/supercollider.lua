local M = {
  {
    "davidgranstrom/scnvim",
    ft = { "supercollider" },
    config = function()
      local scnvim = require("scnvim")
      local map = scnvim.map
      local map_expr = scnvim.map_expr
      require("scnvim").setup({
        -- documentation = {
        --   cmd = "/usr/bin/pandoc",
        -- },
        keymaps = {
          ["<M-e>"] = map("editor.send_line", { "i", "n" }),
          ["<C-e>"] = {
            map("editor.send_block", { "i", "n" }),
            map("editor.send_selection", "x"),
          },
          ["<CR>"] = map("postwin.toggle"),
          ["<M-CR>"] = map("postwin.toggle", "i"),
          ["<M-L>"] = map("postwin.clear", { "n", "i" }),
          ["<C-k>"] = map("signature.show", { "n", "i" }),
          ["<F12>"] = map("sclang.hard_stop", { "n", "x", "i" }),
          ["<F1>"] = map("sclang.start"),
          ["<F2>"] = map_expr("s.boot"),
          ["<F3>"] = map_expr("s.meter"),
          ["<F4>"] = map("sclang.recompile"),
        },
      })
    end,
    editor = {
      highlight = {
        color = "IncSearch",
      },
    },
    postwin = {
      float = {
        enabled = true,
      },
    },
  },
  build = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.supercollider = {
      install_info = {
        url = "https://github.com/madskjeldgaard/tree-sitter-supercollider",
        files = { "src/parser.c", "src/scanner.c" },
        maintainer = "@madskjeldgaard",
      },
      filetype = "supercollider", -- if filetype does not agrees with parser name
    }
    require("nvim-treesitter.install").update({ with_sync = true }) -- update all parsers
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
  {
    "davidgranstrom/telescope-scdoc.nvim",
    ft = { "supercollider" },
    keys = {
      { "<leader>sc", "<cmd>Telescope scdoc<cr>", desc = "SuperCollider Doc" },
    },
    config = function()
      require("telescope").load_extension("scdoc")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  -- {
  --   "madskjeldgaard/fzf-sc",
  --   ft = { "supercollider" },
  --   config = function()
  --     scnvim = require("scnvim")
  --     scnvim.load_extension("fzf-sc")
  --   end,
  --   dependencies = {
  --     "vijaymarupudi/nvim-fzf",
  --     "davidgranstrom/scnvim",
  --   },
  -- },
}
return M
