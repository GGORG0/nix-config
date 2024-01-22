#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

nixos-rebuild switch --flake ".#$HOSTNAME" --show-trace --use-remote-sudo
