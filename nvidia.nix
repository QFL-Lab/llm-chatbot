{ config, lib, pkgs, ... }:
{

  # https://nixos.wiki/wiki/CUDA
  nix.settings = {
    substituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    # Public key found here: https://app.cachix.org/cache/cuda-maintainers#pull
    trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="   
    ];
  };

  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.cudaSupport = true;
  nixpkgs.config.cudnnSupport = true;

  # https://nixos.wiki/wiki/Nvidia
  hardware = {
    graphics = {
      enable = true;
    };

    enableRedistributableFirmware = true;
      
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
}
