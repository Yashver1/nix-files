{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 1000000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];

    initContent = lib.mkOrder 500 ''
      function zvm_config() {
        ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
        ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
        ZVM_SYSTEM_CLIPBOARD_ENABLED=true

      }
    '';

    envExtra = ''
      ZSH_CUSTOM=~/.config/oh-my-zsh
      KEYTIMEOUT=1
      # VI_MODE_SET_CURSOR=true
      # VI_MODE_CURSOR_NORMAL=2
      # VI_MODE_CURSOR_VISUAL=2
      # VI_MODE_CURSOR_INSERT=6
      # VI_MODE_CURSOR_OPPEND=6
      # MODE_INDICATOR=" "
      # INSERT_MODE_INDICATOR=" "
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
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        # "vi-mode"
      ];
      theme = "robbyrussell2";
      custom = "/home/yash/.config/custom-oh-my-zsh/";
    };
  };

}
