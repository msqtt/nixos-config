let
  window-border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
  indent = 2;
in
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";
    clipboard.register = "unnamedplus";
    colorschemes.catppuccin = {
      enable = true;
      settings.background.dark = "mocha";
    };

    diagnostic.settings = {
      virtual_text = true;
    };
    opts = {
      langmap = "yh,hy,nj,jn,ek,ke,ol,lo,YH,HY,NJ,JN,EK,KE,OL,LO";
      clipboard = "unnamedplus";
      ttyfast = true;
      autochdir = true;

      wrap = true;
      colorcolumn = "80";
      ignorecase = true;
      smartcase = true;

      termguicolors = true;
      number = true;
      relativenumber = true;
      showmode = false;

      expandtab = true;
      tabstop = indent;
      shiftwidth = indent;
      softtabstop = indent;
      smarttab = true;
      autoindent = true;
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
        key = "S:";
        mode = [ "n" ];
        action = ''viwy<CR><cmd>let @/ = @"<CR>:%s//<C-R><C-V>'';
      }
      {
        key = "vv";
        mode = [ "n" ];
        action = "_v$";
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
        key = "<C-l>";
        mode = [ "n" ];
        action = "<C-i>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<A-t>";
        action = "<cmd>tabe<CR>";
        mode = [ "n" ];
      }
      { key = "wpg"; mode = [ "c" ]; action = "w !jbl -p 50 | wl-copy"; }

      { mode = "n"; key = "<leader>ya"; action.__raw = "function() require'harpoon':list():add() end"; }
      { mode = "n"; key = "<leader>ye"; action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end"; }
      { mode = "n"; key = "<C-j>"; action.__raw = "function() require'harpoon':list():select(1) end"; }
      { mode = "n"; key = "<C-k>"; action.__raw = "function() require'harpoon':list():select(2) end"; }
      { mode = "n"; key = "<C-l>"; action.__raw = "function() require'harpoon':list():select(3) end"; }
      { mode = "n"; key = "<C-m>"; action.__raw = "function() require'harpoon':list():select(4) end"; }

      { key = "s"; mode = [ "n" "x" "o" ]; lua = true; action.__raw = "require('flash').jump"; }
      { key = "<C-s>"; mode = [ "n" "x" "o" ]; lua = true; action.__raw = "require('flash').treesitter"; }

      { mode = "n"; key = "K"; action = "<cmd>Lspsaga hover_doc<CR>"; }
      { mode = "n"; key = "gr"; action = "<cmd>Lspsaga rename<CR>"; }
      { mode = "n"; key = "F2"; action = "<cmd>Lspsaga rename<CR>"; }
      { mode = "n"; key = "gf"; action = "<cmd>Lspsaga finder<CR>"; }
      { mode = "n"; key = "gj"; action = "<cmd>Lspsaga diagnostic_jump_next<CR>"; }
      { mode = "n"; key = "gk"; action = "<cmd>Lspsaga diagnostic_jump_prev<CR>"; }
      { mode = "n"; key = "gd"; action = "<cmd>Lspsaga show_cursor_diagnostics<CR>"; }
      { mode = "n"; key = "gD"; action = "<cmd>Lspsaga show_workspace_diagnostics<CR>"; }
      { mode = "n"; key = "ga"; action = "<cmd>Lspsaga code_action<CR>"; }
      { mode = "n"; key = "go"; action = "<cmd>Lspsaga outline<CR>"; }
      { mode = "n"; key = "gt"; action = "<cmd>Lspsaga term_toggle<CR>"; }
    ];

    extraConfigLua = ''
      ----------------------------
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

      function CloseCmd()
        local ter_nr = vim.g.terminal_buffer_nr
        if ter_nr then
          vim.g.terminal_buffer_nr = nil
          pcall(vim.api.nvim_buf_delete, ter_nr, { force = true })
        end
      end

      vim.cmd("command! -nargs=1 RunCmd lua RunCmd(<f-args>)")
      vim.cmd("command! CloseCmd lua CloseCmd()")

      vim.keymap.set({ "n" }, "!", ":RunCmd ", {noremap =  true})
      vim.keymap.set({ "n" }, "d!", "<cmd>CloseCmd<CR>", {noremap =  true})
      ----------------------------

      -- require("nvim-surround").setup()
    '';

    # extraPlugins = with pkgs.vimPlugins; [
    #   nvim-surround
    # ];

    plugins = {
      treesitter = {
        enable = true;
        settings.highlight.enable = true;
      };
      friendly-snippets.enable = true;

      yazi.enable = true;
      web-devicons.enable = true;
      # indent-blankline.enable = true;
      hlchunk = {
        enable = true;
        autoLoad = true;
        settings = {
          blank = {
            enable = true;
          };
          chunk = {
            enable = true;
            exclude_filetypes = {
              lazyterm = true;
              neo-tree = true;
              lspinfo = true;
              dashboard = true;
              man = true;
            };
            use_treesitter = false;
          };
          indent = {
            enable = false;
            exclude_filetypes = {
              lazyterm = true;
              neo-tree = true;
            };
            use_treesitter = false;
          };
          line_num = {
            use_treesitter = false;
          };
        };
      };
      gitsigns.enable = true;
      dropbar.enable = true;
      startify.enable = true;
      lualine = {
        enable = true;
      };

      nvim-surround = {
        enable = true;
        # settings = {
        #   aliases = ''
        #     {
        #       "a" = ">";
        #       "b" = ")";
        #       "B" = "}";
        #       "r" = "]";
        #       "q" = [ "\"" "'" "`" ];
        #       "s" = [ "}" "]" ")" ">" "\"" "'" "`" ];
        #     }
        #   '';
        #   keymaps = ''
        #     {
        #         insert = "<C-g>s";
        #         insert_line = "<C-g>S";
        #         normal = "ys";
        #         normal_cur = "yss";
        #         normal_line = "yS";
        #         normal_cur_line = "ySS";
        #         visual = "S";
        #         visual_line = "gS";
        #         delete = "ds";
        #         change = "cs";
        #         change_line = "cS";
        #       }
        #     '';
        # };
      };
      nvim-autopairs.enable = true;
      flash.enable = true;
      comment.enable = true;

      harpoon = {
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

      lspsaga = {
        enable = true;
        symbolInWinbar.enable = false;
        ui.codeAction = "🌟";
        lightbulb = {
          sign = false;
          virtualText = true;
        };
      };
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          # diagnostic = {
          #   # Navigate in diagnostics
          #   "<leader>k" = "goto_prev";
          #   "<leader>j" = "goto_next";
          #   gl = "open_float";
          # };
          # lspBuf = {
          #   gd = "definition";
          #   gD = "references";
          #   gt = "type_definition";
          #   gi = "implementation";
          #   K = "hover";
          #   ga = "code_action";
          #   "<F2>" = "rename";
          # };
        };
        servers = {
          jsonls.enable = true;
          yamlls.enable = true;
          sqls.enable = true;
          dockerls.enable = true;
          docker_compose_language_service.enable = true;

          nushell.enable = true;
          bashls.enable = true;
          nixd.enable = true;
          pylsp.enable = true;
          systemd_ls.enable = true;

          emmet_language_server.enable = true;
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = true;
          ts_ls.enable = true;
          svelte.enable = false;
          volar.enable = true;

          elixirls.enable = true;
          gopls = {
            enable = true;
            extraOptions = { completeUnimported = true; };
          };
          rust_analyzer = {
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
