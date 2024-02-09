return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        -- for friendly-snippets
        'saadparwaiz1/cmp_luasnip',
        "rafamadriz/friendly-snippets",

        -- for basic complete
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline'
      },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()


      -- for friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        --- (Optional) Show source name in completion menu
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-k>'] = cmp_action.luasnip_jump_forward(),
          ['<C-l>'] = cmp_action.luasnip_jump_backward(),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      })
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({
          buffer = bufnr,

          preserve_mappings = false
        })
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

      lsp_zero.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['lua_ls'] = { 'lua' },
          ['gopls'] = { 'go' },
          ['tsserver'] = { 'javascript', 'typescript' },
          ['rust_analyzer'] = { 'rust' },
        }
      })

      lsp_zero.setup_servers({
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
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
      require 'lspconfig'.volar.setup {
        init_options = {
          typescript = {
            tsdk = '/nix/store/yi14ijlcd02g1nsrf6izbhnwj9vj2lxx-typescript-5.1.6/lib/node_modules/typescript/lib'
            -- Alternative location if installed as root:
            -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
          }
        }
      }
    end
  }
}
