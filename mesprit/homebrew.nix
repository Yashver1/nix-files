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
      "zoxide"
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
    ];

    taps = [
      "nikitabobko/tap"
    ];

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
