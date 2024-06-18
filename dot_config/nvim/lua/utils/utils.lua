local actions_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local function load_launchjs(bufnr)
  local file = actions_state.get_selected_entry()[1]
  vim.print(file)
  require("dap.ext.vscode").load_launchjs(file)
  actions.close(bufnr)
end

local M = {

  -- A function that loads the file chosen by the user with nvim-dap
  dap_chooser = function()
    require("telescope.builtin").find_files({
      attach_mappings = function(_, map)
        map("n", "<cr>", load_launchjs)
        map("i", "<cr>", load_launchjs)
        return true
      end,
    })
  end,
}

return M
