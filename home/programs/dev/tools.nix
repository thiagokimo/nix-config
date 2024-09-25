{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains-toolbox
    vscode
    postman
    jq
  ];
}
