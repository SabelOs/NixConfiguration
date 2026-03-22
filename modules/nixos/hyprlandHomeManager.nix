#./modules/nixos/hyprlandHomeManager.nix
{ pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    # set the flake package
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
  environment.systemPackages = with pkgs; [
    kitty
    git
    nautilus
    btop
    walker
    udiskie
    hyprshutdown
    hyprpaper
    hyprlock
    coreutils
  ];
  services.getty.autologinUser = "soeke";

  #auto mount usb:
  services.udisks2.enable = true;
  services.gvfs.enable = true; # Optional, helps file managers
}