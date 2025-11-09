# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager

  ];

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    (final: prev: {
      google-chrome = prev.google-chrome.override {
        commandLineArgs = "--disable-features=GlobalShortcutsPortal";
      };
    })
  ];

  # Fix wakeup
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="usb", ATTRS{idVendor}=="706b", ATTRS{idProduct}=="0011", ATTR{power/wakeup}="enabled"
    ACTION=="add|change", SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c08b", ATTR{power/wakeup}="enabled"
  '';

  systemd.services."systemd-suspend" = {
    serviceConfig = {
      Environment = ''"SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"'';
    };
  };

  systemd.services.deepcool = {
    description = "Enable Deepcool gui";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.deepcool-digital-linux}/bin/deepcool-digital-linux";
      Restart = "always";
    };

  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ZSH
  programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh;

  # LD
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
    wayland
    libxkbcommon

  ];

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_SG.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable Opengl
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  programs.niri.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    modesetting.enable = true;

    powerManagement.enable = true;

    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yash = {
    isNormalUser = true;
    description = "Yashver Shori";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;

  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      "yash" = import ./home.nix;
    };
    backupFileExtension = "backup";

  };

  # Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker = {
    enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wl-clipboard
    libva-utils
    luajitPackages.lua-lsp
    foundry
    telegram-desktop
    lm_sensors
    fancontrol-gui
    jq
    dtc
    perf
    spike
    file
    doxygen
    qemu-user
    nix-prefetch-git
    fd
    ripgrep
    statix
    cpplint
    usbutils
    ttyper
    obsidian
    cmake
    gparted
    kmod
    pciutils
    gptfdisk
    docker
    bitwarden-desktop
    discord-ptb
    tmux
    nixfmt
    fastfetch
    mangohud
    protonup-ng
    fzf
    virtualgl
    gcc
    gnumake
    bzip3
    gzip
    gnutar
    pkg-config
    python3
    ghostty
    google-chrome
    btop
    lsd
    trace-cmd
    zoxide
    git
    lazygit
    gnutar
    curl.dev
    tree-sitter
    nix-search-tv
    ripgrep
    nodejs_24
    libgccjit
    gdb
    unzip
    go
    bear
    deepcool-digital-linux
    man
    man-pages
    man-pages-posix
    neovim
    luajitPackages.luarocks
    elan

    # NIRI pkgs
    swaybg
    inputs.noctalia.packages.${system}.default
    xwayland-satellite

    # GNOME Extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.space-bar
    gnomeExtensions.forge
    gnomeExtensions.just-perfection
    gnomeExtensions.user-themes
    gnomeExtensions.rounded-window-corners-reborn
    gnome-tweaks
    whitesur-gtk-theme
    whitesur-cursors
    whitesur-icon-theme

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
