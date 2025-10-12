{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-\\\\";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      minimal-tmux-status
    ];
    extraConfig = ''
      set -g mouse
      set -g allow-passthrough on
      set -g @minimal-tmux-left false
      set -g @minimal-tmux-fg "#000000"
      set -g @minimal-tmux-bg "#f2ba7b"
      set -g @minimal-tmux-status "bottom"

      set -g @vim_navigator_mapping_left 'C-h'
      set -g @vim_navigator_mapping_right 'C-l'
      set -g @vim_navigator_mapping_up 'C-k'
      set -g @vim_navigator_mapping_down 'C-j'
      set -g @vim_navigator_mapping_prev ''''''

      bind -n M-k resize-pane -U 5
      bind -n M-j resize-pane -D 5
      bind -n M-h resize-pane -L 5
      bind -n M-l resize-pane -R 5
    '';

  };

}
