local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end


local autoCommands = {
  -- don't auto comment new line 
  no_auto_comment = {
    {"BufEnter", "*", "set formatoptions-=cro"}
  },
  -- show cursor line only in active window
  cursor_line = {
    {"InsertLeave,WinEnter", "*", "set cursorline"},
    {"InsertEnter,WinLeave", "*", "set nocursorline"}
  },
}

M.nvim_create_augroups(autoCommands)
