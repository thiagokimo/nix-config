{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./themes.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nerd-fonts.jetbrains-mono # font
      stylua # lua formatter
    ];
    extraConfigLua = ''
      local diagnostics_active = true

      function _G.toggleDiagnostics()
        diagnostics_active = not diagnostics_active

        if diagnostics_active then
          vim.diagnostic.enable(0)
        else
          vim.diagnostic.disable(0)
        end
      end
    '';
  };
}
