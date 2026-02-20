{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    prefix = "C-\\";
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible

      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left 'C-h'
          set -g @vim_navigator_mapping_right 'C-l'
          set -g @vim_navigator_mapping_up 'C-k'
          set -g @vim_navigator_mapping_down 'C-j'
          set -g @vim_navigator_mapping_prev ''''''
        '';
      }

      {
        plugin = minimal-tmux-status;
        extraConfig = ''
          set -g @minimal-tmux-left false
          set -g @minimal-tmux-fg "#000000"
          set -g @minimal-tmux-bg "#d1cecb"
          set -g @minimal-tmux-status "bottom"
        '';
      }

    ];

    extraConfig = ''
      set -g mouse on
      set -g allow-passthrough on
      bind -n M-k resize-pane -U 5
      bind -n M-j resize-pane -D 5
      bind -n M-h resize-pane -L 5
      bind -n M-l resize-pane -R 5
    '';

  };

}
