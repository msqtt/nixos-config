local confn = function()
	local lsp = require('lsp-zero').preset({})

	lsp.on_attach(function(client, bufnr)
		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp.default_keymaps({ buffer = bufnr, preserve_mappings = false })
		local opts = { buffer = bufnr }

		vim.keymap.set({ 'n', 'x' }, 'gq', function()
			vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
		end, opts)
	end)

	-- setup lsp
	lsp.setup_servers({ 'tsserver', 'eslint', 'gopls', 'pyright', 'rnix', 'volar',
		'rust_analyzer', 'texlab' })

	-- (Optional) Configure lua language server for neovim
	require 'lspconfig'.lua_ls.setup(lsp.nvim_lua_ls())
	require 'lspconfig'.volar.setup {
		init_options = {
			typescript = {
				tsdk = '/nix/store/yi14ijlcd02g1nsrf6izbhnwj9vj2lxx-typescript-5.1.6/lib/node_modules/typescript/lib'
				-- Alternative location if installed as root:
				-- tsdk = '/usr/local/lib/node_modules/typescript/lib'
			}
		}
	}

	lsp.setup()

	-- nvim-cmp configurations
	local cmp = require('cmp')
	local cmp_action = require('lsp-zero').cmp_action()
	cmp.setup({
		window = {
			completion = cmp.config.window.bordered(winhighlight),
			documentation = cmp.config.window.bordered(winhighlight),
		},
		mapping = {
			-- `Enter` key to confirm completion
			['<CR>'] = cmp.mapping.confirm({ select = false }),

			-- Ctrl+Space to trigger completion menu
			['<C-Space>'] = cmp.mapping.complete(),

			-- Navigate between snippet placeholder
			['<C-j>'] = cmp_action.luasnip_jump_forward(),
			['<C-k>'] = cmp_action.luasnip_jump_backward(),
		}
	})
end

return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	dependencies = {
		-- LSP Support
		{ 'neovim/nvim-lspconfig' }, -- Required

		-- Autocompletion
		{ 'hrsh7th/nvim-cmp',     lazy = true }, -- Required
		{ 'hrsh7th/cmp-nvim-lsp', lazy = true }, -- Required
		{ 'L3MON4D3/LuaSnip',     lazy = true }, -- Required
	},
	config = confn
}
