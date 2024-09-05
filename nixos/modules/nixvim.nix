{ pkgs, ... }:
let
  window-border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
in
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";
    clipboard.register = "unnamedplus";
    colorschemes.vscode.enable = true;
    opts = {
      langmap = "yh,hy,nj,jn,ek,ke,ol,lo,YH,HY,NJ,JN,EK,KE,OL,LO";
      clipboard = "unnamedplus";
      termguicolors = true;
      ttyfast = true;
      autochdir = false;
      exrc = true;
      secure = false;
      number = true;
      relativenumber = true;
      cursorline = true;
      expandtab = true;
      tabstop = 2;
      smarttab = true;
      shiftwidth = 2;
      softtabstop = 2;
      autoindent = true;
      list = true;
      listchars = "tab:▫▫,trail:▫";
      fillchars = "vert:|";
      scrolloff = 4;
      ttimeoutlen = 0;
      timeout = false;
      viewoptions = "cursor,folds,slash,unix";
      wrap = true;
      textwidth = 0;
      indentexpr = "";
      foldlevel = 99;
      foldenable = true;
      foldlevelstart = 99;
      splitright = true;
      splitbelow = true;
      showmode = false;
      smartcase = true;
      shortmess = "aoOTIcF";
      inccommand = "split";
      completeopt = "longest,noinsert,menuone,noselect,preview";
      visualbell = true;
      colorcolumn = "100";
      updatetime = 100;
      virtualedit = "block";
      ignorecase = true;
      foldmethod = "manual";
    };
    keymaps = [
      {
        key = "<";
        action = "<gv";
        mode = [ "v" ];
      }
      {
        key = ">";
        action = ">gv";
        mode = [ "v" ];
      }
      {
        key = "J";
        action = "<cmd>move '>+1<CR>gv-gv";
        options.silent = true;
        mode = [ "v" ];
      }
      {
        key = "K";
        action = "<cmd>move '>-2<CR>gv-gv";
        options.silent = true;
        mode = [ "v" ];
      }
      {
        key = "H";
        action = "I<ESC>l";
        mode = [ "n" ];
      }
      {
        key = "L";
        action = "$";
        mode = [ "n" ];
      }
      {
        key = "<leader>q";
        action = "<cmd>q!<CR>";
        mode = [ "n" ];
      }
      {
        key = "<leader>w";
        action = "<cmd>w!<CR>";
        mode = [ "n" ];
      }
      {
        key = "cc";
        action = "<C-w>c";
        mode = [ "n" ];
      }
      {
        key = "co";
        action = "<C-w>o";
        mode = [ "n" ];
      }
      {
        key = "<tab>";
        action = "<cmd>tabn<CR>";
        options.silent = true;
        mode = [ "n" ];
      }
      {
        key = "<S-tab>";
        action = "<cmd>tabp<CR>";
        options.silent = true;
        mode = [ "n" ];
      }
      {
        key = "S";
        mode = [ "n" ];
        action = "viw";
      }
      {
        key = "vv";
        mode = [ "n" ];
        action = "_v$";
      }
      {
        key = "s";
        mode = [ "n" "x" "o" ];
        lua = true;
        action = "require('flash').jump";
      }
      {
        key = "<C-s>";
        mode = [ "n" "x" "o" ];
        lua = true;
        action = "require('flash').treesitter";
      }
      {
        key = "<C-c>";
        mode = [ "n" "x" "o" ];
        action = "<ESC>";
      }
      {
        key = "<C-d>";
        mode = [ "i" ];
        action = "<Delete>";
      }
      {
        key = "wpg";
        mode = [ "c" ];
        action = "w !jbl -p 50 | wl-copy";
      }
      {
        key = "<C-l>";
        mode = [ "n" ];
        action = "<C-i>";
        options = {
          silent = true;
          noremap = true;
        };
      }
    ];

    extraConfigLua = ''
        require("nvim-surround").setup()
        require("bufferline").setup({
          options = {
              buffer_close_icon = "",
              close_command = "bdelete %d",
              close_icon = "",
              indicator = {
                style = "icon",
                icon = " ",
              },
              left_trunc_marker = "",
              modified_icon = "●",
              offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
              right_mouse_command = "bdelete! %d",
              right_trunc_marker = "",
              show_close_icon = false,
              show_tab_indicators = true,
          },
          highlights = {
              fill = {
                  fg = { attribute = "fg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "StatusLineNC" },
              },
              background = {
                  fg = { attribute = "fg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "StatusLine" },
              },
              buffer_visible = {
                  fg = { attribute = "fg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "Normal" },
              },
              buffer_selected = {
                  fg = { attribute = "fg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "Normal" },
              },
              separator = {
                  fg = { attribute = "bg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "StatusLine" },
              },
              separator_selected = {
                  fg = { attribute = "fg", highlight = "Special" },
                  bg = { attribute = "bg", highlight = "Normal" },
              },
              separator_visible = {
                  fg = { attribute = "fg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "StatusLineNC" },
              },
              close_button = {
                  fg = { attribute = "fg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "StatusLine" },
              },
              close_button_selected = {
                  fg = { attribute = "fg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "Normal" },
              },
              close_button_visible = {
                  fg = { attribute = "fg", highlight = "Normal" },
                  bg = { attribute = "bg", highlight = "Normal" },
              },
          },
      })
    '';

    extraPlugins = with pkgs.vimPlugins; [
      nvim-surround
    ];
    plugins = {
      friendly-snippets.enable = true;
      comment.enable = true;
      treesitter.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      flash.enable = true;
      startify.enable = true;
      indent-blankline.enable = false;
      lualine = {
        enable = true;
        theme = "vscode";
      };
      bufferline = {
        enable = true;
      };
      telescope = {
        enable = true;
        keymaps = {
          # Find files using Telescope command-line sugar.
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fd" = "diagnostics";
          # FZF like bindings
          "<leader>/" = "current_buffer_fuzzy_find";
          "<C-p>" = "git_files";
          "<leader>p" = "oldfiles";
          "<C-f>" = "live_grep";
        };
      };
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
            gl = "open_float";
          };
          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            ga = "code_action";
            "<F2>" = "rename";
          };
        };
        servers = {
          nixd.enable = true;
          volar.enable = true;
          tsserver.enable = true;
          gopls = {
            enable = false;
            extraOptions = { completeUnimported = true; };
          };
          rust-analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
        };
      };
      luasnip = {
        enable = true;
        fromVscode = [{ }];
      };
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            emoji = "[emoji]";
          };
        };
      };
      cmp-emoji.enable = true;
      cmp-cmdline.enable = true;
      cmp-path.enable = true;
      lsp-format.enable = true;
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "luasnip";
          experimental.ghost_text = false;
          window = {
            completion.border = window-border;
            documentation.border = window-border;
          };
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-u>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<C-.>" = ''
              function(fallback)
                local luasnip = require("luasnip")
                if luasnip.locally_jumpable(1) then
                  luasnip.jump(1)
                end
              end
            '';
            "<C-,>" = ''
              function(fallback)
                local luasnip = require("luasnip")
                if luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                end
              end
            '';
            "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
            "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "emoji"; }
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
          ];
        };
      };
    };
  };
}
