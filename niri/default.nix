{
  pkgs,
  ...
}:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      outputs."eDP-1".scale = 1.0;
    };
  };
}
