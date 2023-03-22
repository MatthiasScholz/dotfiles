{ pkgs, config, inputs, lib, ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
  ];

  # filesystem configuration updates based on BTRFS
  fileSystems = { 
     "/".options = [ "compress=zstd" ];
     "/home".options = [ "compress=zstd" ];
     "/nix".options = [ "compress=zstd" "noatime" ];
     "/swap".options = [ "noatime" ];
  };
  swapDevices = [ { device = "/swap/swapfile"; } ];

  # Select internationalisation properties.
  #i18n = {
  #  defaultLocale = "en_US.UTF-8";
  #};


  # Configure keymap in X11
  #services.xserver.layout = "de";
  #services.xserver.xkbOptions = {
  #  "eurosign:e"
  #  #   "caps:escape" # map caps to escape.
  #};
  #console = {
  #  font = "Lat2-Terminus16";
  #  useXkbConfig = true; # use xkbOptions in tty.
  #};

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  ## Modules
  modules = {
    desktop = {
      #bspwm.enable = true;
      gnome.enable = true;
      apps = {
        rofi.enable = true;
        # godot.enable = true;
      };
      browsers = {
        default = "brave";
        brave.enable = true;
        #firefox.enable = true;
      };
      gaming = {};
      media = {
        #daw.enable = true;
        documents.enable = true;
        graphics.enable = true;
        # FIXME mpv-with-scripts has been renamed
        # mpv.enable = true;
        #recording.enable = true;
        spotify.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
      };
      vm = {
        #qemu.enable = true;
      };
    };
    
    dev = {
      golang.enable = true;
      #node.enable = true;
      #rust.enable = true;
      #python.enable = true;
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      emacs.doom.enable = true;
      vim.enable = true;
    };
    shell = {
      #adl.enable = true;
      #vaultwarden.enable = true;
      direnv.enable = true;
      git.enable    = true;
      gnupg.enable  = true;
      tmux.enable   = true;
      zsh.enable    = true;
      onepassword.enable = true;
    };
    services = {
      ssh.enable = true;
      docker.enable = true;
      # Needed occasionally to help the parental units with PC problems
      # teamviewer.enable = true;
    };
    theme.active = "alucard";
  };


  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  # FIXME not working
  # networking.wireless.enable = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = lib.mkDefault false;
  networking.interfaces.wlp3sO.useDHCP = lib.mkDefault true;
  networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;

  hardware.opengl.enable = true;
  
  time.timeZone = "Europe/Berlin";
}
