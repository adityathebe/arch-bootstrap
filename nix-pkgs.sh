#!/bin/env bash

nix-channel --add https://nixos.org/channels/nixos-23.11 nixpkgs
nix-channel --update --verbose

nix-env -iA nixpkgs.pgcli nixpkgs.azure-cli nixpkgs.awscli
