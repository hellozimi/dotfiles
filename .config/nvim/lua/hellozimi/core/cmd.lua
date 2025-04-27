-- Function to delete all buffers while preserving layout
local function delete_all_buffers_preserve_layout()
  -- Store current window
  local current_win = vim.api.nvim_get_current_win()

  -- Get list of all buffers
  local buffers = vim.api.nvim_list_bufs()

  -- For each window, create a new buffer and set it
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    vim.api.nvim_set_current_win(win)
    local new_buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_win_set_buf(win, new_buf)
  end

  -- Delete all old buffers
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  -- Restore current window
  vim.api.nvim_set_current_win(current_win)
end

-- Create the command
vim.api.nvim_create_user_command('BDA', delete_all_buffers_preserve_layout, {})
-- Create the abbreviation
vim.cmd('cnoreabbrev bda BDA')
