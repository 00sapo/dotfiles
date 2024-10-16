M = {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      require("nvim-dap-repl-highlights").setup()

      -- ensure_installed = { "dap_repl" }
      vim.tbl_extend("force", opts.ensure_installed, { "dap_repl" })
      opts.textobjects.select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      }

      return opts
    end,
    dependencies = { "LiadOz/nvim-dap-repl-highlights" },
  },
  {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter" },
    opts = {
      keymaps = {
        ["<C-;>"] = "swap_with_right",
        ["<C-,>"] = "swap_with_left",
        ["<A-;>"] = "swap_with_right_with_opp",
        ["<A-,>"] = "swap_with_left_with_opp",
      },
    },
  },
}
return M
