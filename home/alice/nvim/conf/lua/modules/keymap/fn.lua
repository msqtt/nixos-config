function RunCmd(cmd)
  local ter_nr = vim.g.terminal_buffer_nr
  if ter_nr then
    vim.g.terminal_buffer_nr = nil
    pcall(vim.api.nvim_buf_delete, ter_nr, { force = true })
  end
  vim.cmd("sp | term " .. cmd)
  -- 获取当前 buffer 的编号并存储到变量中
  vim.g.terminal_buffer_nr = vim.fn.bufnr("%")
end

vim.cmd("command! -nargs=1 RunCmd lua RunCmd(<f-args>)")
