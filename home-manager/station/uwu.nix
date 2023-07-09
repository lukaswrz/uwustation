{ inputs, pkgs, ... }: {
  imports = [
    ../features/bash.nix
    ../features/bottom.nix
    ../features/git.nix
    ../features/helix.nix
    ../features/home-manager.nix
    ../features/readline.nix
    ../features/sway.nix
  ];

  home = {
    username = "uwu";
    packages = [
      pkgs.retroarchFull
      pkgs.pulseaudio
      pkgs.curl
      pkgs.neovim
    ];
  };

  wayland.windowManager.sway = {
    config = {
      input."type:keyboard".xkb_layout = "us";

      output.HEADLESS-1 = {
        mode = "1920x1080@60Hz";
        position = "0,0";
      };

      workspaceOutputAssign = [
        {
          output = "HEADLESS-1";
          workspace = "number 1";
        }
      ];

      bars = [ ];

      window.border = 0;

      seat."*" = {
        hide_cursor = "5000";
      };
    };
  };

  home.file."retroarch.png".source = ./retroarch.png;
}
