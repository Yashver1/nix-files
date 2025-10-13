{ ... }:
{
  programs.nixvim = {
    enable = true;
    imports = [
      ./coding
    ];
  };

}
