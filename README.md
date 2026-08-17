# ❄️ thiagokimo's NixOS & Home Manager Configuration

<div align="center">

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue.svg?logo=nixos&logoColor=white&style=for-the-badge)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/WM-Hyprland-4bbaea.svg?logo=windowselement&logoColor=white&style=for-the-badge)](https://hyprland.org)
[![Nixvim](https://img.shields.io/badge/Editor-Nixvim-339933.svg?logo=neovim&logoColor=white&style=for-the-badge)](https://github.com/nix-community/nixvim)
[![Stylix](https://img.shields.io/badge/Theming-Stylix-ff69b4.svg?style=for-the-badge)](https://github.com/nix-community/stylix)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

*A premium, modular, and beautiful multi-host system configuration powered by **Nix Flakes**, customized around a unified **Gruvbox Dark Hard** aesthetics, a high-performance **Hyprland** Lua environment, and fully declarative workflows.*

---

[Key Features](#-key-features) • [Screenshots](#-screenshots) • [Architecture](#%EF%B8%8F-architecture) • [Hosts](#-hosts) • [Quick Start](#-quick-start)

</div>

---

## ✨ Key Features

- **📂 Modular Design**: Separation of system (`modules/nixos`), user space (`modules/home-manager`), custom binaries (`pkgs`), and host definitions (`hosts/`).
- **🎛️ Multi-Host Support**: Ready for standard x86 systems (Framework & ThinkPad T14), ARM64 hardware (ThinkPad X13s), and lightweight standalone Chromebook home-manager setups (`penguin`).
- **🎨 Unified Aesthetics (Stylix)**: System-wide **Gruvbox Dark Hard** color palette applied to applications, cursor (`Bibata-Modern-Ice`), fonts (`JetBrainsMono Nerd Font`), and styling via a centralized wallpapers repository (`thiagokimo/nix-wallpapers`).
- **🌀 Lua-Powered Hyprland**: Integrates `noctalia-shell` to compile a custom, modular `hyprland.lua` bind/control sheet for advanced screen locker, workspace rules, and hardware bindings.
- **⚡ Nixvim Editor**: A fully declarative Neovim environment customized with `neotree`, `lualine`, `bufferline`, `vim-nix`, and Dart coding plugins.

---

## 📸 Screenshots

<div align="center">

### 🌌 Desktop Workspace
![Desktop Setup](https://i.imgur.com/o6YzvQq.jpeg)
*Hyprland active workspace showing the custom Waybar, Gruvbox theme, and high-performance blur aesthetics.*

---

### 💻 Developer Environment
![Terminal and Editor Setup](https://i.imgur.com/PBpm9Rl.png)
*Kitty terminal executing Zsh and Yazi file manager alongside the declarative Nixvim editor.*

---

### 🔍 App Launcher & Interface
![Noctalia Launcher](https://i.imgur.com/HuBeNMh.jpeg)
*The elegant Noctalia App Launcher toggled in action.*

</div>

---

## 🏗️ Architecture

This repository uses a sophisticated, custom Nix Flake layout to build NixOS configurations and Home-Manager environments dynamically, using a shared library helper (`lib/default.nix`).

### System Component Diagram

```mermaid
graph TD
    Flake[flake.nix] -->|Imports| Vars[vars.nix]
    Flake -->|Imports| Lib[lib/default.nix]
    Flake -->|Packages| Pkgs[pkgs/*]
    Flake -->|Overlays| Overlays[overlays/*]

    subgraph Custom Library ["Shared Library (lib/)"]
        Lib --> Builders[lib/builders.nix]
        Lib --> Colors["lib/colors.nix (hexToRgb / hexToDec)"]
    end
    
    subgraph Build & Test Engine
        Builders -->|buildSystem| NixOS[NixOS Configurations]
        Builders -->|buildHome| HomeM[Home Manager Configurations]
        Builders -->|buildChecks| Checks[Flake Checks & CI]
        Builders -->|Injects myLib| NixOS
        Builders -->|Injects myLib| HomeM
    end

    subgraph Flake Checks & CI Tests
        Checks --> Formatting[Formatting Check - alejandra]
        Checks --> NixOSChecks[NixOS Config Builds]
        Checks --> HomeChecks[Home Manager Config Builds]
    end

    subgraph Host Profiles
        NixOS --> HostsCommon[hosts/common]
        NixOS --> HostSpecific["hosts/&lt;hostname&gt;"]
        HostsCommon --> BaseModule[modules/base]
        HostsCommon --> NixosModules[modules/nixos/*]
    end

    subgraph User Configuration
        HomeM --> HomeManagerBase[modules/home-manager]
        HomeManagerBase --> CLI[modules/home-manager/cli/*]
        HomeManagerBase --> Programs[modules/home-manager/programs/*]
        HomeManagerBase --> Hyprland[modules/home-manager/hyprland/*]
        HomeManagerBase --> Scripts[modules/home-manager/scripts/*]
        CLI -.->|Uses myLib.colors| Colors
    end

    style Flake fill:#7daea3,stroke:#3c3836,stroke-width:2px,color:#282828
    style Lib fill:#a9b665,stroke:#3c3836,stroke-width:2px,color:#282828
    style Builders fill:#a9b665,stroke:#3c3836,stroke-width:1px,color:#282828
    style Colors fill:#d8a657,stroke:#3c3836,stroke-width:1px,color:#282828
    style NixOS fill:#d3869b,stroke:#3c3836,stroke-width:2px,color:#282828
    style HomeM fill:#e78a4e,stroke:#3c3836,stroke-width:2px,color:#282828
    style Checks fill:#d8a657,stroke:#3c3836,stroke-width:2px,color:#282828
```

### Library Helpers (`lib/default.nix`)

To keep `flake.nix` clean and maintainable, system building, user space activation, CI testing logic, and color utilities are encapsulated within `lib/`:

- **`buildSystem`**: Generates a standard NixOS system configuration mapping to the corresponding host profile under `hosts/<hostname>`.
- **`buildHome`**: Generates a declarative Home-Manager configuration mapping to `modules/home-manager`.
- **`buildChecks`**: Dynamically generates flake checks and continuous integration (CI) tests for the active architecture. It includes:
  - **Formatting Tests**: Verifies that all Nix files in the repository adhere to the `alejandra` styling rules.
  - **NixOS Build Tests**: Ensures that NixOS host configurations (`nixos-framework`, `nixos-t14`, etc.) evaluate and compile successfully.
  - **Home-Manager Build Tests**: Verifies that user-space home profiles (`home-framework`, `home-t14`, etc.) compile successfully.
- **Color Utilities (`lib/colors.nix`)**: Exposes color manipulation functions (`hexToDec`, `hexToRgb`) injected as `myLib.colors` via special module arguments, allowing shell utilities (e.g. Fastfetch) to dynamically compute RGB ANSI formatting from Stylix hex themes.

### 🧩 Modular Options System (`custom.*`)

Reusable GUI applications and utility scripts are wrapped in declarative `mkEnableOption` switches under the `custom.*` namespace. All modules are imported into entry points and evaluated during CI/checks, while remaining dormant until explicitly enabled:

- **GUI Programs (`modules/home-manager/programs`)**:
  - `custom.programs.dunst.enable`: Dunst notification daemon
  - `custom.programs.waybar.enable`: Unified Waybar status bar (settings and styles)
  - `custom.programs.wofi.enable`: Wofi application launcher and emoji picker
- **Helper Scripts (`modules/home-manager/scripts`)**:
  - `custom.scripts.app-launcher.enable`: Wofi application launcher script
  - `custom.scripts.brightness.enable`: Screen brightness control utilities
  - `custom.scripts.lock.enable`: Hyprlock screen locking script
  - `custom.scripts.nix-kimo.enable`: `nk` command shortcut tool
  - `custom.scripts.screenshot.enable`: Hyprshot screenshot scripts
  - `custom.scripts.sound.enable`: Wireplumber audio control utilities

### Directory Structure

```text
.
├── flake.lock
├── flake.nix                  # Flake entry point & target host declarations
├── vars.nix                   # Global variables (username, email, themes, etc.)
├── assets/                    # Screenshots and assets
├── hosts/                     # Machine-specific configurations
│   ├── common/                # Shared base configurations across machines
│   ├── framework/             # Intel Framework 13 Laptop configuration
│   ├── t14/                   # Lenovo ThinkPad T14 Laptop configuration
│   ├── x13s/                  # Lenovo ThinkPad X13s ARM Laptop configuration
│   └── penguin/               # Standalone Chromebook / Crostini config
├── lib/                       # Custom library helper functions for building systems
├── modules/                   # Reusable configuration modules
│   ├── base/                  # Core system optimizations, GC, user configurations
│   ├── nixos/                 # Global NixOS components (Audio, Boot, Fonts, Steam)
│   │   └── services/          # System services (Tuigreet, Kanata, OpenSSH)
│   └── home-manager/          # User-space configurations (Stylix, XDG, Cli, Programs)
│       ├── cli/               # Shell config (Zsh, Fzf, Eza, Yazi, Nixvim)
│       ├── hyprland/          # Custom Lua Hyprland & Hyprpaper setup
│       ├── programs/          # GUI apps (Kitty, Dunst, Waybar, Wofi, Noctalia)
│       └── scripts/           # User utilities (Lock, Sound, Brightness, Screenshots)
├── overlays/                  # Nixpkgs overlays (stable packages, custom changes)
└── pkgs/                      # Custom local packages definitions
```

---

## 🖥️ Hosts

| Hostname | Architecture | Target Platform | Type | Purpose / Description |
| :--- | :--- | :--- | :--- | :--- |
| **`framework`** | `x86_64-linux` | Framework Laptop | NixOS | Primary development machine |
| **`t14`** | `x86_64-linux` | ThinkPad T14 | NixOS | Secondary portable workstation |
| **`x13s`** | `aarch64-linux` | ThinkPad X13s | Home-Manager | High efficiency Snapdragon ARM64 setup |
| **`penguin`** | `x86_64-linux` | Chromebook / Crostini | Home-Manager | Independent standalone dotfile setup |

---

## 🚀 Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/thiagokimo/nix-config.git ~/.config/nix-config
cd ~/.config/nix-config
```

### 2. Validate configuration
Ensure everything evaluates perfectly before building:
```bash
nix flake check
```

### 3. Apply NixOS system changes
Apply the host settings (substitute `<hostname>` with `framework` or `t14`):
```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

### 4. Apply User settings (Home Manager)
Apply the standalone home-manager profile:
```bash
home-manager switch --flake .#thiago@<hostname>
```

---

<div align="center">

*Configured with ❄️ and 💚 by [thiagokimo](https://github.com/thiagokimo)*

</div>
