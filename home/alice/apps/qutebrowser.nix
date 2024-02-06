{ config, pkgs, ... }:
{
  programs.qutebrowser = {
    enable = true;
    enableDefaultBindings = false;
    settings = {
      content.proxy = "socks5://localhost:20170";
      colors.webpage.darkmode.enabled = true;
      editor.command = [ "footclient" "-e" "nvim" "{file}" "+call cursor({line}, {column})" ];
    };
    keyBindings = {
      caret = {
        "$" = "move-to-end-of-line";
        "0" = "move-to-start-of-line";
        "<Ctrl-Space>" = "selection-drop";
        "<Escape>" = "mode-leave";
        "<Return>" = "yank selection";
        "<Space>" = "selection-toggle";
        "G" = "move-to-end-of-document";
        "Y" = "scroll left";
        "N" = "scroll down";
        "E" = "scroll up";
        "O" = "scroll right";
        "V" = "selection-toggle --line";
        "H" = "yank selection -s";
        "[" = "move-to-start-of-prev-block";
        "]" = "move-to-start-of-next-block";
        "b" = "move-to-prev-word";
        "c" = "mode-enter normal";
        "k" = "move-to-end-of-word";
        "gg" = "move-to-start-of-document";
        "y" = "move-to-prev-char";
        "n" = "move-to-next-line";
        "e" = "move-to-prev-line";
        "o" = "move-to-next-char";
        "l" = "selection-reverse";
        "v" = "selection-toggle";
        "w" = "move-to-next-word";
        "h" = "yank selection";
        "{" = "move-to-end-of-prev-block";
        "}" = "move-to-end-of-next-block";
      };
      command = {
        "<Alt-B>" = "rl-backward-word";
        "<Alt-Backspace>" = "rl-backward-kill-word";
        "<Alt-D>" = "rl-kill-word";
        "<Alt-F>" = "rl-forward-word";
        "<Ctrl-?>" = "rl-delete-char";
        "<Ctrl-A>" = "rl-beginning-of-line";
        "<Ctrl-B>" = "rl-backward-char";
        # "<Ctrl-C>" = "completion-item-yank";
        # "<Ctrl-D>" = "completion-item-del";
        "<Ctrl-C>" = "mode-leave";
        "<Ctrl-D>" = "mode-leave";
        "<Ctrl-E>" = "rl-end-of-line";
        "<Ctrl-F>" = "rl-forward-char";
        "<Ctrl-H>" = "rl-backward-delete-char";
        "<Ctrl-K>" = "rl-kill-line";
        "<Ctrl-N>" = "command-history-next";
        "<Ctrl-P>" = "command-history-prev";
        "<Ctrl-Return>" = "command-accept --rapid";
        "<Ctrl-Shift-C>" = "completion-item-yank --sel";
        "<Ctrl-Shift-Tab>" = "completion-item-focus prev-category";
        "<Ctrl-Shift-W>" = "rl-filename-rubout";
        "<Ctrl-Tab>" = "completion-item-focus next-category";
        "<Ctrl-U>" = "rl-unix-line-discard";
        "<Ctrl-W>" = "rl-rubout ' '";
        "<Ctrl-Y>" = "rl-yank";
        "<Down>" = "completion-item-focus --history next";
        "<Escape>" = "mode-leave";
        "<PgDown>" = "completion-item-focus next-page";
        "<PgUp>" = "completion-item-focus prev-page";
        "<Return>" = "command-accept";
        "<Shift-Delete>" = "completion-item-del";
        "<Shift-Tab>" = "completion-item-focus prev";
        "<Tab>" = "completion-item-focus next";
        "<Up>" = "completion-item-focus --history prev";
      };
      hint = {
        "<Ctrl-B>" = "hint all tab-bg";
        "<Ctrl-F>" = "hint links";
        "<Ctrl-R>" = "hint --rapid links tab-bg";
        "<Escape>" = "mode-leave";
        "<Ctrl-c>" = "mode-leave";
        "<Return>" = "hint-follow";
      };
      insert = {
        "<Alt-e>" = "edit-text";
        "<Escape>" = "mode-leave";
        "<Ctrl-c>" = "mode-leave";
        "<Shift-Escape>" = "fake-key <Escape>";
        "<Ctrl-f>" = "fake-key <Right>";
        "<Ctrl-b>" = "fake-key <Left>";
        "<Ctrl-a>" = "fake-key <Home>";
        "<Ctrl-e>" = "fake-key <End>";
        # "<Ctrl-e>" = "insert-text {primary}";
        "<Ctrl-n>" = "fake-key <Down>";
        "<Ctrl-p>" = "fake-key <Up>";
        "<Alt-f>" = "fake-key <Ctrl-Right>";
        "<Alt-b>" = "fake-key <Ctrl-Left>";
        "<Ctrl-d>" = "fake-key <Delete>";
        "<Alt-d>" = "fake-key <Ctrl-Delete>";
        "<Ctrl-w>" = "fake-key <Ctrl-Backspace>";
        "<Ctrl-h>" = "fake-key <Backspace>";
      };
      normal = {
        "'" = "mode-enter jump_mark";
        "+" = "zoom-in";
        "-" = "zoom-out";
        "." = "cmd-repeat-last";
        "/" = "cmd-set-text /";
        ":" = "cmd-set-text :";
        ";I" = "hint images tab";
        ";O" = "hint links fill :open -t -r {hint-url}";
        ";R" = "hint --rapid links window";
        ";Y" = "hint links yank-primary";
        ";b" = "hint all tab-bg";
        ";d" = "hint links download";
        ";f" = "hint all tab-fg";
        ";h" = "hint all hover";
        ";i" = "hint images";
        ";o" = "hint links fill :open {hint-url}";
        ";r" = "hint --rapid links tab-bg";
        ";t" = "hint inputs";
        ";y" = "hint links yank";
        "<Alt-1>" = "tab-focus 1";
        "<Alt-2>" = "tab-focus 2";
        "<Alt-3>" = "tab-focus 3";
        "<Alt-4>" = "tab-focus 4";
        "<Alt-5>" = "tab-focus 5";
        "<Alt-6>" = "tab-focus 6";
        "<Alt-7>" = "tab-focus 7";
        "<Alt-8>" = "tab-focus 8";
        "<Alt-9>" = "tab-focus -1";
        "<Alt-m>" = "tab-mute";
        "<Ctrl-A>" = "navigate increment";
        "<Ctrl-Alt-p>" = "print";
        "<Ctrl-B>" = "scroll-page 0 -1";
        "<Ctrl-D>" = "scroll-page 0 0.5";
        "<Ctrl-F5>" = "reload -f";
        "<Ctrl-F>" = "scroll-page 0 1";
        "<Ctrl-N>" = "open -w";
        "<Ctrl-PgDown>" = "tab-next";
        "<Ctrl-PgUp>" = "tab-prev";
        "<Ctrl-Q>" = "quit";
        "<Ctrl-Return>" = "selection-follow -t";
        "<Ctrl-Shift-N>" = "open -p";
        "<Ctrl-Shift-T>" = "undo";
        "<Ctrl-Shift-Tab>" = "nop";
        "<Ctrl-Shift-W>" = "close";
        "<Ctrl-T>" = "open -t";
        "<Ctrl-Tab>" = "tab-focus last";
        "<Ctrl-U>" = "scroll-page 0 -0.5";
        "<Ctrl-b>" = "mode-enter passthrough";
        "<Ctrl-W>" = "tab-close";
        "<Ctrl-X>" = "navigate decrement";
        "<Ctrl-^>" = "tab-focus last";
        "<Ctrl-h>" = "home";
        "<Ctrl-p>" = "tab-pin";
        "<Ctrl-s>" = "stop";
        "<Escape>" = "clear-keychain ;; search ;; fullscreen --leave";
        "<F11>" = "fullscreen";
        "<F5>" = "reload";
        "<Return>" = "selection-follow";
        "<back>" = "back";
        "<forward>" = "forward";
        "=" = "zoom";
        "?" = "cmd-set-text ?";
        "@" = "macro-run";
        "B" = "cmd-set-text -s :quickmark-load -t";
        "D" = "tab-close -o";
        "F" = "hint all tab";
        "G" = "scroll-to-perc";
        "Y" = "back";
        "N" = "tab-next";
        "E" = "tab-prev";
        "O" = "forward";
        "M" = "bookmark-add";
        "J" = "search-prev";
        "L" = "cmd-set-text -s :open -t";
        "PP" = "open -t -- {primary}";
        "Pp" = "open -t -- {clipboard}";
        "R" = "reload -f";
        "Sb" = "bookmark-list --jump";
        "Sh" = "history";
        "Sq" = "bookmark-list";
        "Ss" = "set";
        "T" = "cmd-set-text -sr :tab-focus";
        "U" = "undo -w";
        "V" = "mode-enter caret ;; selection-toggle --line";
        "ZQ" = "quit";
        "ZZ" = "quit --save";
        "[[" = "navigate prev";
        "]]" = "navigate next";
        "`" = "mode-enter set_mark";
        "ad" = "download-cancel";
        "b" = "cmd-set-text -s :quickmark-load";
        "cd" = "download-clear";
        "co" = "tab-only";
        "d" = "tab-close";
        "f" = "hint";
        "gl" = "edit-url";
        "g$" = "tab-focus -1";
        "g0" = "tab-focus 1";
        "gB" = "cmd-set-text -s :bookmark-load -t";
        "gC" = "tab-clone";
        "gD" = "tab-give";
        "gJ" = "tab-move +";
        "gE" = "tab-move -";
        "gO" = "cmd-set-text :open -t -r {url:pretty}";
        "gU" = "navigate up -t";
        "g^" = "tab-focus 1";
        "ga" = "open -t";
        "gb" = "cmd-set-text -s :bookmark-load";
        "gd" = "download";
        "gf" = "view-source";
        "gg" = "scroll-to-perc 0";
        "gi" = "hint inputs --first";
        "gm" = "tab-move";
        "go" = "cmd-set-text :open {url:pretty}";
        "gt" = "cmd-set-text -s :tab-select";
        "gu" = "navigate up";
        "y" = "scroll left";
        "i" = "mode-enter insert";
        "n" = "scroll down";
        "e" = "scroll up";
        "o" = "scroll right";
        "m" = "quickmark-save";
        "j" = "search-next";
        "l" = "cmd-set-text -s :open";
        "pP" = "open -- {primary}";
        "pp" = "open -- {clipboard}";
        "q" = "macro-record";
        "r" = "reload";
        "sf" = "save";
        "sk" = "cmd-set-text -s :bind";
        "sl" = "cmd-set-text -s :set -t";
        "ss" = "cmd-set-text -s :set";
        "tCH" = "config-cycle -p -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload";
        "tCh" = "config-cycle -p -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload";
        "tCu" = "config-cycle -p -u {url} content.cookies.accept all no-3rdparty never ;; reload";
        "tIH" = "config-cycle -p -u *://*.{url:host}/* content.images ;; reload";
        "tIh" = "config-cycle -p -u *://{url:host}/* content.images ;; reload";
        "tIu" = "config-cycle -p -u {url} content.images ;; reload";
        "tPH" = "config-cycle -p -u *://*.{url:host}/* content.plugins ;; reload";
        "tPh" = "config-cycle -p -u *://{url:host}/* content.plugins ;; reload";
        "tPu" = "config-cycle -p -u {url} content.plugins ;; reload";
        "tSH" = "config-cycle -p -u *://*.{url:host}/* content.javascript.enabled ;; reload";
        "tSh" = "config-cycle -p -u *://{url:host}/* content.javascript.enabled ;; reload";
        "tSu" = "config-cycle -p -u {url} content.javascript.enabled ;; reload";
        "tcH" = "config-cycle -p -t -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload";
        "tch" = "config-cycle -p -t -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload";
        "tcu" = "config-cycle -p -t -u {url} content.cookies.accept all no-3rdparty never ;; reload";
        "th" = "back -t";
        "tiH" = "config-cycle -p -t -u *://*.{url:host}/* content.images ;; reload";
        "tih" = "config-cycle -p -t -u *://{url:host}/* content.images ;; reload";
        "tiu" = "config-cycle -p -t -u {url} content.images ;; reload";
        "tl" = "forward -t";
        "tpH" = "config-cycle -p -t -u *://*.{url:host}/* content.plugins ;; reload";
        "tph" = "config-cycle -p -t -u *://{url:host}/* content.plugins ;; reload";
        "tpu" = "config-cycle -p -t -u {url} content.plugins ;; reload";
        "tsH" = "config-cycle -p -t -u *://*.{url:host}/* content.javascript.enabled ;; reload";
        "tsh" = "config-cycle -p -t -u *://{url:host}/* content.javascript.enabled ;; reload";
        "tsu" = "config-cycle -p -t -u {url} content.javascript.enabled ;; reload";
        "u" = "undo";
        "v" = "mode-enter caret";
        "wB" = "cmd-set-text -s :bookmark-load -w";
        "wIf" = "devtools-focus";
        "wIh" = "devtools left";
        "wIj" = "devtools bottom";
        "wIk" = "devtools top";
        "wIl" = "devtools right";
        "wIw" = "devtools window";
        "wO" = "cmd-set-text :open -w {url:pretty}";
        "wP" = "open -w -- {primary}";
        "wb" = "cmd-set-text -s :quickmark-load -w";
        "wf" = "hint all window";
        "wh" = "back -w";
        "wi" = "devtools";
        "wl" = "forward -w";
        "wo" = "cmd-set-text -s :open -w";
        "wp" = "open -w -- {clipboard}";
        "xO" = "cmd-set-text :open -b -r {url:pretty}";
        "xo" = "cmd-set-text -s :open -b";
        "hD" = "yank domain -s";
        "hM" = "yank inline [{title}]({url}) -s";
        "hP" = "yank pretty-url -s";
        "hT" = "yank title -s";
        "hH" = "yank -s";
        "hd" = "yank domain";
        "hm" = "yank inline [{title}]({url})";
        "hp" = "yank pretty-url";
        "ht" = "yank title";
        "hh" = "yank";
        "{{" = "navigate prev -t";
        "}}" = "navigate next -t";
      };
      passthrough = {
        "<Ctrl-b>" = "mode-leave";
      };
      prompt = {
        "<Alt-B>" = "rl-backward-word";
        "<Alt-Backspace>" = "rl-backward-kill-word";
        "<Alt-D>" = "rl-kill-word";
        "<Alt-E>" = "prompt-fileselect-external";
        "<Alt-F>" = "rl-forward-word";
        "<Alt-Shift-Y>" = "prompt-yank --sel";
        "<Alt-Y>" = "prompt-yank";
        "<Ctrl-?>" = "rl-delete-char";
        "<Ctrl-A>" = "rl-beginning-of-line";
        "<Ctrl-B>" = "rl-backward-char";
        "<Ctrl-E>" = "rl-end-of-line";
        "<Ctrl-F>" = "rl-forward-char";
        "<Ctrl-H>" = "rl-backward-delete-char";
        "<Ctrl-K>" = "rl-kill-line";
        "<Ctrl-P>" = "prompt-open-download --pdfjs";
        "<Ctrl-Shift-W>" = "rl-filename-rubout";
        "<Ctrl-U>" = "rl-unix-line-discard";
        "<Ctrl-W>" = "rl-rubout ' '";
        "<Ctrl-X>" = "prompt-open-download";
        "<Ctrl-Y>" = "rl-yank";
        "<Down>" = "prompt-item-focus next";
        "<Escape>" = "mode-leave";
        "<Return>" = "prompt-accept";
        "<Shift-Tab>" = "prompt-item-focus prev";
        "<Tab>" = "prompt-item-focus next";
        "<Up>" = "prompt-item-focus prev";
      };
      register = {
        "<Escape>" = "mode-leave";
      };
      yesno = {
        "<Alt-Shift-Y>" = "prompt-yank --sel";
        "<Alt-Y>" = "prompt-yank";
        "<Escape>" = "mode-leave";
        "<Return>" = "prompt-accept";
        "N" = "prompt-accept --save no";
        "Y" = "prompt-accept --save yes";
        "n" = "prompt-accept no";
        "y" = "prompt-accept yes";
      };

    };
  };
}
