{
  homebrew = {
    enable = true;

    brews = [
      "lazydocker"
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
      "qemu"
      "riscv-pk"
      "riscv-tools"
      "riscv-gnu-toolchain"
      "riscv-isa-sim"
      "nixfmt"
      "postgresql@18"
      "gpg"
      "poetry"
      "pipx"
      "rustup"
      "nasm"
    ];

    casks = [

      "bettertouchtool"
      "hammerspoon"
      "postman"
      "slack"
      "ghostty"
      "aerospace"
      "dbeaver-community"
      "font-fira-code"
      "font-hack-nerd-font"
      "hopper-disassembler"
      "ngrok"
      "pgadmin4"
    ];

    taps = [
      "riscv-software-src/riscv"
      "nikitabobko/tap"

    ];

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
