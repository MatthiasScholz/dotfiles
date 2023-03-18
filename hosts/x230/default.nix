{ pkgs, config, lib, ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ];

  # Select internationalisation properties.
  #i18n = {
  #  defaultLocale = "en_US.UTF-8";
  #};

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;


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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #sound.enable = true;
  #hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  #services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #nixpkgs.config.allowUnfree = true;

  ## Modules
  modules = {
    desktop = {
      bspwm.enable = true;
      apps = {
        rofi.enable = true;
        # godot.enable = true;
      };
      browsers = {
        default = "brave";
        brave.enable = true;
        #firefox.enable = true;
        #qutebrowser.enable = true;
      };
      gaming = {
        # steam.enable = true;
        # emulators.enable = true;
        # emulators.psx.enable = true;
      };
      media = {
        daw.enable = true;
        documents.enable = true;
        graphics.enable = true;
        #mpv.enable = true;
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
      #node.enable = true;
      #rust.enable = true;
      #python.enable = true;
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
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
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = lib.mkDefault false;
  networking.interfaces.wlp3sO.useDHCP = lib.mkDefault true;
  networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;

  ## Personal backups
  # Syncthing is a bit heavy handed for my needs, so rsync to my NAS instead.
  #systemd = {
    #services.backups = {
    #  description = "Backup /usr/store to NAS";
    #  wants = [ "usr-drive.mount" ];
    #  path  = [ pkgs.rsync ];
    #  environment = {
    #    SRC_DIR  = "/usr/store";
    #    DEST_DIR = "/usr/drive";
    #  };
    #  script = ''
    #    rcp() {
    #      if [[ -d "$1" && -d "$2" ]]; then
    #        echo "---- BACKUPING UP $1 TO $2 ----"
    #        rsync -rlptPJ --chmod=go= --delete --delete-after \
    #            --exclude=lost+found/ \
    #            --exclude=@eaDir/ \
    #            --include=.git/ \
    #            --filter=':- .gitignore' \
    #            --filter=':- $XDG_CONFIG_HOME/git/ignore' \
    #            "$1" "$2"
    #      fi
    #    }
    #    rcp "$HOME/projects/" "$DEST_DIR/projects"
    #    rcp "$SRC_DIR/" "$DEST_DIR"
    #  '';
    #  serviceConfig = {
    #    Type = "oneshot";
    #    Nice = 19;
    #    IOSchedulingClass = "idle";
    #    User = config.user.name;
    #    Group = config.user.group;
    #  };
    #};
    #timers.backups = {
    #  wantedBy = [ "timers.target" ];
    #  partOf = [ "backups.service" ];
    #  timerConfig.OnCalendar = "*-*-* 00,12:00:00";
    #  timerConfig.Persistent = true;
    #};
  #};
}
