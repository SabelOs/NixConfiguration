#./modules/nixos/waybar.nix
{ config, pkgs, inputs, ...}:
{
    environment.systemPackages = with pkgs; [
        (pkgs.waybar.overrideAttrs (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"];
          })
        )
        pkgs.dunst
        libnotify
    ];

}