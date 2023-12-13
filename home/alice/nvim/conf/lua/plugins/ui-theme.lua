return {
  "msqtt/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,

  config = function()
    -- Lua initialization file
    vim.g.moonflyCursorColor = false
    vim.g.moonflyNormalFloat = true
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = "single"
      }
    )
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signatureHelp, {
        border = "single"
      }
    )
    vim.diagnostic.config({ float = { border = "single" } })
    -- Lua initialization file
    vim.g.moonflyWinSeparator = 0
    vim.g.moonflyUnderlineMatchParen = true
    vim.cmd [[colorscheme moonfly]]
  end
}
