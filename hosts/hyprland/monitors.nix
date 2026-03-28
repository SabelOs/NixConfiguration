{ pkgs, lib, inputs, ...}:
{
    wayland.windowManager.hyprland.settings = {
      monitor = [
          "DP-1, 2560x1440@180, 0x0, 1"
          "HDMI-A-1, 1920x1080@60, 2560x-240, 1, transform, 1"
          "HDMI-A-2, 1920x1080@60, 3640x0, 1"
      ];
    };
}