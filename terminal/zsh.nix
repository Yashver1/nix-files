{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      cppdev = "nix develop /home/yash/Workspace/dev-shells/cpp";
      ll = "lsd -l";
      la = "lsd -la";
      ls = "lsd";
      nb = "git -C /home/yash/.config/nix add . && git -C /home/yash/.config/nix commit -m 'flake update: nixos' && git -C /home/yash/.config/nix push  origin master && sudo nixos-rebuild switch --flake /home/yash/.config/nix/ ";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    };

    history.size = 1000000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];

    envExtra = ''
      ZSH_CUSTOM=~/.config/oh-my-zsh
      KEYTIMEOUT=1
      VI_MODE_SET_CURSOR=true
      VI_MODE_CURSOR_NORMAL=2
      VI_MODE_CURSOR_VISUAL=2
      VI_MODE_CURSOR_INSERT=6
      VI_MODE_CURSOR_OPPEND=6
      MODE_INDICATOR=" "
      INSERT_MODE_INDICATOR=" "
    '';

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "vi-mode"
      ];
      theme = "robbyrussell";
    };
  };

}
