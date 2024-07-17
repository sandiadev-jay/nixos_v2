{ config, lib, pkgs, modulesPath, ... }:

{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 64 * 1024;
    }
  ];
}