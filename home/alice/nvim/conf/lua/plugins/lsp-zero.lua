local confn = function()
	local lsp = require('lsp-zero').preset({})

	lsp.on_attach(function(client, bufnr)
		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp.default_keymaps({ buffer = bufnr, preserve_mappings = false })
		local opts = { buffer = bufnr }

		vim.keymap.set({ 'n', 'x' }, 'gn', function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set({ 'n', 'x' }, 'gq', function()
			vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
		end, opts)
		vim.keymap.set({ 'n', 'x' }, 'ga', function()
			vim.lsp.buf.code_action()
		end, opts)
	end)

	-- setup lsp
	lsp.setup_servers({
		'tsserver',
		'eslint',
		'html',
		'cssls',
		'tailwindcss',
		'volar',
		'gopls',
		'pyright',
		'rnix',
		'rust_analyzer',
		'texlab',
		'hls',
		'bufls',
		'typst_lsp',
		'sqlls'
	})

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
	local cmp_format = require('lsp-zero').cmp_format()

	require('luasnip.loaders.from_vscode').lazy_load() -- for friendly snippets.

	cmp.setup({
		window = {
			completion = cmp.config.window.bordered(winhighlight),
			documentation = cmp.config.window.bordered(winhighlight),
		},
		sources = {
			{ name = 'buffer' },
			{ name = 'path' },
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		},
		mapping = {
			-- `Enter` key to confirm completion
			['<CR>'] = cmp.mapping.confirm({ select = true }),

			-- Ctrl+Space to trigger completion menu
			['<C-Space>'] = cmp.mapping.complete(),

			-- Navigate between snippet placeholder
			['<C-f>'] = cmp_action.luasnip_jump_forward(),
			['<C-b>'] = cmp_action.luasnip_jump_backward(),
		},
		--- (Optional) Show source name in completion menu
		formatting = cmp_format,
	})
	-- `/` cmdline setup.
	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})
	-- `:` cmdline setup.
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{
				name = 'cmdline',
				option = {
					ignore_cmds = { 'Man', '!' }
				}
			}
		})
	})
end

return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	dependencies = {
		-- LSP Support
		{ 'neovim/nvim-lspconfig' }, -- Required

		-- Autocompletion
		{ 'hrsh7th/nvim-cmp',             lazy = true }, -- Required
		{ 'hrsh7th/cmp-nvim-lsp',         lazy = true }, -- Required
		{ 'L3MON4D3/LuaSnip',             lazy = true }, -- Required

		{ 'hrsh7th/cmp-buffer',           lazy = true },
		{ 'hrsh7th/cmp-cmdline',          lazy = true },
		{ 'hrsh7th/cmp-path',             lazy = true },
		{ 'saadparwaiz1/cmp_luasnip',     lazy = true }, -- for custom snippets.
		{ 'rafamadriz/friendly-snippets', lazy = true }, -- for custom snippets.
	},
	config = confn
}
