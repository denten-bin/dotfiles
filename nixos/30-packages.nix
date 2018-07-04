{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    arandr
    awscli
    bash-completion
    calibre
    chromium
    dmenu
    feh
    firefox
    gcc
    gimp
    git
    gnumake
    haskellPackages.pandoc-citeproc
    htop
    i3
    i3status
    jekyll
    liberation_ttf
    liberastika
    libreoffice
    lmodern
    lsof
    mosh
    networkmanagerapplet
    nix-prefetch-scripts
    nix-repl
    pandoc
    powertop
    python
    ruby
    shellcheck
    stdenv
    stow
    texlive.combined.scheme-full
    tlp
    vim_configurable
    unzip
    wget
    which
    xclip
    xorg.xbacklight
    xorg.xev
    xscreensaver
    xsel
    zathura
    zotero
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
