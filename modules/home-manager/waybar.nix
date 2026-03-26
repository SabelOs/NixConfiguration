#./modules/home-manager/waybar.nix
{ pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
  };

  services.dunst.enable = true;

 home.packages = with pkgs; [
  libnotify
  hyprshutdown
  hyprlock
  ];

  #this part is almost completely copied from saneAspect's YT video: https://www.youtube.com/watch?v=w1VZJX4JAdE&t 
  programs.waybar.settings.main = {
    position = "top";
    "margin-top" = 18;
    "margin-bottom" = 9;

    "modules-center" = [
      "custom/power"
      "clock"
      "hyprland/workspaces"
      "bluetooth"
      "network"
      "pulseaudio"
      "cpu"
      "battery"
      "tray"
    ];
    
    "custom/power" = {
      "format" = "";
      "tooltip" = false;
      "on-click" = "power-menu";
    };
    
    "hyprland/workspaces" = {
      format = "{icon}";
      "format-icons" = {
        "1" = "1";
        "2" = "2";
        "3" = "π";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "10";
        default = "";
        urgent = "•";
      };
      "persistent-workspaces" = {
        "1"= [];
        "2"= [];
        "3"= [];
        "4"= [];
        "5"= [];
      };
      "on-click" = "activate";
      "on-scroll-up" = "hyprctl dispatch workspace e+1";
      "on-scroll-down" = "hyprctl dispatch workspace e-1";
    };

    "bluetooth"= {
      "format"= "";
      "format-off"= "󰂲";
      "format-disabled"= "󰂲";
      "format-connected"= "󰂱";
      "format-no-controller"= "";
      "tooltip-format"= "Devices connected: {num_connections}";
      "on-click"= "kitty -e bluetui";
    };
    
    "network" = {
      "format-icons" = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
      "format" = "{icon}";
      "format-wifi" = "{icon}";
      "format-ethernet" = "󰀂";
      "format-disconnected" = "󰤮";
      "tooltip-format-wifi" = "{essid} ({signalStrength}%)";
      "tooltip-format-ethernet" = "Ethernet";
      "tooltip-format-disconnected" = "Disconnected";
      "interval" = 3;
      "on-click" = "kitty -e impala";
    };
    
    "pulseaudio" = {
      "format" = "{icon}";
      "format-muted" = "";
      "format-icons" = {
        "default" = [ "" "" "" ];
      };
      "scroll-step" = 5;
      "on-click" = "kitty -e wiremix";
      "on-click-right" = "exec pavucontrol";
    };
    
    "cpu" = {
      "interval" = 5;
      "format" = "󰍛";
      "on-click" = "kitty -e btop";
    };
    
    "battery" = {
      "format" = "{capacity}% {icon}";
      "format-charging" = "󰂄";
      "format-discharging" = "󰁿";
      "format-full" = "󰁹";

      "states" = {
        "warning" = 20;
        "critical" = 10;
      };
    };
    
    "clock" = {
      "format" = "{:%H:%M}";
      "format-alt" = "{:%A %d %B %Y}";
      "tooltip" = false;
      "on-click-right" = "kitty -e calcurse";
    };


  };

  programs.waybar.style =''
    @define-color bg0 #0d0b0b;
    @define-color bg-hover #3c3836;
    @define-color numbers-inactive #C9CCDE;
    @define-color fg0 #E9E8EF;
    * {
      border: none;
      border-radius: 0px;
      font-family: "Rubik", "JetBrainsMono Nerd Font", "Noto Sans CJK JP", "Noto Sans CJK KR";
      font-size: 16px;
      min-height: 0;
      padding: 0;
      margin: 0;
    }
    .modules-center {
      background: @bg0;
      padding: 6px 12px;
      border-radius: 28px;
      box-shadow: 0 4px 12px #282828;
    }
    window#waybar {
      background: transparent;
    }
    #workspaces {
      background: transparent;
      padding: 0;
      margin: 0 10px 0 10px;
      border: none;
      box-shadow: none;
    }

    #workspaces button {
      padding: 0px 6px;
      margin: 0px 2px;
      border-radius: 16px;
      color: @numbers-inactive;
      background: transparent;
      transition: all 0.3s ease-in-out;
    }

    #workspaces button.active {
      background: linear-gradient(135deg, @fg0 0%, #88c0d0 50%, #13345c 100%);
      color: @bg-hover;
      min-width: 40px;
      transition: all 0.3s ease-in-out;
    }

    #workspaces button:hover {
      background-color: @bg0;
      color: @fg0;
    }

    #workspaces button.urgent {
      background-color: #fb4934;
      color: @bg-hover;
    }
    
    #custom-power {
      margin-right: 12px;
      color: @fg0;
    }

    #custom-power:hover {
      background-color: #fb4934;
      color: #1d2021;
      border-radius: 12px;
      padding: 2px 6px;
    }

    #clock {
      color: @fg0;
      margin: 0;
    }

    /* spacing for system icons */
    #bluetooth { color: @fg0; }
    #network { color: @fg0; margin-left: 12px; }
    #pulseaudio { color: @fg0; margin-left: 12px; }
    #cpu { color: @fg0; margin-left: 12px; }
    '';
    
}