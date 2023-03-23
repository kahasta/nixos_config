#!/bin/sh
nix build --impure .#hmConfigurations.kahasta.activationPackage 
./result/activate
