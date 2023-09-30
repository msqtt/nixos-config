local opt                          = vim.o

vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

opt.clipboard                      = 'unnamedplus'
opt.ttyfast                        = true
opt.autochdir                      = false
opt.exrc                           = true
opt.secure                         = false
opt.number                         = true
opt.relativenumber                 = true
opt.cursorline                     = true
opt.expandtab                      = false
opt.tabstop                        = 2
opt.smarttab                       = true
opt.shiftwidth                     = 2
opt.softtabstop                    = 2
opt.autoindent                     = true
opt.list                           = true
opt.listchars                      = 'tab:|\\ ,trail:▫'
opt.scrolloff                      = 4
opt.ttimeoutlen                    = 0
opt.timeout                        = false
opt.viewoptions                    = 'cursor,folds,slash,unix'
opt.wrap                           = true
opt.textwidth                      = 0
opt.indentexpr                     = ''
opt.foldmethod                     = 'indent'
opt.foldlevel                      = 99
opt.foldenable                     = true
opt.foldlevelstart                 = 99
-- opt.formatoptions = opt.formatoptions:gsub('tc', '')
opt.splitright                     = true
opt.splitbelow                     = true
opt.showmode                       = false
opt.ignorecase                     = false
opt.smartcase                      = true
opt.shortmess                      = "aoOTIcF"
opt.inccommand                     = 'split'
opt.completeopt                    = 'longest,noinsert,menuone,noselect,preview'
opt.completeopt                    = 'menuone,noinsert,noselect,preview'
-- opt.lazyredraw = true
opt.visualbell                     = true
opt.colorcolumn                    = '100'
opt.updatetime                     = 100
opt.virtualedit                    = 'block'
opt.backupcopy                     = "yes"
opt.ignorecase                     = true
