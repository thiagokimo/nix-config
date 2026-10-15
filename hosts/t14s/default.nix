{
  inputs,
  configVars,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    inputs.pixel-pong.nixosModules.ci-runner
  ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  # CI runner for this repository. A personal-account runner serves a single
  # repository, so the pixel-pong one can't be shared. Same conventions as
  # pixel-pong's ci-runner module: a fine-grained PAT (Administration: read and
  # write on nix-config only) in /etc/github-runner, written root-only with no
  # trailing newline.
  services.github-runners.nix-config = {
    enable = true;
    url = "https://github.com/thiagokimo/nix-config";
    tokenFile = "/etc/github-runner/nix-config.token";
    # The workflow asks for `[self-hosted, t14s]`.
    extraLabels = ["t14s"];
    replace = true;
    extraPackages = with pkgs; [nix git openssh];
    # `nix flake check` fetches the private pixel-pong input over SSH, with a
    # read-only deploy key on pixel-pong. systemd hands the root-only key to
    # the DynamicUser as a credential; git expands the variable in the shell.
    serviceOverrides.LoadCredential = ["pixel-pong-key:/etc/github-runner/pixel-pong-deploy-key"];
    extraEnvironment.GIT_SSH_COMMAND = "ssh -i $CREDENTIALS_DIRECTORY/pixel-pong-key -o IdentitiesOnly=yes -o StrictHostKeyChecking=yes";
  };
  # Same reason as in pixel-pong's module: allowed-users only lists Thiago.
  nix.settings.allowed-users = ["github-runner-nix-config"];
  programs.ssh.knownHosts."github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
}
