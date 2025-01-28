M = {
  {
    "nvim-treesitter",
    opts = {
      ensure_installed = { "dap_repl" },
      textobjects = {
        select = {
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
        },
      },
    },
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
