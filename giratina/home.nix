{
  inputs,
  config,
  pkgs,
  ...
}:

{

  imports = [
    ../terminal/zsh.nix
    ../terminal/tmux.nix
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

  home.file.".config/ghostty/config".text = ''
    macos-titlebar-style = hidden
    macos-option-as-alt = true
    theme = Apple Classic
    background-opacity = 0.8
    window-padding-balance = true
    window-padding-x = 25
    window-padding-y = 15
    font-family = "JetBrains Mono SemiBold"
  '';

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

  programs.zsh = {
    shellAliases = {
      l = "lsd -l";
      la = "lsd -la";
      ls = "lsd";
      nb = " git -C /Users/yashver/.config/nix add . && git -C /Users/yashver/.config/nix commit -m 'flake update: nix-darwin (mac-pro)' && git -C /Users/yashver/.config/nix push  origin master && sudo darwin-rebuild switch --flake /Users/yashver/.config/nix/";
    };

    initContent = ''
      # Pyenv
      export PYENV_ROOT="$HOME/.pyenv"
      [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init -)"

      # Zoxide
      # eval "$(zoxide init zsh)"

      # fzf
      source <(fzf --zsh)

      #starship
      eval "$(starship init zsh)"

      # NVM (Homebrew)
      export HOMEBREW_PREFIX="/opt/homebrew"
      export NVM_DIR="$HOME/.nvm"
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
    '';
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
    EDITOR = "neovim";
    VCPKG_ROOT = "$HOME/vcpkg";
    GOOGLE_APPLICATION_CREDENTIALS = "$HOME/Downloads/coin-lol-5015cc7b478d.json";
    FZF_COMPLETION_TRIGGER = "~~";
  };

  programs.tmux.shell = "${pkgs.zsh}/bin/zsh";
  programs.tmux.extraConfig = ''
    set-option -g default-command "/nix/store/d52zb40s3fi49ad26npvwh6gylpwf44x-reattach-to-user-namespace-2.9/bin/reattach-to-user-namespace -l ${pkgs.zsh}/bin/zsh"
  '';

  programs.neovim = {
    enable = true;
  };

  programs.zsh.oh-my-zsh.plugins = [
    "macos"
    "zsh-interactive-cd"
  ];

}
