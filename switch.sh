#!/usr/bin/env bash


nixos-rebuild switch --flake ".#$HOSTNAME" --show-trace --use-remote-sudo
