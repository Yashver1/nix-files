{
  config,
  pkgs,
  inputs,
  args,
  lib,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yash";
  home.homeDirectory = "/home/yash";
  imports = [
    inputs.niri.homeModules.niri
    ../terminal/ghostty.nix
    ../terminal/tmux.nix
    ../nixcats
    ../vscode
    ../niri
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
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

  programs.rofi = {
    enable = true;
    theme = "/home/yash/.config/rofi/launchers/type-7/style-7.rasi";
    font = "JetBrainsMono Nerd Font";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    #
    ".config/custom-oh-my-zsh/themes/robbyrussell2.zsh-theme".text = ''
      PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
      PROMPT+=' $(git_prompt_info)'

      # custom nix-shell indication
      if [[ "$IN_NIX_SHELL" == "impure" ]]; then
        RPROMPT="[%F{yellow}nix-shell%f]"
      else
        RPROMPT=""
      fi

      ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
      ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
      ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
      ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
    '';
  };

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
  #
  #

  home.sessionVariables = {
    CC = "${pkgs.gcc}/bin/gcc";
    CXX = "${pkgs.gcc}/bin/g++";
    GDK_GL = "gles";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # XDG options
  xdg = {
    enable = true;
  };

  # Zsh options
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

    initContent = lib.mkOrder 550 ''
      function zvm_config() {
        ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
        ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
        ZVM_SYSTEM_CLIPBOARD_ENABLED=true
        ZVM_VI_HIGHLIGHT_BACKGROUND=white
        ZVM_VI_HIGHLIGHT_BACKGROUND=black
      }

      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d \'\' cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }


      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      source <(fzf --zsh)
    '';

    envExtra = ''
      ZSH_CUSTOM=~/.config/oh-my-zsh
      FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
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
      ];
      theme = "robbyrussell2";
      custom = "/home/yash/.config/custom-oh-my-zsh/";
    };

    shellAliases = {
      cppdev = "nix develop /home/yash/Workspace/dev-shells/cpp";
      ll = "lsd -l";
      la = "lsd -la";
      ls = "lsd";
      nb = "git -C /home/yash/.config/nix add . && git -C /home/yash/.config/nix commit -m 'flake update: nixos' && git -C /home/yash/.config/nix push  origin master && sudo nixos-rebuild switch --flake /home/yash/.config/nix/";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    };

  };

  qt = {
    enable = true;
    # platformTheme.name = "adwaita";

  };

  programs.yazi = {
    enable = true;

  };

  programs.broot = {
    enable = true;
    settings = {
      modal = true;
    };

  };

  programs.ghostty.settings = {
    command = "zsh";
    background-opacity = 0.8;
    background-blur = true;
    theme = "GitLab Dark Grey";
    window-decoration = "server";
    gtk-titlebar = false;
    gtk-tabs-location = "hidden";
    window-padding-balance = true;
    window-padding-x = 25;
    window-padding-y = 15;
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.swaylock = {
    enable = true;
    settings = {
      image = "~/Downloads/wallpapers/minimal_c.png";
      no-unlock-indicator = true;
      indicator-idle-visible = false;
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "gnu";
      };

      modules = [
        "title"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "resolution"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "battery"
        "powerAdapter"
        # "localip"
        # "publicip"
        "date"
        "time"

      ];
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";

    theme = {
      name = "WhiteSur-Dark-solid";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/wm/keybindings" = {
        minimize = [ ];
        switch-to-workspace-left = [
          "<Super>Page_Up"
          "<Super><Alt>Left"
          "<Control><Alt>Left"
          "<Shift><Alt>h"
        ];
        switch-to-workspace-right = [
          "<Super>Page_Down"
          "<Super><Alt>Right"
          "<Control><Alt>Right"
          "<Shift><Alt>l"
        ];

        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];

        switch-to-application-9 = [ ];

        switch-to-workspace-1 = [ "<Shift><Alt>1" ];
        switch-to-workspace-2 = [ "<Shift><Alt>2" ];
        switch-to-workspace-3 = [ "<Shift><Alt>3" ];
        switch-to-workspace-4 = [ "<Shift><Alt>4" ];
        switch-to-workspace-5 = [ "<Shift><Alt>5" ];
        switch-to-workspace-6 = [ "<Shift><Alt>6" ];
        move-to-workspace-1 = [ "<Ctrl><Alt>1" ];
        move-to-workspace-2 = [ "<Ctrl><Alt>2" ];
        move-to-workspace-3 = [ "<Ctrl><Alt>3" ];
        move-to-workspace-4 = [ "<Ctrl><Alt>4" ];
        move-to-workspace-5 = [ "<Ctrl><Alt>5" ];
        move-to-workspace-6 = [ "<Ctrl><Alt>6" ];
        close = [ "<Super>q" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/cider/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty" = {
        name = "Launch Ghostty";
        command = "/etc/profiles/per-user/yash/bin/ghostty";
        binding = "<Super>t";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/cider" = {
        name = "Launch Cider";
        command = "/run/current-system/sw/bin/cider-2 --disable-features=WaylandFractionalScaleV1 --platform-ozone-hint=wayland";
        binding = "<Super>m";
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "WhiteSur-gtk-theme";
      };

      "org/gnome/desktop/interface" = {
        gtk-theme = "WhiteSur-Dark-solid";
        icon-theme = "WhiteSur";
        cursor-theme = "WhiteSur-cursors";
      };

      # "org/gnome/mutter" = {
      #   experimental-features = [ "scale-monitor-framebuffer" ];
      # };
      #
      "org/gnome/mutter" = {
        dynamic-workspaces = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 6;
      };

      "org/gnome/terminal/legacy" = {
        headerbar = false;
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          pkgs.gnomeExtensions.blur-my-shell.extensionUuid
          pkgs.gnomeExtensions.space-bar.extensionUuid
          pkgs.gnomeExtensions.forge.extensionUuid
          pkgs.gnomeExtensions.just-perfection.extensionUuid
          pkgs.gnomeExtensions.user-themes.extensionUuid
          pkgs.gnomeExtensions.rounded-window-corners-reborn.extensionUuid

        ];
      };

      "org/gnome/desktop/interface" = {
        font-name = "Inter Variable Medium 11";
        document-font-name = "Inter Variable Medium 11";
        monospace-font-name = "Inter Variable Medium 11";
      };
      "org/gnome/desktop/wm/preferences" = {
        titlebar-font = "Inter Variable Medium 11";
      };

    };
  };

}
