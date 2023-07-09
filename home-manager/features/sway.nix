{
  wayland.windowManager.sway = {
    enable = true;

    systemd.enable = true;

    wrapperFeatures = {
      base = true;
      gtk = true;
    };

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export XDG_SESSION_DESKTOP="''${XDG_SESSION_DESKTOP:-sway}"
      export WLR_BACKENDS=headless,libinput
    '';

    config = {
      defaultWorkspace = "workspace number 1";

      window.titlebar = false;
    };
  };
}
