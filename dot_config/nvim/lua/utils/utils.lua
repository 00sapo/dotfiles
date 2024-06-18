local M = {

  -- A function that lists all json files in this directory and sub directory using Telescope
  -- And let the user chose one
  json_picker = function()
    local opts = {
      prompt_title = "Select a json file",
      cwd = vim.fn.expand("."),
      hidden = true,
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.5,
        height = 0.5,
      },
    }
    require("telescope.builtin").find_files(opts)
  end,

  -- A function that loads the file chosen by the user with nvim-dap
  dap_chooser = function()
    local file = M.json_picker()
    require("dap.ext.vscode").load_launchjs(file)
  end,
}

return M
