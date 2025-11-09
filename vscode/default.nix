{
  config,
  pkgs,
  inputs,
  args,
  ...
}:
{
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

}
