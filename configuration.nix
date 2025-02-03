{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
      ./nvidia.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "openwebui"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nikolas = {
    isNormalUser = true;
    description = "nikolas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAl+i96VEfOENnsKJw+Jm+J62nqE6/6I8ezGeEDlNmok nikolas@pop-os"  #thinkpad
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDq3V8EgkmEiYVAOg2h/8YVgaIlvhajB1EqV+T+5NtW19KHEhPIUBWa0i/wnrmLyTKql2Qpq4+lnrIL3CZwIHJHe5BTart2uPoUJl8p+oM2r1oLHogMzW9NBJyY7GJIFO4PDL08n8z2fkMjUyE3eg4XzoHD3LbRdq0BDZe7b/z34XNjJwMxB23pHLz/qx2FpOg4/UT9ALGNIRxT4gUT48ZkJuuKw7dhoiVWYYhgz70VhpzfDiwGEgxP51AN4QsE2e7Gtq4LHBV+7ev3QRFGBbVCziY42PCYxO2EuZLJKs8xHN2ulHBA3vm6LnW0cTyUvWlp5jeMDQuxwQKttB6Db0dmL2PTdLi2Z9TwAlrRRotKs8QxkPARukeW4PmXhKDPy2qexeOCpPNjvoHpXksTRjmcmNXb2wVMKizzKgm0HUhlRlC0M4HSVYCwpUO2zewONlI5mjpcLfxpbm/obKmyuKy0FhXY2V+yospVu3CHEeHTGxKkv5wgIVvQwfqb71t2fEnnRhq1r6OvyxMYn+B3LLVg494E4zUVuIfB/r2W1ok4rtrHL5vdfuIy6r00Z6SGI9J5xu5cKor6REYioBpptus1gwG/H517crcKT9slsK/vfQ0dbnSrzErS2u8IkzH73zERfhvp3tmLZLko9ng6ZIHnRGfpoRzUnp2RfOCigudS3w== nikolas@longen-pc"  # Linux office PC
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
     git
     wget
     htop
     nvtopPackages.full
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  services.open-webui = {
    enable = true;
    host = "0.0.0.0";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
