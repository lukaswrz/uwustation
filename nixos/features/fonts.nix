{ pkgs, ... }: {
  fonts = {
    enableDefaultFonts = true;
    fonts = [
      pkgs.noto-fonts
      pkgs.noto-fonts-extra
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-cjk-serif
      pkgs.noto-fonts-emoji
      (pkgs.nerdfonts.override { fonts = [ "Noto" ]; })
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "Noto Sans Mono" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
