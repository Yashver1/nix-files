{
  homebrew = {
    enable = true;

    brews = [
      "rust-analyzer"
      "libpq"
      "ffmpeg"
      "uv"
      "nvm"
      "automake"
      "boost"
      "catch2"
      "cmake"
      "cppcheck"
      "dos2unix"
      "fd"
      "ffuf"
      "fmt"
      "fswatch"
      "gh"
      "git"
      "go"
      "gobuster"
      "imagemagick"
      "inetutils"
      "just"
      "lsd"
      "lua-language-server"
      "luarocks"
      "make"
      "mas"
      "ninja"
      "php"
      "pnpm"
      "protobuf"
      "pyenv"
      "r"
      "gcc"
      "radare2"
      "ripgrep"
      "rp"
      "wireshark"
      "yazi"
      "fzf"
      "unixodbc"
      "openssl"
      "mysql"
      "zstd"
      "zlib"
      "pkg-config"
      "lazygit"
      "ruby"
      "pipx"

      "tailscale"
      "llvm@20"
    ];

    casks = [
      "slack"
      "ghostty"
      "aerospace"
      "dbeaver-community"
      "font-fira-code"
      "font-hack-nerd-font"
      "hopper-disassembler"
      "mactex"
      "ngrok"
      "pgadmin4"
      "playcover-community"
      "stats"
      "geekbench"
      "tailscale-app"
    ];

    masApps = {
      "Amphetamine" = 937984704;
      "Dynamic Wallpaper" = 1453504509;
      "GarageBand" = 682658836;
      "Goodnotes" = 1444383602;
      "iMovie" = 408981434;
      "Keynote" = 409183694;
      "Klack" = 6446206067;
      "Microsoft Excel" = 462058435;
      "Microsoft Word" = 462054704;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "PDFgear" = 6469021132;
      "SiteSucker" = 442168834;
      "Telegram" = 747648890;
      "WeChat" = 836500024;
      "Wireless@SGx" = 1449928544;
      "Yoink" = 457622435;
    };

    taps = [
      "nikitabobko/tap"
    ];

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
