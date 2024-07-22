{ config, lib, pkgs, ... }:

{

  # Enable OpenGL (renamed to graphics)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
    ]; 
    extraPackages32 = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
      intel-media-driver
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [
    "xe"
    "nvidia"
  ];

  # Accept Nvidia license
  nixpkgs.config.nvidia.acceptLicense = true;

  # Nvidia config
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management.
    powerManagement.enable = true;
    # Fine-grained power management. Turns off GPU when not in use (works with offload)
    powerManagement.finegrained = false;

    # Open driver is currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Settings accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Might need to select the right driver
    package = config.boot.kernelPackages.nvidiaPackages.stable; 

    # Laptop required config for dual GPU setup
    prime = {
      # This will start an app using NVIDIA card with sync (and should wtih offload):
      # __NV_PRIME_RENDER_OFFLOAD=1 (shouldn't be necessary with offload set to false but it works)
      sync.enable = false;
      offload = {
        enable = true;
        enableOffloadCmd = true;  # nvidia-offload
      };

      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Also putting config for the Intel GPU in here
  # xe requires linux kernelt 6.8 or newer (running 6.9.4)
  # Load the Intel GPU kernel module at stage 1 boot
  boot.initrd.kernelModules = [ "xe" ];
  # boot.initrd.kernelModules = [ "i915" ];  # might fix sleep
  
  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";  # Resolves NVK requires Nouveau error
  };
}
