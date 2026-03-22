#./modules/home-manager/stylix.nix
{ pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  home.packages = with pkgs; [
    jetbrains-mono
    dejavu_fonts
    bibata-cursors
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    rubik
  ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    image = ./../../wallpaper.jpg;

    polarity = "dark";

    cursor = {
      name = "Vimix-cursors";
      package = pkgs.vimix-cursors;
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.rubik;
        name = "Rubik";
      };
      sizes = {
        terminal = 14;
        desktop = 12;
      };
    };

    targets = {
      kitty.enable = true;
      btop.enable = true;
      firefox.enable = true;
      waybar.enable = true;
      vscode.enable = true;
      
    };
  };
  
  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Rubik" ];
      serif = [ "DejaVu Serif" ];
    };
  };
}
