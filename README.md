# dotfiles

[![Build Status]](https://github.com/kev-daniell/dotfiles/actions/workflows/ci.yaml)

[build status]: https://github.com/kev-daniell/dotfiles/actions/workflows/ci.yaml/badge.svg?event=push

## Prerequisites

1. You must have the Nix package manager installed.
   Use the [Determinate Systems installer] to install Nix on your machine:

   ```sh
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
     | sh -s -- install --determinate
   ```

2. Install `nix-darwin` by running:

   ```sh
   nix profile install nix-darwin
   ```

[determinate systems installer]: https://github.com/DeterminateSystems/nix-installer

## Getting Started

1. Clone this repository:

   ```sh
   git clone https://github.com/kev-daniell/dotfiles.git
   cd dotfiles
   ```

2. Build and activate the Nix environment:

   ```sh
   make switch
   ```
