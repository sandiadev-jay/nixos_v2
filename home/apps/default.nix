{ inputs, config, pkgs, ... }:

{
  # Packages that should be installed to the user profile
  home.packages = with pkgs; [

    # archives
    zip
    xz
    unzip
    p7zip
    unrar
    gnutar

    # web browsers
    firefox
    google-chrome
    brave
    # lynx  # CLI browser
    
    # development tools
    vscode-fhs
    julia
    go
    nodejs_22
    cmake
    # python312
    # python312Packages.conda
    # python312Packages.pip

    # wine
    wineWowPackages.waylandFull
    winetricks

    # design and artistic tools
    # blender
    musescore
    gimp
    obs-studio
    drawio

    # office tools
    ranger  # CLI file browser
    # nautilus  # GUI file browser (Gnome's)
    libreoffice  # Office suite
    pantheon.elementary-files  # GUI file browser with miller columns
    # rclone  # Sync utility for cloud drives (Google Drive)
    google-drive-ocamlfuse  # Sync utility for Google Drive
    dex  # Launches desktop files not in path

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools (command line)
    kitty  # terminal emulator
    htop  # system monitor
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    nvtopPackages.full  # GPU monitoring
    gpustat  # GPU monitoring
    sysstat  # for iostat command
    lm_sensors # for `sensors` command
    ethtool  # for ethernet stuff
    pciutils # lspci
    powertop  # power use tool
    usbutils # lsusb
    mesa-demos # testing hardware acceleration
    wev  # tool for identifying input keys
    xcur2png # converst cursors to PNG images
    wl-clipboard  # clipboard
    brightnessctl  # screen brightness controller
    micro  # command line text editor
    wget  # Get using HTTP, HTTPS, and FTP
    # linuxHeaders  # Header files and scripts for Linux kernel
    kdePackages.polkit-kde-agent-1  # Polkit for Hyprland
    vlock

    # networking
    nmap  # For viewing devices connected to the network
    networkmanagerapplet  # Network management applet
    blueman  # Bluetooth manager and applet
    pwvucontrol  # Volume control for pipewire
    # nmcli - this is already activated, just a reminder for myself
    # bluetoothctl - this is already activate, just a reminder for myself
    
    # Hyprland/Sway utilities
    hyprshot
    rofi-wayland  # Application launcher
    hyprpicker

    # For theming
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    # glib  # This adds gsettings
    
  ];
}
