-- Go Test picker using Telescope
-- Provides a filterable interface to run :GoTest commands

local M = {}

-- Define the available Go test commands
local commands = {
  { name = "GoTest",       desc = "Run Go tests",              cmd = "GoTest" },
  { name = "GoTestPkg",    desc = "Run tests for package",   cmd = "GoTestPkg" },
  { name = "GoTestFile",   desc = "Run tests in file",       cmd = "GoTestFile" },
  { name = "GoTestFunc",   desc = "Run test under cursor",   cmd = "GoTestFunc" },
}

function M.gotest_picker()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Go Test Commands",
    layout_strategy = "center",
    layout_config = {
      width = 0.4,
      height = 0.3,
      prompt_position = "top",
    },
    finder = finders.new_table({
      results = commands,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name .. " - " .. entry.desc,
          ordinal = entry.name .. " " .. entry.desc,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          vim.cmd(selection.value.cmd)
        end
      end)
      return true
    end,
  }):find()
end

-- Create user command
vim.api.nvim_create_user_command("GoTestPicker", M.gotest_picker, {
  desc = "Open picker for Go test commands",
})

return M
