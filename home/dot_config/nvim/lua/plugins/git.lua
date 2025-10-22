local M = {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
    keys = {
      {
        "<leader>dvh",
        "<cmd>DiffviewOpen HEAD^<CR>",
        desc = "Diffview HEAD^",
      },
      {
        "<leader>dvo",
        "<cmd>DiffviewOpen<CR>",
        desc = "Diffview",
      },
      {
        "<leader>dvc",
        "<cmd>DiffviewClose!<CR>",
        desc = "Diffview close",
      },
    },
  },
}
return M
