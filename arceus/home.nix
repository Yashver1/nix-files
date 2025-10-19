{
  config,
  pkgs,
  inputs,
  args,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yash";
  home.homeDirectory = "/home/yash";

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
  home.sessionVariables = {
    CC = "gcc";
    CXX = "g++";
  };

  imports = [
    # inputs.nixvim.homeModules.nixvim
    ../terminal/ghostty.nix
    ../terminal/tmux.nix
    ../terminal/zsh.nix
    # ../nvim

  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.nix-vscode-extensions; [
      pkgs.vscode-extensions.vscodevim.vim
      vscode-marketplace.ms-vscode.cpptools
      vscode-marketplace.ms-vscode.cpptools-themes
      vscode-marketplace.ms-vscode.cpptools-extension-pack

    ];

    profiles.default.userSettings = {
      "workbench.sideBar.location" = "right";
      "github.copilot.editor.enableAutoCompletions" = false;
      "vscode-neovim.neovimExecutablePaths.linux" = "/etc/profiles/per-user/yash/bin/nvim";
      "vim.showMarksInGutter" = false;
      "vim.foldfix" = true;
      "vim.surround" = true;
      "vim.easymotion" = true;
      "vim.easymotionKeys" = "asdghklqwertyuiopzxcvbnmfj";
      "vim.leader" = "<space>";

      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          before = [
            ":"
            "w"
            "<CR>"
          ];
          commands = [ "workbench.action.files.save" ];
        }
        {
          before = [
            "<leader>"
            "w"
          ];
          commands = [ "workbench.action.files.save" ];
        }
        {
          before = [
            "<leader>"
            "q"
          ];
          commands = [ "workbench.action.closeWindow" ];
        }

        # FLASH.NVIM (simulated)
        {
          before = [ "s" ];
          after = [
            "<leader>"
            "<leader>"
            "/"
          ];
        }
        {
          before = [ "S" ];
          after = [
            "<leader>"
            "<leader>"
            "<leader>"
            "j"
          ];
        }
      ];

      "vim.normalModeKeyBindings" = [
        # Window nav
        {
          before = [ "<C-h>" ];
          after = [
            "<C-W>"
            "h"
          ];
        }
        {
          before = [ "<C-j>" ];
          after = [
            "<C-W>"
            "j"
          ];
        }
        {
          before = [ "<C-k>" ];
          after = [
            "<C-W>"
            "k"
          ];
        }
        {
          before = [ "<C-l>" ];
          after = [
            "<C-W>"
            "l"
          ];
        }

        # View size
        {
          before = [ "<C-Up>" ];
          commands = [ "workbench.action.increaseViewHeight" ];
        }
        {
          before = [ "<C-Down>" ];
          commands = [ "workbench.action.decreaseViewHeight" ];
        } # fixed: was duplicate <C-Up>
        {
          before = [ "<C-Left>" ];
          commands = [ "workbench.action.decreaseViewWidth" ];
        }
        {
          before = [ "<C-Right>" ];
          commands = [ "workbench.action.increaseViewWidth" ];
        }

        # Move lines
        {
          before = [ "<A-j>" ];
          commands = [ "editor.action.moveLinesDownAction" ];
        }
        {
          before = [ "<A-k>" ];
          commands = [ "editor.action.moveLinesUpAction" ];
        }

        # Buffers
        {
          before = [ "<S-h>" ];
          commands = [ ":bprev" ];
        }
        {
          before = [ "<S-l>" ];
          commands = [ ":bnext" ];
        }
        {
          before = [
            "["
            "b"
          ];
          commands = [ ":bprev" ];
        }
        {
          before = [
            "]"
            "b"
          ];
          commands = [ ":bnext" ];
        }

        # Redraw / reload window
        {
          before = [
            "<leader>"
            "u"
            "r"
          ];
          commands = [ "workbench.action.reloadWindow" ];
        }

        # Search word under cursor
        {
          before = [
            "g"
            "w"
          ];
          after = [ "*" ];
        }

        # Extensions (Lazy surrogate)
        {
          before = [
            "<leader>"
            "l"
          ];
          commands = [ "workbench.view.extensions" ];
        }

        # Files / terminals
        {
          before = [
            "<leader>"
            "f"
            "n"
          ];
          commands = [ "workbench.action.files.newUntitledFile" ];
        }
        {
          before = [
            "<leader>"
            "u"
            "w"
          ];
          commands = [ "editor.action.toggleWordWrap" ];
        }

        # Git views
        {
          before = [
            "<leader>"
            "g"
            "g"
          ];
          commands = [ "workbench.view.scm" ];
        }
        {
          before = [
            "<leader>"
            "g"
            "G"
          ];
          commands = [ "workbench.view.scm" ];
        }

        # Quit all
        {
          before = [
            "<leader>"
            "q"
            "q"
          ];
          commands = [ "workbench.action.quit" ];
        }

        # Terminals
        {
          before = [
            "<leader>"
            "f"
            "t"
          ];
          commands = [ "workbench.action.createTerminalEditor" ];
        }
        {
          before = [
            "<leader>"
            "f"
            "T"
          ];
          commands = [ "workbench.action.createTerminalEditor" ];
        }

        # LSP-ish
        {
          before = [
            "<leader>"
            "c"
            "d"
          ];
          commands = [ "editor.action.showHover" ];
        }
        {
          before = [
            "<leader>"
            "c"
            "l"
          ];
          commands = [ "workbench.action.output.toggleOutput" ];
        }
        {
          before = [
            "g"
            "d"
          ];
          commands = [ "editor.action.revealDefinition" ];
        }
        {
          before = [
            "g"
            "r"
          ];
          commands = [ "editor.action.goToReferences" ];
        }
        {
          before = [
            "g"
            "D"
          ];
          commands = [ "editor.action.revealDeclaration" ];
        }
        {
          before = [
            "g"
            "I"
          ];
          commands = [ "editor.action.goToImplementation" ];
        }
        {
          before = [
            "g"
            "y"
          ];
          commands = [ "editor.action.goToTypeDefinition" ];
        }
        {
          before = [ "K" ];
          commands = [ "editor.action.showHover" ];
        }
        {
          before = [
            "g"
            "K"
          ];
          commands = [ "editor.action.triggerParameterHints" ];
        }
        {
          before = [ "<C-k>" ];
          commands = [ "editor.action.triggerParameterHints" ];
        }
        {
          before = [
            "]"
            "d"
          ];
          commands = [ "editor.action.marker.next" ];
        }
        {
          before = [
            "["
            "d"
          ];
          commands = [ "editor.action.marker.prev" ];
        }
        {
          before = [
            "]"
            "e"
          ];
          commands = [ "editor.action.marker.next" ];
        }
        {
          before = [
            "["
            "e"
          ];
          commands = [ "editor.action.marker.prev" ];
        }
        {
          before = [
            "]"
            "w"
          ];
          commands = [ "editor.action.marker.next" ];
        }
        {
          before = [
            "["
            "w"
          ];
          commands = [ "editor.action.marker.prev" ];
        }
        {
          before = [
            "<leader>"
            "c"
            "f"
          ];
          commands = [ "editor.action.formatDocument" ];
        }
        {
          before = [
            "<leader>"
            "c"
            "a"
          ];
          commands = [ "editor.action.quickFix" ];
        }
        {
          before = [
            "<leader>"
            "c"
            "A"
          ];
          commands = [ "editor.action.quickFix" ];
        }
        {
          before = [
            "<leader>"
            "c"
            "r"
          ];
          commands = [ "editor.action.rename" ];
        }

        # Pin / unpin editors
        {
          before = [
            "<leader>"
            "b"
            "p"
          ];
          commands = [ "workbench.action.pinEditor" ];
        }
        {
          before = [
            "<leader>"
            "b"
            "u"
          ];
          commands = [ "workbench.action.unpinEditor" ];
        }
        {
          before = [
            "<leader>"
            "b"
            "P"
          ];
          commands = [ "workbench.action.closeAllEditors" ];
        }

        # Replace in files
        {
          before = [
            "<leader>"
            "s"
            "r"
          ];
          commands = [ "editor.action.startFindReplaceAction" ];
        }

        # Explorer
        {
          before = [
            "<leader>"
            "fe"
          ];
          commands = [ "workbench.files.action.showActiveFileInExplorer" ];
        }
        {
          before = [
            "<leader>"
            "fE"
          ];
          commands = [ "workbench.explorer.fileView.toggleVisibility" ];
        }
        {
          before = [
            "<leader>"
            "e"
          ];
          commands = [ "workbench.files.action.showActiveFileInExplorer" ];
        }
        {
          before = [
            "<leader>"
            "E"
          ];
          commands = [ "workbench.action.toggleSidebarVisibility" ];
        }

        # Output / Noice-ish
        {
          before = [
            "<leader>"
            "s"
            "n"
            "l"
          ];
          commands = [ "workbench.action.output.toggleOutput" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "n"
            "h"
          ];
          commands = [ "workbench.action.output.toggleOutput" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "n"
            "a"
          ];
          commands = [ "workbench.action.output.toggleOutput" ];
        }

        # Telescope-ish
        {
          before = [
            "<leader>"
            "/"
          ];
          commands = [ "workbench.action.findInFiles" ];
        }
        {
          before = [
            "<leader>"
            "<space>"
          ];
          commands = [ "workbench.action.quickOpen" ];
        }
        {
          before = [
            "<leader>"
            "f"
            "b"
          ];
          commands = [ "workbench.action.quickOpen" ];
        }
        {
          before = [
            "<leader>"
            "f"
            "f"
          ];
          commands = [ "workbench.action.quickOpen" ];
        }
        {
          before = [
            "<leader>"
            "f"
            "F"
          ];
          commands = [ "workbench.action.quickOpen" ];
        }
        {
          before = [
            "<leader>"
            "f"
            "r"
          ];
          commands = [ "workbench.action.quickOpen" ];
        }
        {
          before = [
            "<leader>"
            "f"
            "R"
          ];
          commands = [ "workbench.action.quickOpen" ];
        }
        {
          before = [
            "<leader>"
            "g"
            "c"
          ];
          commands = [ "workbench.view.scm" ];
        }
        {
          before = [
            "<leader>"
            "g"
            "s"
          ];
          commands = [ "workbench.view.scm" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "b"
          ];
          commands = [ "editor.action.startFindReplaceAction" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "C"
          ];
          commands = [ "workbench.action.showCommands" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "d"
          ];
          commands = [ "workbench.actions.view.problems" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "D"
          ];
          commands = [ "workbench.actions.view.problems" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "g"
          ];
          commands = [ "workbench.action.findInFiles" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "G"
          ];
          commands = [ "workbench.action.findInFiles" ];
        }
        {
          before = [
            "<leader>"
            "s"
            "h"
          ];
          commands = [ "workbench.action.openDocumentationUrl" ];
        }

        # Themes
        {
          before = [
            "<leader>"
            "u"
            "C"
          ];
          commands = [ "workbench.action.selectTheme" ];
        }
      ];

      "vim.visualModeKeyBindings" = [
        {
          before = [ "<" ];
          after = [
            "<"
            "g"
            "v"
          ];
        }
        {
          before = [ ">" ];
          after = [
            ">"
            "g"
            "v"
          ];
        }
      ];

      "vim.insertModeKeyBindings" = [ ];

      "editor.lineNumbers" = "relative";

    };

    mutableExtensionsDir = false;

  };

  programs.neovim.enable = true;
  programs.zsh.shellAliases = {
    cppdev = "nix develop /home/yash/Workspace/dev-shells/cpp";
    ll = "lsd -l";
    la = "lsd -la";
    ls = "lsd";
    nb = "sudo nixos-rebuild switch --flake /home/yash/.config/nix/ && git -C /home/yash/.config/nix add . && git -C /home/yash/.config/nix commit -m 'flake update: nixos' && git -C /home/yash/.config/nix push  origin master ";
    ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
  };

  programs.ghostty.settings = {
    command = "zsh";
    # background-opacity = 0.8;
    theme = "GitLab Dark Grey";
    window-decoration = "server";
    gtk-titlebar = false;
    gtk-tabs-location = "hidden";
    window-padding-balance = true;
    window-padding-x = 25;
    window-padding-y = 15;
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
        command = "/home/yash/.nix-profile/bin/cider --disable-features=WaylandFractionalScaleV1 --platform-ozone-hint=wayland";
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
        monospace-font-name = "Inter Variable Medium 11"; # Inter is not monospaced; see note below
      };
      "org/gnome/desktop/wm/preferences" = {
        titlebar-font = "Inter Variable Medium 11";
      };

    };
  };

}
