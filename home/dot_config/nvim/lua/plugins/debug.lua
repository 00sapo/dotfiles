M = {
  {
    "andrewferrier/debugprint.nvim",
    opts = {
      keymaps = {
        normal = {
          plain_below = "<leader>dp",
          plain_above = "<leader>dP",
          variable_below = "<leader>dv",
          variable_above = "<leader>dV",
          variable_below_alwaysprompt = "",
          variable_above_alwaysprompt = "",
          surround_plain = "<leader>dsp",
          surround_variable = "<leader>dsv",
          surround_variable_alwaysprompt = "",
          textobj_below = "<leader>do",
          textobj_above = "<leader>dO",
          textobj_surround = "<leader>dso",
          toggle_comment_debug_prints = "<leader>dc",
          delete_debug_prints = "<leader>dd",
        },
        insert = {
          plain = "<C-G>p",
          variable = "<C-G>v",
        },
        visual = {
          variable_below = "<leader>dv",
          variable_above = "<leader>dV",
        },
      },
    },
    dependencies = {
      "nvim-mini/mini.nvim", -- Optional: Needed for line highlighting (full mini.nvim plugin)
      "nvim-mini/mini.hipatterns", -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)
      "ibhagwan/fzf-lua", -- Optional: If you want to use the `:Debugprint search` command with fzf-lua
    },
    lazy = false, -- Required to make line highlighting work before debugprint is first used
    version = "*", -- Remove if you DON'T want to use the stable version
  },
}
return M
