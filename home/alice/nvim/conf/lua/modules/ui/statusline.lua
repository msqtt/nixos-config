function GetModeStatus()
  local mode = vim.fn.mode()
  if mode == 'n' then
    mode = '💩'
  elseif mode == 'i' then
    mode = '📝'
  elseif mode == 'c' then
    mode = '❤️'
  else
    mode = '💾'
  end
  return string.format("%s", mode)
end

function GetGitStatus()
  local gitinfo = vim.b.gitsigns_status
  if gitinfo == nil or gitinfo == '' then
    gitinfo = 'clean'
  end

  return string.format('🐱:[%s]', gitinfo)
end

function GetLspStatus()
  local client = vim.lsp.get_client_by_id(1)
  if client ~= nil then
    client = client.name
  end

  local hint = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local warn = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local error = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local lspinfo = string.format('E:%d,W:%d,H:%d', #error, #warn, #hint)
  return string.format('💡:[%s][%s]', client, lspinfo)
end

vim.o.statusline =
    ' %{v:lua.GetModeStatus()} %t%r%m' .. '%=' ..
    '%{v:lua.GetLspStatus()}' .. '%=' .. '%{v:lua.GetGitStatus()}' .. '%=' .. '%l,%c%V' .. '%=' .. '%ob %P '
