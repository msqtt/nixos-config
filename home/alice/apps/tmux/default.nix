{ config, pkgs, ... }:
let 
  plugins  = pkgs.tmuxPlugins // pkgs.callPackage ./net-speed-fix.nix {};
in
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    aggressiveResize = true;
    plugins = with plugins; [
      net-speed
      battery
    ];

    extraConfig = ''
      # general
      set -g prefix C-s
      setw -g xterm-keys on
      set -s escape-time 0
      set -sg repeat-time 300
      set -s focus-events on
      set -g mouse on
      set -sg exit-empty on



      set -g default-terminal "screen-256color"
      set -q -g status-utf8 on
      setw -q -g utf8 on

      set -g visual-activity off
      setw -g monitor-activity off
      setw -g monitor-bell off

      set -g history-limit 10000

      # vim mode

      # setw -g mode-keys vi
      bind -n M-v copy-mode

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y send-keys -X cursor-left
      bind -T copy-mode-vi o send-keys -X cursor-right
      bind -T copy-mode-vi e send-keys -X cursor-up
      bind -T copy-mode-vi n send-keys -X cursor-down
      bind -T copy-mode-vi k send-keys -X next-word-end
      bind -T copy-mode-vi E send-keys -N 5 -X cursor-up
      bind -T copy-mode-vi N send-keys -N 5 -X cursor-down
      bind -T copy-mode-vi Y send-keys -X start-of-line
      bind -T copy-mode-vi I send-keys -X end-of-line
      bind -T copy-mode-vi H send-keys -X copy-end-of-line
      bind -T copy-mode-vi h send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi j send-keys -X search-again


      set -g status-fg black
      set -g status-bg magenta
      set-option -g pane-border-style "fg=black,bg=black" 
      set-option -g pane-active-border-style "fg=magenta,bg=black"

      # plugin
      set -g @download_speed_format '%%s'
      set -g @upload_speed_format '%%s'

      set -g status-left-length 100
      set -g status-left "[#S] | D:#{download_speed} U:#{upload_speed} |"

      set -g status-right 'Batt: #{battery_icon_status} #{battery_percentage} #{battery_remain} | %H:%M '

      run-shell ${plugins.battery}/share/tmux-plugins/battery/battery.tmux
      run-shell ${plugins.net-speed}/share/tmux-plugins/net-speed/net-speed.tmux
    '';
  };
}
