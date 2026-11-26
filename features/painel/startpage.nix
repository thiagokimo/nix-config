# painel in the browser: Chrome's startup, home and new tab page looks and
# works like painel (features/painel/painel.nix), from the same settings: the
# same panels, prompt and keys, the same tools, scripts, links and colors.
#
# The page lives in ~/.local/share/painel-startpage. index.html, style.css and
# startpage.js are static; config.js and theme.css come from painel's settings;
# projects.js is the project list, written by a user service when a project
# folder appears or goes, at login, and every 10 minutes for the branches.
#
# Tools, scripts and projects are launch: links. Chrome hands them to
# xdg-open, which runs startpage-launch: it opens them in kitty, and only runs
# what painel's settings list. A project is looked up by name among the
# folders painel would show, so a link can't point it anywhere else. Chrome
# opens launch: links from this page without asking; any other page asks.
{
  config,
  lib,
  ...
}: let
  inherit (config) vars;

  pageDir = "${vars.user.home}/.local/share/painel-startpage";
  pageUrl = "file://${pageDir}/index.html";
in {
  # Chrome reads these policies from /etc/opt/chrome/policies/managed.
  flake.modules.nixos.painel.programs.chromium = {
    enable = true;
    extraOpts = {
      RestoreOnStartup = 4; # open the startup URLs
      RestoreOnStartupURLs = [pageUrl];
      HomepageLocation = pageUrl;
      HomepageIsNewTabPage = false;
      ShowHomeButton = true;
      NewTabPageLocation = pageUrl;
      AutoLaunchProtocolsFromOrigins = [
        {
          protocol = "launch";
          allowed_origins = ["file://*"];
        }
      ];
    };
  };

  flake.modules.homeManager.painel = {
    config,
    pkgs,
    ...
  }: let
    settings = config.programs.painel.settings;
    inherit (settings) projects;
    c = config.lib.stylix.colors;

    home = path: lib.replaceStrings ["~/"] ["${vars.user.home}/"] path;
    kitty = "${pkgs.kitty}/bin/kitty";

    # The same shell painel wraps a paused command in.
    pauseScript = ''"$@"; s=$?; printf '\n\033[2m%s exited with %d, press enter to go back\033[0m' "$0" "$s"; read -r _'';
    argv = entry:
      if entry.pause or false
      then ["sh" "-c" pauseScript entry.name] ++ entry.cmd
      else entry.cmd;

    # Lists the project folders as painel finds them: the extra folders, then
    # each root's visible subfolders by name, each once, with its branch.
    listProjects = pkgs.writeShellApplication {
      name = "painel-projects";
      runtimeInputs = [pkgs.coreutils pkgs.findutils pkgs.git pkgs.jq];
      text = ''
        declare -A seen
        add() {
          local dir=''${1%/}
          if [ ! -d "$dir" ] || [ -n "''${seen[$dir]:-}" ]; then
            return 0
          fi
          seen[$dir]=1
          local branch=""
          if [ -e "$dir/.git" ]; then
            branch=$(git -C "$dir" symbolic-ref --quiet --short HEAD 2>/dev/null ||
              git -C "$dir" rev-parse --short HEAD 2>/dev/null || true)
          fi
          jq -n --arg name "''${dir##*/}" --arg path "$dir" --arg branch "$branch" '{$name, $path, $branch}'
        }
        extra=(${lib.escapeShellArgs (map home projects.extra)})
        roots=(${lib.escapeShellArgs (map home projects.roots)})
        {
          for dir in "''${extra[@]}"; do
            add "$dir"
          done
          for root in "''${roots[@]}"; do
            [ -d "$root" ] || continue
            while IFS= read -r -d "" dir; do
              add "$dir"
            done < <(find "$root" -mindepth 1 -maxdepth 1 -type d ! -name '.*' -print0 | sort -zf)
          done
        } | jq -s .
      '';
    };

    writeProjects = pkgs.writeShellApplication {
      name = "painel-startpage-projects";
      runtimeInputs = [pkgs.coreutils listProjects];
      text = ''
        out=${pageDir}/projects.js
        mkdir -p ${pageDir}
        {
          printf 'window.PAINEL_PROJECTS = '
          painel-projects
          printf ';\n'
        } > "$out.tmp"
        mv "$out.tmp" "$out"
      '';
    };

    caseArm = pattern: command: ''
      ${lib.escapeShellArg pattern}) run ${command} ;;
    '';
    inKitty = args: "${kitty} ${lib.escapeShellArgs args}";

    launcher = pkgs.writeShellApplication {
      name = "startpage-launch";
      runtimeInputs = [pkgs.jq pkgs.util-linux listProjects];
      # The pause script is single-quoted on purpose: it expands in the sh
      # it's handed to.
      excludeShellChecks = ["SC2016"];
      text = ''
        # launch:tool/nvim, launch:script/sysup, launch:project/nix-config/claude,
        # launch:project/nix-config/alt and launch:painel, with or without //.
        url=''${1#launch:}
        url=''${url#//}
        url=''${url%/}
        IFS=/ read -r kind name opener rest <<< "$url"

        fail() {
          echo "startpage-launch: $*" >&2
          exit 1
        }
        for part in "$kind" "''${name:-x}" "''${opener:-x}"; do
          [[ $part =~ ^[A-Za-z0-9._-]+$ ]] || fail "not a launch link: $1"
        done
        [ -z "''${rest:-}" ] || fail "not a launch link: $1"

        run() {
          setsid -f "$@" >/dev/null 2>&1
        }

        case "$kind" in
          painel) run ${inKitty ["-e" "painel"]} ;;
          tool)
            case "$name" in
            ${lib.concatMapStrings (t: caseArm t.name (inKitty (["-e"] ++ argv t))) settings.tools}
              *) fail "no tool named $name" ;;
            esac
            ;;
          script)
            case "$name" in
            ${lib.concatMapStrings (s: caseArm s.name (inKitty (["-e"] ++ argv s))) settings.scripts}
              *) fail "no script named $name" ;;
            esac
            ;;
          project)
            dir=$(painel-projects | jq -r --arg name "$name" 'first(.[] | select(.name == $name) | .path) // empty')
            [ -n "$dir" ] || fail "no project named $name"
            case "$opener" in
            ${lib.concatMapStrings (o: caseArm o.name ''${kitty} --directory "$dir" ${lib.escapeShellArgs (["-e"] ++ o.cmd)}'') projects.open_with}
            ${lib.optionalString (projects ? alt) (caseArm "alt" ''${kitty} --directory "$dir" ${lib.escapeShellArgs (["-e"] ++ projects.alt)}'')}
              *) fail "no opener named $opener" ;;
            esac
            ;;
          *) fail "not a launch link: $1" ;;
        esac
      '';
    };

    pageConfig = {
      inherit (settings) user host links;
      search = settings.search or "https://www.google.com/search?q=";
      tools =
        map (t: {
          inherit (t) name;
          alias = t.alias or "";
          desc = t.desc or "";
        })
        settings.tools;
      scripts =
        map (s: {
          inherit (s) name;
          alias = s.alias or "";
          desc = s.desc or "";
        })
        settings.scripts;
      openWith =
        map (o: {
          inherit (o) name;
          key = o.key or "";
        })
        projects.open_with;
      hasAlt = projects ? alt;
      altName = lib.head (projects.alt or ["alt"]);
    };

    t = settings.theme;
  in {
    xdg.dataFile = {
      "painel-startpage/index.html".source = ./startpage/index.html;
      "painel-startpage/style.css".source = ./startpage/style.css;
      "painel-startpage/startpage.js".source = ./startpage/startpage.js;
      "painel-startpage/config.js".text = "window.PAINEL = ${builtins.toJSON pageConfig};\n";
      "painel-startpage/theme.css".text = ''
        :root {
          color-scheme: dark;
          --bg: #${c.base00};
          --fg: ${t.fg};
          --fg-bright: ${t.fg_bright};
          --muted: ${t.muted};
          --border: ${t.border};
          --selection: ${t.selection};
          --accent: ${t.accent};
          --red: ${t.red};
          --orange: ${t.orange};
          --yellow: ${t.yellow};
          --green: ${t.green};
          --aqua: ${t.aqua};
          --blue: ${t.blue};
          --font: "${config.stylix.fonts.monospace.name}";
        }
      '';
    };

    systemd.user = {
      services.painel-startpage-projects = {
        Unit.Description = "Write the project list for painel's start page";
        Service = {
          Type = "oneshot";
          ExecStart = lib.getExe writeProjects;
        };
        Install.WantedBy = ["default.target"];
      };
      # A project folder added or removed in a root.
      paths.painel-startpage-projects = {
        Unit.Description = "Watch the project folders for painel's start page";
        Path.PathChanged = map home projects.roots;
        Install.WantedBy = ["default.target"];
      };
      # Branches change without the folders changing.
      timers.painel-startpage-projects = {
        Unit.Description = "Refresh the project branches on painel's start page";
        Timer = {
          OnStartupSec = "1min";
          OnUnitActiveSec = "10min";
        };
        Install.WantedBy = ["timers.target"];
      };
    };

    xdg.desktopEntries.startpage-launch = {
      name = "painel start page launcher";
      exec = "${lib.getExe launcher} %u";
      noDisplay = true;
      terminal = false;
      mimeType = ["x-scheme-handler/launch"];
    };

    xdg.mimeApps.defaultApplications."x-scheme-handler/launch" = ["startpage-launch.desktop"];
  };
}
