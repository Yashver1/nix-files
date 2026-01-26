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

  services.udev.packages = [
    pkgs.dolphin-emu
  ];

  services.udev.extraRules = ''
    # Fix wakeup
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
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;

  services.displayManager.ly.enable = true;

  #Enable Opengl
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  hardware.i2c.enable = true;

  #Bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
      };
    };

  };

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJGj+VDfDRSc49RFeHdQFsEQJ0XHc4bSV0k6AfCEb4MQ yashver"
    ];
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
    # backupFileExtension = "bakup";
    # backupFileExtension = "back";
    # backupFileExtension = "baks";
    # backupFileExtension = "bakss";
    backupFileExtension = "baksss";
  };

  # Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.gpu-screen-recorder.enable = true;

  # Install firefox.
  programs.firefox.enable = true;
  programs.firefox.nativeMessagingHosts.packages = with pkgs; [ uget-integrator ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #virtualisation

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "yash" ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "ghostty.desktop"
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lsof
    dnsmasq
    virt-viewer
    swtpm
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    libreoffice-qt-fresh
    cava
    adwaita-fonts
    adwaita-qt
    adwaita-icon-theme
    jdk
    pavucontrol
    pamixer
    azahar
    vulkan-tools
    lsfg-vk-ui
    lsfg-vk
    dolphin-emu
    anki-bin
    nautilus
    ddcutil
    uget
    shadps4
    poppler
    resvg
    osu-lazer
    bpftrace
    lua
    insomnia
    cider-2
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
    ffmpeg
    nix-prefetch-git
    fd
    ripgrep
    statix
    cpplint
    usbutils
    cppman
    emscripten
    omnissa-horizon-client
    aider-chat-full
    openssl
    ttyper
    obsidian
    cmake
    gparted
    kmod
    pciutils
    gptfdisk
    docker
    bitwarden-desktop
    betterdiscordctl
    discord
    tmux
    nitch
    nixfmt
    fastfetch
    mangohud
    protonup-ng
    fzf
    gpu-screen-recorder-gtk
    gpu-screen-recorder

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
    luajitPackages.luarocks
    elan
    uv
    zmkBATx
    simpleBluez
    bluez
    bluez-tools
    zapzap

    # NIRI pkgs
    swaybg
    inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
    xwayland-satellite

    # GNOME Extensions
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.space-bar
    # gnomeExtensions.forge
    # gnomeExtensions.just-perfection
    # gnomeExtensions.user-themes
    # gnomeExtensions.rounded-window-corners-reborn
    # gnome-tweaks
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
  #
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = [ "yash" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

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
  system.stateVersion = "25.05"; # Did you read the comment?appstream

}
