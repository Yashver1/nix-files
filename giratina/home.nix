{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/.config/nix/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  xdg.configFile = {
    "ghostty/config".source = link "ghostty/config";
    "nvim".source = link "nvim";
    "yabai".source = link "yabai";
    "skhd".source = link "skhd";
    "sketchybar".source = link "sketchybar";
  };


  imports = [
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yashver";
  home.homeDirectory = "/Users/yashver";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    inputs.nixpkgs-nvim.legacyPackages.${pkgs.stdenv.hostPlatform.system}.neovim
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yash/etc/profile.d/hm-session-vars.sh
  #
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.broot = {
    enable = true;
    settings = {
      modal = true;
    };
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

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

    shellAliases = {
      la = "broot -sdph";
      ls = "lsd";
      gnb = " git -C /Users/yashver/.config/nix add . && git -C /Users/yashver/.config/nix commit -m 'flake update: nix-darwin (mac-pro)' && git -C /Users/yashver/.config/nix push  origin master && sudo darwin-rebuild switch --flake /Users/yashver/.config/nix/";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
      nb = "sudo darwin-rebuild switch --flake /Users/yashver/.config/nix/";
    };

    localVariables = {
      ZSH_DISABLE_COMPFIX = "true";
    };

    # zprof.enable = true;

    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        zstyle ':omz:plugins:nvm' lazy yes
        function zvm_config() {
          ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
          ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
          ZVM_SYSTEM_CLIPBOARD_ENABLED=true
          ZVM_VI_HIGHLIGHT_BACKGROUND=white
          ZVM_VI_HIGHLIGHT_BACKGROUND=black
        }
      '')
      ''
      # Pyenv
      export PYENV_ROOT="$HOME/.pyenv"
      [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init -)"

      # Yazi
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d \'\' cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }

      # Zoxide using homebrew opts

      # fzf
      source <(fzf --zsh)

      #starship
      eval "$(starship init zsh)"

      # f*ck
      eval $(thefuck --alias)

      # NVM (Homebrew) [WILL use omz plugin instead]
      # export HOMEBREW_PREFIX="/opt/homebrew"
      # export NVM_DIR="$HOME/.nvm"
      # [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
      # [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
      ''
    ];

    envExtra = ''
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
        "nvm"
        "macos"
        "zsh-interactive-cd"
      ];
      theme = "robbyrussell";
    };
  };

  home.sessionPath = [
    "/usr/local/bin/code"
    "$HOME/.local/bin"
    "$HOME/.avm/bin"
    "/opt/homebrew/bin"
    "$HOME/.deno/env"
    "$HOME/.deno/bin"
    "$HOME/go/bin"
    "$HOME/.spicetify"
    "/Applications/010 Editor.app/Contents/CmdLine"
    "$HOME/.cargo/bin"
    "/opt/homebrew/Cellar/libpq/17.6/bin"
    "$HOME/workspace/dev-envs/rust/codeforces-extractor/result/bin"
    "/Library/TeX/texbin"
    "$HOME/vcpkg"
  ];

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VCPKG_ROOT = "$HOME/vcpkg";
    FZF_COMPLETION_TRIGGER = "~~";
  };

  programs.tmux = {
    enable = true;

    prefix = "C-\\\\";
    sensibleOnTop = true;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      sensible

      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left 'C-h'
          set -g @vim_navigator_mapping_right 'C-l'
          set -g @vim_navigator_mapping_up 'C-k'
          set -g @vim_navigator_mapping_down 'C-j'
          set -g @vim_navigator_prefix_mapping_clear_screen ""
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

      {
        plugin = copycat;
      }

      {
        plugin = yank;
      }

    ];

    extraConfig = ''
      set -g mouse on
      set -g allow-passthrough on
      bind -n M-k resize-pane -U 5
      bind -n M-j resize-pane -D 5
      bind -n M-h resize-pane -L 5
      bind -n M-l resize-pane -R 5
      bind-key Escape copy-mode
      bind -r C-h previous-window
      bind -r C-l next-window
      bind-key L last-window
      setw -g mode-keys vi

      bind-key | split-window -h -c "#{pane_current_path}"
      bind-key _ split-window -v -c "#{pane_current_path}"
    '';

  };

  programs.man.generateCaches = true;
}
