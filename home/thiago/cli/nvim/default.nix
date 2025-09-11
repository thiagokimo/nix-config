{inputs, pkgs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nerd-fonts.jetbrains-mono
      stylua
    ];

    colorschemes.gruvbox.enable = true;
  };
}
