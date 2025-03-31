# dotfiles

[![Build Status]](https://github.com/kev-daniell/dotfiles/actions/workflows/ci.yaml)

[build status]: https://github.com/kev-daniell/dotfiles/actions/workflows/ci.yaml/badge.svg?event=push

This repository contains a [nix-darwin] configuration that sets up a consistent environment for technical writing work at BitGo.
It includes tools and applications commonly needed for technical documentation tasks.

[nix-darwin]: https://github.com/LnL7/nix-darwin

## Prerequisites

1. You must have the Nix package manager installed.
   Use the [Determinate Systems installer] to install Nix on your machine:

   ```sh
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
     | sh -s -- install --determinate
   ```

2. You must also have [configured] Nix with a personal GitHub access token.

3. Install `nix-darwin` by running:

   ```sh
   nix profile install nix-darwin
   ```

[determinate systems installer]: https://github.com/DeterminateSystems/nix-installer
[configured]: https://bitgoinc.atlassian.net/wiki/spaces/ENG/pages/2800156677/Create+a+GitHub+Personal+Access+Token+for+Nix

## Getting Started

1. Clone this repository:

   ```sh
   git clone https://github.com/kev-daniell/dotfiles.git
   cd dotfiles
   ```

2. Configure `flake.nix` to use your username:
   TODO: Expand

3. Build and activate the Nix environment:

   ```sh
   darwin-rebuild --flake . switch
   ```
