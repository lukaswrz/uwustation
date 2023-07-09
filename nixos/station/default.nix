{
  imports = [
    ../features/fonts.nix
    ../features/greetd.nix
    ../features/nix.nix
    ../features/opengl.nix
    ../features/openssh.nix
    ../features/pipewire.nix
    ../features/xdg.nix

    ./configuration.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.11";
}
