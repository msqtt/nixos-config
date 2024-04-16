{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";
    clipboard.register = "unnamedplus";
    colorschemes.catppuccin.enable = true;
    options = {
      langmap = ''qq,dw,re,wr,bt,jy,fu,ui,po,\;p,aa,ss,hd,tf,gg,yh,nj,ek,ol,i\;,zz,xx,mc,cv,vb,kn,lm,QQ,DW,RE,WR,BT,JY,FU,UI,PO,\:P,AA,SS,HD,TF,GG,YH,NJ,EK,OL,I\:,ZZ,XX,MC,CV,VB,KN,LM'';
      clipboard      = "unnamedplus";
      ttyfast        = true;
      autochdir      = false;
      exrc           = true;
      secure         = false;
      number         = true;
      relativenumber = true;
      cursorline     = true;
      expandtab      = true;
      tabstop        = 2;
      smarttab       = true;
      shiftwidth     = 2;
      softtabstop    = 2;
      autoindent     = true;
      list           = true;
      listchars      = "tab:  ,trail:▫";
      fillchars      = "vert:|";
      scrolloff      = 4;
      ttimeoutlen    = 0;
      timeout        = false;
      viewoptions    = "cursor,folds,slash,unix";
      wrap           = true;
      textwidth      = 0;
      indentexpr     = "";
      foldlevel      = 99;
      foldenable     = true;
      foldlevelstart = 99;
      splitright     = true;
      splitbelow     = true;
      showmode       = false;
      smartcase      = true;
      shortmess      = "aoOTIcF";
      inccommand     = "split";
      completeopt    = "longest,noinsert,menuone,noselect,preview";
      visualbell     = true;
      colorcolumn    = "100";
      updatetime     = 100;
      virtualedit    = "block";
      ignorecase     = true;
      foldmethod     = "manual";
    };
    keymaps = [
      {
        key = "<";
        action = "<gv";
        mode = ["v"];
      }
      {
        key = ">";
        action = ">gv";
        mode = ["v"];
      }
      {
        key = "N";
        action = "<cmd>move '>+1<CR>gv-gv";
        options.silent = true;
        mode = ["v"];
      }
      {
        key = "E";
        action = "<cmd>move '>-1<CR>gv-gv";
        options.silent = true;
        mode = ["v"];
      }
      {
        key = "H";
        action = "I<ESC>l";
        mode = ["n"];
      }
      {
        key = "L";
        action = "$";
        mode = ["n"];
      }
      {
        key = "<leader>q";
        action = "<cmd>q!<CR>";
        mode = ["n"];
      }
      {
        key = "<leader>w";
        action = "<cmd>w!<CR>";
        mode = ["n"];
      }
      { 
        key = "cc";
        action = "<C-w>c";
        mode = ["n"];
      }
      { 
        key = "co";
        action = "<C-w>o";
        mode = ["n"];
      }
      { 
        key = "<tab>";
        action = "<cmd>tabn<CR>";
        options.silent = true;
        mode = ["n"];
      }
      { 
        key = "<S-tab>";
        action = "<cmd>tabp<CR>";
        options.silent = true;
        mode = ["n"];
      }
      {
        key = "S";
        mode=["n"];
        action = "viw";
      }
      {
        key = "s";
        mode=["n" "x" "o"];
        lua = true;
        action = ''require("flash").jump'';
      }
      {
        key = "<C-s>";
        mode=["n" "x" "o"];
        lua = true;
        action = ''require("flash").treesitter'';
      }
    ];

    extraConfigLua = ''
      require('Comment').setup()
      require("nvim-surround").setup()
    '' + builtins.readFile ./statusline.lua
    + builtins.readFile ./function.lua;

    extraPlugins = with pkgs.vimPlugins; [
      nvim-surround
      comment-nvim
    ];
    plugins = {
      treesitter.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      flash.enable = true;
      startify.enable = true;
      indent-blankline.enable = true;
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
          "<C-p>" = "git_files";
          "<leader>p" = "oldfiles";
          "<C-f>" = "live_grep";
        };
        keymapsSilent = true;
      };
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };
          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };
        servers = {
          nil_ls.enable = true;
          rust-analyzer= {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
        };
      };
      luasnip.enable = true;
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
            emoji="[emoji]";
          };
        };
      };
      nvim-cmp = {
        enable = true;
        snippet.expand = "luasnip";
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<C-n>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_next_item()";
          };
          "<C-p>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_prev_item()";
          };
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          {name = "path";}
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "emoji";}
          {
            name = "buffer";
            # Words from other open buffers can also be suggested.
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
        ];
      };
    };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      # LIBSEAT_BACKEND = "logind";
    };
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      gcc
      git
      wget
      docker-compose
      # virt-manager
      # qemu_kvm
      (
        let base = pkgs.appimageTools.defaultFhsEnvArgs; in
        pkgs.buildFHSUserEnv (base // {
          name = "fhs";
          targetPkgs = pkgs: (
            with pkgs; [
              pkg-config
              ncurses
              # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
            ]
          );
          profile = "export IN_NIX_SHELL=1";
          runScript = "fish";
          extraOutputsToInstall = [ "dev" ];
        })
      )
    ];
  };
}
