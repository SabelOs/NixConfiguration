{ pkgs, ... }:

{
  home.packages = with pkgs; [

    ################################
    # POWER MENU (you already had)
    ################################
    (pkgs.writeShellScriptBin "power-menu" ''
      options="  Lock\n󰜉  Restart\n󰐥  Shutdown"

      choice=$(echo -e "$options" | walker --dmenu -p "System")

      case "$choice" in
        *Lock*) hyprlock ;;
        *Restart*) hyprshutdown -t 'Restarting...' --post-cmd 'reboot' ;;
        *Shutdown*) hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0' ;;
      esac
    '')

    ################################
    # NIX MENU
    ################################
    (pkgs.writeShellScriptBin "nix-menu" ''
      options="󰒓  Test\n󰑓  Switch\n󰍉  Search"

      choice=$(echo -e "$options" | walker --dmenu -p "Nix")

      case "$choice" in
        *Test*)
          kitty -e bash -c "sudo nixos-rebuild test --flake .#soekeHypr; read"
          ;;
        *Switch*)
          kitty -e bash -c "sudo nixos-rebuild switch --flake .#soekeHypr; read"
          ;;
        *Search*)
          # clean + non-hacky: just open interactive search
          kitty -e nix search nixpkgs
          ;;
      esac
    '')

    ################################
    # UTILITY MENU
    ################################
    (pkgs.writeShellScriptBin "utility-menu" ''
      options="  Bluetooth\n󰍛  btop\n󰄛  Calcurse\n󰀻  Audio Mixer"

      choice=$(echo -e "$options" | walker --dmenu -p "Utilities")

      case "$choice" in
        *Bluetooth*) kitty -e bluetui ;;
        *btop*) kitty -e btop ;;
        *Calcurse*) kitty -e calcurse ;;
        *Audio*) kitty -e wiremix ;;
      esac
    '')

    ################################
    # MEDIA MENU
    ################################
    (pkgs.writeShellScriptBin "media-menu" ''
      options="  YouTube\n  WhatsApp\n󰭹  Reddit\n  GitHub"

      choice=$(echo -e "$options" | walker --dmenu -p "Media")

      case "$choice" in
        *YouTube*) firefox --new-window https://youtube.com ;;
        *WhatsApp*) firefox --new-window https://web.whatsapp.com ;;
        *Reddit*) firefox --new-window https://reddit.com ;;
        *GitHub*) firefox --new-window https://github.com ;;
      esac
    '')

    ################################
    # MAIN HUB MENU
    ################################
    (pkgs.writeShellScriptBin "main-menu" ''
      options="󰣇  Apps\n  Nix\n󰒓  Utilities\n󰝚  Media\n  Power"

      choice=$(echo -e "$options" | walker --dmenu -p "Menu")

      case "$choice" in
        *Apps*)
          # fallback to normal walker launcher
          walker
          ;;
        *Nix*) nix-menu ;;
        *Utilities*) utility-menu ;;
        *Media*) media-menu ;;
        *Power*) power-menu ;;
        *)
          # VERY IMPORTANT: fallback → treat input as app search
          walker --dmenu <<< "$choice"
          ;;
      esac
    '')
  ];
}