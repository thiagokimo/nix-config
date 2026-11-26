# painel, my terminal home screen (github.com/thiagokimo/nix-painel): the
# tools, scripts, projects and links I use every day, in one place. Run
# `painel`, type a name or alias and press enter.
#
# Its config is generated here: Stylix colors with the host's accent, like
# kitty and the prompt. Tools and scripts run by name from PATH, as the
# features that install them (cli, desktop, ai, firmware) put them there.
{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (config) vars;
  inherit (import ../lib/colors.nix) mix;

  # The host that lists a feature, to link to the service it runs.
  hostWith = feature: lib.head (lib.attrNames (lib.filterAttrs (_: host: lib.elem feature host.features) vars.hosts));
in {
  flake.modules.homeManager.painel = {config, ...}: let
    c = config.lib.stylix.colors;
    hex = name: "#${c.${name}}";
  in {
    imports = [inputs.painel.homeManagerModules.default];

    programs.painel = {
      enable = true;
      settings = {
        user = vars.user.name;
        host = config.host.name;

        theme = {
          fg = hex "base05";
          fg_bright = hex "base07";
          muted = "#${mix c.base03 c.base04 0.4}";
          border = hex "base02";
          selection = hex "base01";
          accent = hex vars.hosts.${config.host.name}.accent;
          red = hex "base08";
          orange = hex "base09";
          yellow = hex "base0A";
          green = hex "base0B";
          aqua = hex "base0C";
          blue = hex "base0D";
        };

        tools = [
          {
            name = "nvim";
            alias = "v";
            desc = "editor";
            cmd = ["nvim"];
          }
          {
            name = "yazi";
            alias = "y";
            desc = "files";
            cmd = ["yazi"];
          }
          {
            name = "btop";
            alias = "top";
            desc = "processes";
            cmd = ["btop"];
          }
          {
            name = "kew";
            alias = "m";
            desc = "music";
            cmd = ["kew"];
          }
          {
            name = "claude";
            alias = "c";
            desc = "Claude Code";
            cmd = ["claude"];
          }
        ];

        # From features/firmware/update-script.nix. They pause at the end so
        # their output can be read before painel comes back.
        scripts = [
          {
            name = "sysup";
            alias = "su";
            desc = "pull, rebuild, firmware";
            cmd = ["sysup"];
            pause = true;
          }
          {
            name = "sysup-update";
            alias = "suu";
            desc = "flakeup first, then sysup";
            cmd = ["sysup" "--update"];
            pause = true;
          }
          {
            name = "flakeup";
            alias = "fu";
            desc = "update the inputs through a PR";
            cmd = ["flakeup"];
            pause = true;
          }
          {
            name = "firmware";
            alias = "fw";
            desc = "check for firmware updates";
            cmd = ["firmware-update" "--check"];
            pause = true;
          }
        ];

        projects = {
          roots = ["~/Projects"];
          extra = [vars.user.configDir];
          open = ["nvim" "."];
          alt = ["yazi"];
        };

        links = [
          {
            name = "dev";
            links = [
              {
                name = "github";
                alias = "gh";
                url = "https://github.com";
              }
              {
                name = "repo";
                alias = "r";
                url = "https://github.com/thiagokimo/nix-config";
              }
              {
                name = "packages";
                alias = "np";
                url = "https://search.nixos.org/packages";
              }
              {
                name = "options";
                alias = "no";
                url = "https://search.nixos.org/options";
              }
              {
                name = "home-manager";
                alias = "hm";
                url = "https://home-manager-options.extranix.com";
              }
              {
                name = "noogle";
                alias = "ng";
                url = "https://noogle.dev";
              }
            ];
          }
          {
            # Over the tailnet, by MagicDNS name. Ports from jellyfin.nix and
            # monitoring.nix.
            name = "home";
            links = [
              {
                name = "jellyfin";
                alias = "j";
                url = "http://${hostWith "jellyfin"}:8096";
              }
              {
                name = "status";
                alias = "st";
                url = "http://${hostWith "monitoring"}:8080";
              }
              {
                name = "ntfy";
                alias = "nt";
                url = "http://${hostWith "monitoring"}:2586";
              }
            ];
          }
          {
            name = "web";
            links = [
              {
                name = "youtube";
                alias = "yt";
                url = "https://www.youtube.com";
              }
              {
                name = "reddit";
                alias = "rd";
                url = "https://www.reddit.com";
              }
              {
                name = "gmail";
                alias = "gm";
                url = "https://mail.google.com";
              }
            ];
          }
        ];
      };
    };
  };
}
