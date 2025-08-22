local M = {
  {
    "mbbill/undotree",
    keys = { "<space>ts", "<space>tt" },
    cmd = { "UndotreeShow", "UndotreeToggle" },
  },
  -- {
  --   "kdheepak/lazygit.nvim",
  --   cmd = {
  --     "LazyGit",
  --     "LazyGitConfig",
  --     "LazyGitCurrentFile",
  --     "LazyGitFilter",
  --     "LazyGitFilterCurrentFile",
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   keys = {
  --     { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  --   },
  -- },
  {
    "pgr0ss/vim-github-url",
    cmd = { "GitHubURLRepo", "GitHubURLBlob", "GitHubURLBlame" },
  },
}
return M
