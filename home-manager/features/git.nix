{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
      color.ui = true;
    };
    lfs.enable = true;
  };
}
