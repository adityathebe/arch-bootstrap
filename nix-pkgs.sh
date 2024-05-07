#!/bin/env bash

nix-channel --add https://nixos.org/channels/nixos-23.11 nixpkgs
nix-channel --update --verbose

# I like to install all python CLIs using nix.
nix-env -iA nixpkgs.pgcli nixpkgs.azure-cli nixpkgs.awscli \
  nixpkgs.redshift nixpkgs.yt-dlp
