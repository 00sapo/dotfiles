local M = {
  -- A function for disabling slow UI components and improve SSH performance
  disable_ui = function()
    -- noice
    require("noice").disable()

    -- indent line animation
    vim.g.miniindentscope_disable = true

    -- neoscroll
    local mappings = require("neoscroll.config").options.mappings
    for _, keymap in ipairs(mappings) do
      vim.keymap.del("n", keymap)
    end
  end,
}

return M
