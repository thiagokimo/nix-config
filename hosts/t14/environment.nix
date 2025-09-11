{pkgs, ...}: {
  environment = {
    variables = {
      XDG_DATA_HOME = "$HOME/.local/share";
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      curl
      git
      vim 
      xdg-utils
      wget
    ];
  };
}
