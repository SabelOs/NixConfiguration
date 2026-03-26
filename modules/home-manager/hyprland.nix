#./modules/home-manager/hyprland.nix
{ pkgs, lib, inputs, ...}:
{
    imports = [
        inputs.walker.homeManagerModules.default
    ];
    home.packages = with pkgs; [
        wl-clipboard
        cliphist
        calcurse
    ];

    programs.kitty.enable = true; # required for the default Hyprland config
    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo I use hyprland btw!";
        };
        profileExtra = ''
            if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
                exec start-hyprland
            fi
        '';
    };
    programs.walker = {
        enable = true;
        runAsService = true; # Improves launch speed
    };
    
    programs.elephant = {
        enable = true;
    };

    home.sessionVariables.ELEPHANT_RUN_PATHS = ''
        ${pkgs.coreutils}/bin
        ${pkgs.hyprshutdown}/bin
        ${pkgs.hyprlock}/bin
        ${pkgs.kitty}/bin
        ${pkgs.impala}/bin
        ${pkgs.btop}/bin
    '';
    
    home.file.".config/elephant/config.json".text = ''
        {
        "providers": {
            "runner": false,
            "menus": false
        }
        }
    '';

    wayland.windowManager.hyprland.enable = true;

    # Optional, hint Electron apps to use Wayland:
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    exec-once = [
        "waybar"
        "dunst"
        "udiskie"
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
    ];

    input = {
        kb_layout = "de";
    };

    bind = [
        "$mod ALT, Space, exec, main-menu"
        #programs binds:
        "$mod SHIFT, B, exec, firefox"
        "$mod, Q, exec, kitty"    # open terminal
        "$mod SHIFT, N, exec, code"
        "$mod SHIFT, F, exec, nautilus"
        "$mod, SPACE, exec, walker"
        "$mod SHIFT, M, exec, spotify"
        "$mod SHIFT, G, exec, firefox --new-window https://web.whatsapp.com/"
        "$mod SHIFT ALT, G, exec, firefox --new-tab https://web.whatsapp.com/"
        "$mod SHIFT, H, exec, firefox --new-window https://ha.soeke.net/"
        "$mod ALT, Space, exec, power-menu"
        #close windows
        "$mod, W, killactive"
        "CTRL ALT, DELETE, exec, hyprshutdown --no-exit"
    ];

    monitor = [
        "DP-1, 2560x1440@180, 0x0, 1"
        "HDMI-A-1, 1920x1080@60, 2560x-240, 1, transform, 1"
        "HDMI-A-2, 1920x1080@60, 3640x0, 1"
    ];

    workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
    ];
    windowrule= [
        "border_size 0, match:float 0, match:workspace w[tv1]s[false]"
        "rounding 0, match:float 0, match:workspace w[tv1]s[false]"
        "border_size 0, match:float 0, match:workspace f[1]s[false]"
        "rounding 0, match:float 0, match:workspace f[1]s[false]"
    ];

    bindd = [
        # Control tiling
        "$mod, J, Toggle window split, togglesplit," # dwindle
        "$mod, P, Pseudo window, pseudo," # dwindle
        "$mod SHIFT, V, Toggle window floating/tiling, togglefloating,"
        "SHIFT, F11, Force full screen, fullscreen, 0"
        "ALT, F11, Full width, fullscreen, 1"
        "SUPER, F, Full screen, fullscreen, 0"
        
        # Move focus with SUPER + arrow keys
        "$mod, LEFT, Move focus left, movefocus, l"
        "$mod, RIGHT, Move focus right, movefocus, r"
        "$mod, UP, Move focus up, movefocus, u"
        "$mod, DOWN, Move focus down, movefocus, d"

        # Switch workspaces with SUPER + [0-9]
        "$mod, code:10, Switch to workspace 1, workspace, 1"
        "$mod, code:11, Switch to workspace 2, workspace, 2"
        "$mod, code:12, Switch to workspace 3, workspace, 3"
        "$mod, code:13, Switch to workspace 4, workspace, 4"
        "$mod, code:14, Switch to workspace 5, workspace, 5"
        "$mod, code:15, Switch to workspace 6, workspace, 6"
        "$mod, code:16, Switch to workspace 7, workspace, 7"
        "$mod, code:17, Switch to workspace 8, workspace, 8"
        "$mod, code:18, Switch to workspace 9, workspace, 9"
        "$mod, code:19, Switch to workspace 10, workspace, 10"

        # Move active window to a workspace with SUPER + SHIFT + [0-9]
        "$mod SHIFT, code:10, Move window to workspace 1, movetoworkspace, 1"
        "$mod SHIFT, code:11, Move window to workspace 2, movetoworkspace, 2"
        "$mod SHIFT, code:12, Move window to workspace 3, movetoworkspace, 3"
        "$mod SHIFT, code:13, Move window to workspace 4, movetoworkspace, 4"
        "$mod SHIFT, code:14, Move window to workspace 5, movetoworkspace, 5"
        "$mod SHIFT, code:15, Move window to workspace 6, movetoworkspace, 6"
        "$mod SHIFT, code:16, Move window to workspace 7, movetoworkspace, 7"
        "$mod SHIFT, code:17, Move window to workspace 8, movetoworkspace, 8"
        "$mod SHIFT, code:18, Move window to workspace 9, movetoworkspace, 9"
        "$mod SHIFT, code:19, Move window to workspace 10, movetoworkspace, 10"

        # TAB between workspaces
        "$mod, TAB, Next workspace, workspace, e+1"
        "$mod SHIFT, TAB, Previous workspace, workspace, e-1"
        "$mod CTRL, TAB, Former workspace, workspace, previous"

        # Swap active window with the one next to it with SUPER + SHIFT + arrow keys
        "$mod SHIFT, LEFT, Swap window to the left, swapwindow, l"
        "$mod SHIFT, RIGHT, Swap window to the right, swapwindow, r"
        "$mod SHIFT, UP, Swap window up, swapwindow, u"
        "$mod SHIFT, DOWN, Swap window down, swapwindow, d"

        # Cycle through applications on active workspace
        "ALT, TAB, Cycle to next window, cyclenext"
        "ALT SHIFT, TAB, Cycle to prev window, cyclenext, prev"
        "ALT, TAB, Reveal active window on top, bringactivetotop"
        "ALT SHIFT, TAB, Reveal active window on top, bringactivetotop"

        # Resize active window
        "$mod, code:20, Expand window left, resizeactive, -100 0" # - key
        "$mod, code:21, Shrink window left, resizeactive, 100 0"  # = key
        "$mod SHIFT, code:20, Shrink window up, resizeactive, 0 -100"
        "$mod SHIFT, code:21, Expand window down, resizeactive, 0 100"

        # Scroll through existing workspaces with SUPER + scroll
        "$mod, MOUSE_DOWN, Scroll active workspace forward, workspace, e+1"
        "$mod, MOUSE_UP, Scroll active workspace backward, workspace, e-1"

        # Copy / Paste (not working)
        "$mod, C, Universal copy, sendshortcut, CTRL, Insert,"
        "$mod, V, Universal paste, sendshortcut, SHIFT, Insert,"
        "$mod CTRL, V, Clipboard manager, exec, cliphist list | walker -d"
    ];

    bindmd = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, Move window, movewindow"
        "$mod, mouse:273, Resize window, resizewindow"
    ];
    };
}