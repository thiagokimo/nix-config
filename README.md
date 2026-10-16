# ❄️ thiagokimo's NixOS & Home Manager Configuration

<div align="center">

[![NixOS](https://img.shields.io/badge/NixOS-Determinate_Weekly-blue.svg?logo=nixos&logoColor=white&style=for-the-badge)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/WM-Hyprland_(Lua)-4bbaea.svg?logo=hyprland&logoColor=white&style=for-the-badge)](https://hyprland.org)
[![Noctalia Shell](https://img.shields.io/badge/Shell-Noctalia-7daea3.svg?style=for-the-badge)](https://github.com/noctalia-dev/noctalia-shell)
[![Nixvim](https://img.shields.io/badge/Editor-Nixvim-339933.svg?logo=neovim&logoColor=white&style=for-the-badge)](https://github.com/nix-community/nixvim)
[![Stylix](https://img.shields.io/badge/Theming-Stylix_(Gruvbox)-ff69b4.svg?style=for-the-badge)](https://github.com/nix-community/stylix)
[![Helper](https://img.shields.io/badge/CLI-nh_(nix--helper)-d3869b.svg?style=for-the-badge)](https://github.com/viperML/nh)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

*A robust, modular, and aesthetic multi-host workstation setup managed through **Nix Flakes**, featuring **Determinate Systems cooled channels**, a unified **Gruvbox Dark Hard** palette, a Lua-compiled **Hyprland** desktop powered by **Noctalia Shell**, declarative **Nixvim**, low-latency **Kanata** dual-role keys, and **nh** workflow automation.*

---

[Key Features](#-key-features) • [Screenshots](#-screenshots) • [Architecture & Flake Design](#%EF%B8%8F-architecture--flake-design) • [Hardware & Hosts](#-hardware--hosts) • [Desktop & Noctalia Shell](#-desktop--noctalia-shell) • [System Services & Base](#%EF%B8%8F-system-services--base) • [CLI, Nixvim & User Space](#-cli-nixvim--user-space) • [Directory Layout](#-directory-layout)

</div>

---

## ✨ Key Features

- **❄️ Determinate Systems Cooldown Channels**: Tracks Determinate Systems weekly cooled unstable (`nixpkgs-weekly`) for stability while pulling tested dependencies from the chilled channel (`nixpkgs-26.05-chilled`).
- **🎛️ Multi-Host Hardware Profiles**:
  - **Framework 13 (AMD)**: Full hardware acceleration, LUKS disk encryption, high-DPI scaling (2256×1504 display).
  - **ThinkPad T14 Gen 2 (Intel)**: Curated `nixos-hardware` profile, LUKS disk encryption, and 8GB swapfile.
  - **ThinkPad T14s (Intel)**: Headless home server and self-hosted CI runner. Curated `nixos-hardware` profile, LUKS disk encryption, and 8GB swapfile.
- **🎨 System-Wide Gruvbox Aesthetics (Stylix)**: System and user-space synchronization under **Gruvbox Dark Hard** base16 palette, paired with **Bibata-Modern-Ice** cursors, **JetBrainsMono Nerd Font**, and centralized wallpapers fetched from `thiagokimo/nix-wallpapers`.
- **🌀 Lua-Compiled Hyprland Desktop**: Wayland compositor configured dynamically through a compiled `hyprland.lua` configuration, including custom Bezier animations, dwindle layout, and hardware/media shortcuts.
- **🌖 Noctalia Shell Ecosystem**: Modern unified status bar and desktop shell delivering split dual bars (top and bottom), Belo Horizonte live weather tracking, media control, audio visualizers, and a **display-resolution-aware lockscreen** whose widget geometry calculates mathematically per host.
- **⚡ Fully Declarative Nixvim**: Complete Neovim environment maintained declaratively in Nix with `lualine`, `neo-tree`, `bufferline`, `vim-nix`, `dart-vim-plugin`, and `stylua`.
- **⌨️ Low-Latency Dual-Role Keys (Kanata)**: Hardware-level keyboard remap daemon intercepting `uinput` to provide tap-for-Escape and hold-for-Ctrl on both Caps Lock and Left Control (`(tap-hold 100 200 esc lctrl)`).
- **🚀 nh (Nix CLI Helper) & Automated GC**: Integrated `nh` for accelerated switching (`nrs` and `hms` aliases) alongside automated weekly Nix store optimization and garbage collection (`--delete-older-than 7d`).
- **🌐 Secure Mesh Networking (Tailscale)**: Kernel-level Tailscale service with trusted interface routing (`tailscale0`) and loose reverse-path filtering.

---

## 📸 Screenshots

<div align="center">

### 🌌 Desktop Workspace
![Desktop Setup](https://i.imgur.com/o6YzvQq.jpeg)
*Hyprland active workspace with Noctalia Shell dual bars, Gruvbox theme, and smooth blur styling.*

---

### 💻 Developer Environment
![Terminal and Editor Setup](https://i.imgur.com/PBpm9Rl.png)
*Kitty terminal executing Zsh, Fastfetch with dynamic Stylix ANSI cards, Yazi file manager, and declarative Nixvim.*

---

### 🔍 App Launcher & Interface
![Noctalia Launcher](https://i.imgur.com/HuBeNMh.jpeg)
*The Noctalia App Launcher toggled in action.*

</div>

---

## 🏗️ Architecture & Flake Design

The flake follows the dendritic pattern on top of [flake-parts](https://flake.parts): every `.nix` file is a flake-parts module, except the generated hardware configurations and the color helpers in `lib/`. `flake.nix` imports the typed `vars` option and its values in `vars.nix`, and `import-tree` loads every file in `features/` and `hosts/`. Each feature adds a NixOS module, a Home Manager module or both to `flake.modules`, and several files can add to the same feature. Each host file sets everything about one machine in `vars.hosts`: its system, display, features and own NixOS module. `modules/flake/hosts.nix` then builds one NixOS and one Home Manager configuration per host, from its own module and the features it lists. No module receives `specialArgs`: values come from the flake scope.

### System Architecture Diagram

```mermaid
graph TD
    Inputs["Inputs<br/>Determinate Systems nixpkgs, home-manager,<br/>nixvim, stylix, noctalia, nixos-hardware"] --> Flake
    Flake["flake.nix<br/>flake-parts mkFlake"]

    subgraph FlakeLevel ["Flake-level modules"]
        VarsOpt["modules/flake/vars.nix<br/>declares the typed vars option"]
        Vars["vars.nix<br/>user, app defaults, feature sets"]
        subgraph Features ["features/ (loaded by import-tree)"]
            BaseF["base, on every host:<br/>core, cli, nvim, stylix, zsh, ai, audio,<br/>bluetooth, docker, firmware, kanata, ssh, tailscale"]
            LaptopF["laptop, on framework and t14:<br/>desktop, gaming, hyprland"]
            ServerF["t14s only:<br/>github-runners"]
        end
        subgraph Hosts ["hosts/ (loaded by import-tree)"]
            HostFiles["hosts/framework, t14, t14s<br/>each machine: system, display,<br/>features from the feature sets,<br/>and its own NixOS module"]
        end
        HostsMod["modules/flake/hosts.nix<br/>builds every host"]
    end

    Flake -->|imports| FlakeLevel
    Vars -->|sets| VarsOpt
    HostFiles -->|sets vars.hosts.NAME| VarsOpt
    BaseF -->|define| FlakeModules
    LaptopF -->|define| FlakeModules
    ServerF -->|define| FlakeModules
    FlakeModules["flake.modules<br/>nixos.* and homeManager.*"]

    VarsOpt -->|config.vars| HostsMod
    FlakeModules -->|features each host lists| HostsMod

    subgraph Outputs ["Flake Outputs"]
        NixOS["nixosConfigurations<br/>framework, t14, t14s"]
        HomeM["homeConfigurations<br/>thiago@host"]
        Checks["checks<br/>Alejandra and builds"]
    end

    HostsMod --> NixOS
    HostsMod --> HomeM
    HostsMod --> Checks

    Colors["lib/colors.nix<br/>hex to RGB"]
    BaseF -.->|fastfetch colors| Colors

    style Flake fill:#7daea3,stroke:#3c3836,stroke-width:2px,color:#282828
    style VarsOpt fill:#7daea3,stroke:#3c3836,stroke-width:1px,color:#282828
    style Vars fill:#7daea3,stroke:#3c3836,stroke-width:1px,color:#282828
    style HostFiles fill:#7daea3,stroke:#3c3836,stroke-width:1px,color:#282828
    style BaseF fill:#89b482,stroke:#3c3836,stroke-width:1px,color:#282828
    style LaptopF fill:#89b482,stroke:#3c3836,stroke-width:1px,color:#282828
    style ServerF fill:#89b482,stroke:#3c3836,stroke-width:1px,color:#282828
    style FlakeModules fill:#89b482,stroke:#3c3836,stroke-width:2px,color:#282828
    style HostsMod fill:#a9b665,stroke:#3c3836,stroke-width:2px,color:#282828
    style Colors fill:#d8a657,stroke:#3c3836,stroke-width:1px,color:#282828
    style NixOS fill:#d3869b,stroke:#3c3836,stroke-width:2px,color:#282828
    style HomeM fill:#e78a4e,stroke:#3c3836,stroke-width:2px,color:#282828
    style Checks fill:#d8a657,stroke:#3c3836,stroke-width:2px,color:#282828
```

### Building the Hosts (`modules/flake/hosts.nix`)

For each host in `vars.hosts`, it builds:

- **`nixosConfigurations.<host>`**: a `nixosSystem` from the host's own module (`vars.hosts.<host>.nixos`, set in `hosts/<host>/default.nix`) and the NixOS modules of the features it lists. It also sets `networking.hostName`.
- **`homeConfigurations."thiago@<host>"`**: a standalone Home Manager configuration from the Home Manager modules of the host's features. It also sets the `host.name` option, which Noctalia uses to find the host's display.
- **`checks`**, for the hosts of each system:
  - **Formatting**: Validates repository Nix formatting against `alejandra`.
  - **NixOS Toplevel Builds**: Builds the system toplevel of each host.
  - **Home Manager Activations**: Builds the activation package of each host.

A host that lists a feature no file defines fails evaluation with an error that names it.

`lib/colors.nix` exposes `hexToDec` and `hexToRgb`, which `features/cli/fastfetch.nix` uses to turn Stylix hex colors into RGB ANSI escape codes.

### Package Channels & Overlays

1. **Determinate Systems Weekly (`nixpkgs`)**: High-velocity unstable channel curated and cooled weekly to eliminate broken upstream builds.
2. **Determinate Systems Chilled (`nixpkgs-stable`)**: Pinned stable release channel exposed via the `pkgs.stable` overlay (`overlays/default.nix`).
3. **OpenLDAP Patch Overlay**: Overrides `openldap` package attributes to bypass test suites (`doCheck = false`, `doInstallCheck = false`) for faster, non-blocking builds.
4. **Developer Shell (`devShells.default`)**: Preconfigured environment packing `alejandra` (formatter), `nixd` (Nix language server), and `antigravity-ide`.

---

## 🖥️ Hardware & Hosts

Each host is defined in `hosts/<host>/default.nix`: its system, display and features in `vars.hosts.<host>`, and its own NixOS module (hardware, `nixos-hardware` profile, swap and anything only that machine needs), next to its generated `_hardware-configuration.nix`. Hosts build their features from the sets in `vars.featureSets`. Every host gets the `base` features: core, cli, nvim, stylix, zsh, ai, audio, bluetooth, docker, firmware, kanata, ssh and tailscale. The laptops (`framework`, `t14`) also get desktop, gaming and hyprland, and `t14s` gets github-runners:

| Hostname | Platform / CPU | Target Machine | Resolution | Storage / Swap | Special Hardware Configurations |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`framework`** | `x86_64-linux`<br>AMD Ryzen | Framework Laptop 13 | `2256×1504`<br>(eDP-1) | LUKS Encrypted<br>Swap Partition | `hardware.cpu.amd.updateMicrocode`, AMD KVM virtualization, high-DPI scaling. |
| **`t14`** | `x86_64-linux`<br>Intel Gen 2 | Lenovo ThinkPad T14 | `1920×1080`<br>(eDP-1) | LUKS Encrypted<br>8GB `/swapfile` | `nixos-hardware` T14 module, Intel microcode, power-profiles-daemon. |
| **`t14s`** | `x86_64-linux`<br>Intel | Lenovo ThinkPad T14s (home server) | Headless | LUKS Encrypted<br>8GB `/swapfile` | `nixos-hardware` T14s module, Intel microcode, GitHub Actions runners, never sleeps with the lid closed. |

---

## 🌖 Desktop & Noctalia Shell

### Lua-Powered Hyprland (`features/hyprland`)

Rather than maintaining a flat configuration file, `features/hyprland/hyprland.nix` dynamically compiles `~/.config/hypr/hyprland.lua`:
- **Window Management & Dwindle**: Dwindle layout with smart splits, active window opacity `1.0`, inactive opacity `0.89`, border radius `20px`, and custom cubic-bezier animations (`myBezier, 0.05, 0.9, 0.1, 1.05`).
- **Window Rules**: Dedicated workspace pinning for Steam (workspace 7), Kew and Pavucontrol (workspace 9).
- **Noctalia IPC Integration**: Hyprland binds communicate directly with the Noctalia daemon via `${ipc} = "noctalia msg"`:
  - `SUPER + SPACE`: Toggle application launcher panel
  - `SUPER + SHIFT + L`: Lock screen
  - `SUPER + PRINT`: Fullscreen screenshot to `~/Media/Pictures/Screenshots`
  - `SUPER + SHIFT + PRINT`: Interactive region screenshot
  - Hardware keys: Audio mute, volume up/down, brightness up/down, and lid switch sleep/lock triggers.

### Noctalia Shell (`features/hyprland/noctalia.nix`)

A unified desktop shell environment offering status bars, widgets, and lockscreen management:
- **Dual Status Bars**:
  - **Top Bar**: Workspace pager, taskbar, active window indicator, brightness slider, volume status, network status, battery level, and clock.
  - **Bottom Bar**: RAM usage, CPU temperature, system monitor, media controls, audio visualizer, system tray, notification center, clipboard history, Bluetooth manager, and session control.
- **Dynamic Lockscreen Widget Layout**:
  Lockscreen widget coordinates are computed mathematically based on the active host's screen dimensions (`vars.hosts.<host>.display`):
  - Dynamic center coordinates: `centerX = width / 2`, `centerY = height / 2`.
  - Clock anchored at `cy = height * 0.25`, Sysmon at `cx = width * 0.75`, Weather at `cx = width * 0.25`, audio visualizer centered, and login box anchored at `cy = height - 128`.
- **Live Weather & Localization**: Live weather integration targeting Belo Horizonte, displayed in Celsius with graphical ambient effects.

---

## ⚙️ System Services & Base

System capabilities provided by features:

- **Low-Latency Kanata Daemon (`features/kanata.nix`)**:
  Interception service running under dedicated `uinput` permissions that turns both **Caps Lock** and **Left Control** into dual-role keys: tapping outputs `Escape` and holding outputs `Left Control` (`tap-hold 100 200 esc lctrl`).
- **Tuigreet Display Manager (`features/hyprland/login.nix`)**:
  Clean TUI greeting display manager launching directly into `start-hyprland`.
- **Tailscale Mesh VPN (`features/tailscale.nix`)**:
  Enables Tailscale daemon with `tailscale0` set as a trusted firewall interface and `checkReversePath = "loose"` for exit-node and subnet compatibility.
- **PipeWire & WirePlumber (`features/audio.nix`)**:
  Full audio stack replacement with PipeWire, WirePlumber session management, 32-bit ALSA support, PulseAudio emulation (`pactl`), and JACK integration.
- **Containerization & Gaming**:
  - Docker daemon with `docker-compose` and non-root group assignment (`features/docker.nix`).
  - Steam enabled with firewall openings for Steam Remote Play and dedicated servers (`features/gaming.nix`).
- **Nix Store Maintenance & nh (`features/core/nix.nix` & `nh.nix`)**:
  Automatic weekly store optimization, automated garbage collection (`--delete-older-than 7d`), legacy channel disabling, and `nh` CLI configured to target `vars.user.configDir`.

---

## 💻 CLI, Nixvim & User Space

### Declarative Nixvim Editor (`features/nvim`)

Neovim configured declaratively through Nixvim:
- **Colorscheme**: Native Gruvbox theme adhering to Stylix palette rules.
- **Plugins**:
  - `neo-tree`: File tree sidebar with Git indicators.
  - `lualine`: Status line matching desktop aesthetics.
  - `bufferline`: Top tab and buffer management bar.
  - `vim-nix`: Nix syntax highlighting and indentation.
  - `dart-vim-plugin`: Flutter and Dart language support.
  - `stylua`: Lua code formatting for Hyprland configs and scripts.
- **Keybindings & Ergonomics**: Window splits, buffer navigation, clipboard synchronization with `wl-clipboard`, and line numbering.

### Shell, Fastfetch & CLI Tools (`features/cli`, `features/zsh.nix`)

- **Zsh & Oh-My-Zsh**: Configured with `robbyrussell` prompt theme, `zsh-autosuggestions`, `zsh-syntax-highlighting`, and custom aliases:
  - `nrs`: Rebuild NixOS configuration via `nh os switch`
  - `hms`: Rebuild Home Manager configuration via `nh home switch`
  - `nkcd`: Jump to configuration directory (`~/.config/nix-config`)
  - `ls`: Modern icons view via `eza --icons=always --no-quotes`
  - `tree`: Tree structure view via `eza --icons=always --tree --no-quotes`
  - `cat`: Syntax-highlighted output via `bat`
- **Fastfetch (`features/cli/fastfetch.nix`)**: Custom ASCII NixOS card layout using `hexToRgb` from `lib/colors.nix` to dynamically color card borders (OS, Host, Kernel, Uptime, Packages, Shell, WM, Terminal, CPU, GPU, Memory, Battery) with truecolor ANSI escape sequences matching the active Stylix Gruvbox theme.
- **CLI Utilities**: `yazi` (terminal file manager), `fzf` (fuzzy finder), `btop` (resource monitor), `ani-cli`, `cbonsai`, `peaclock`, `pipes`, and `cmatrix`.

### Standardized XDG User Directories & MIME Associations (`features/desktop/xdg.nix`)

- **Organized Home Directory Layout**:
  - `~/Documents`, `~/Downloads`, `~/Projects`
  - `~/Media/Music`, `~/Media/Pictures`, `~/Media/Videos`, `~/Media/Pictures/Screenshots`
- **Declarative MIME Types**: Automatically mapped from `vars.defaults` across Web (`google-chrome-stable`), Editor (`nvim`), PDF (`Papers`), Images (`Loupe`), Media (`VLC`), and File Manager (`Nautilus`).
- **Portals**: Configured desktop portals for Hyprland and GTK (`xdg-desktop-portal-gtk`).

---

## 📂 Directory Layout

```text
.
├── flake.nix                  # Flake entry point: flake-parts, imports everything below
├── vars.nix                   # Values of the typed vars option (user, app defaults, feature sets)
├── features/                  # Features spanning NixOS & Home Manager, chosen by each host
│   ├── core/                  # Boot, locale, user, networking, Nix, nh, nixpkgs, Home Manager basics
│   ├── cli/                   # Command-line tools (fastfetch, eza, fzf, gh, git, yazi)
│   ├── nvim/                  # Nixvim options, key mappings and plugins
│   ├── stylix/                # Gruvbox Dark Hard theming
│   ├── firmware/              # fwupd and the firmware-update script
│   ├── desktop/               # Graphical session: fonts, kitty, default apps, GUI apps
│   ├── hyprland/              # Hyprland, Noctalia, hyprpaper, portals, login screen
│   └── *.nix                  # Single-file features (ai, audio, bluetooth, docker, gaming, ...)
├── hosts/                     # Each machine: system, display, features, own NixOS module, hardware configuration
│   ├── framework/             # AMD Framework 13 Laptop
│   ├── t14/                   # Lenovo ThinkPad T14 Gen 2 (Intel)
│   └── t14s/                  # Lenovo ThinkPad T14s (Intel), home server
├── modules/flake/             # Flake-level modules: the vars option and the host builder
├── lib/                       # colors.nix: hex to RGB helpers
├── overlays/                  # Nixpkgs overlays (stable packages, custom modifications)
└── pkgs/                      # Custom local package definitions
```

---

<div align="center">

*Configured with ❄️ and 💚 by [thiagokimo](https://github.com/thiagokimo)*

</div>
