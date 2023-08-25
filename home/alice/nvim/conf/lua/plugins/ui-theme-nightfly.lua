return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  lazy = false,
  priority = 1000,
  config = function ()
		vim.g.moonflyCursorColor = true
		vim.g.moonflyUnderlineMatchParen = true
		vim.g.moonflyVirtualTextColor = true
		-- float color
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
		local winhighlight = {
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
		}
		vim.cmd [[colorscheme moonfly]]
  end
}
