{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  time.timeZone = "America/Chicago";

  programs.niri.enable = true;

  programs.yazi.enable = true;
  
  nixpkgs.config.allowUnfree = true;

    users.users.nix = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     shell = pkgs.zsh;
     packages = with pkgs; [
       tree
     ];
   };

   programs.firefox.enable = true;

   programs.steam.enable = true;

   programs.thunar.enable = true;

   programs.zsh.enable = true;

   environment.sessionVariables = {
 	 NIXOS_OZONE_WL = "1";
   };

   services.displayManager = {
     sddm = {	
	enable = true;
	wayland.enable = true;
     };
     autoLogin = {
	enable = true;
	user = "nix";
     };
  };

   environment.systemPackages = with pkgs; [
	vim 
	wget
	git
	alacritty
	fuzzel
	fastfetch
	bibata-cursors
	google-chrome
	htop
	wine64
	winetricks
	discord
	feh
	unzip
	unrar
	xwayland-satellite
	wl-clipboard
	nmap

];

   # Font configuration with pixel fonts for matching the pixel art background
   fonts.packages = with pkgs; [
     nerd-fonts.jetbrains-mono
     cozette                    # Beautiful bitmap pixel font for UI
     nerd-fonts.terminess-ttf   # Alternative pixel font with nerd font icons (Terminus)
     scientifica                # Another great pixel font option
   ];

   fonts.fontconfig.enable = true;
   fonts.fontconfig.defaultFonts = {
     monospace = [ "Cozette" "JetBrains Mono Nerd Font" ];
     sansSerif = [ "JetBrains Mono Nerd Font" ];  # Chrome will use this instead of Cozette
     serif     = [ "JetBrains Mono Nerd Font" ];  # Chrome will use this instead of Cozette
   };

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  system.stateVersion = "25.11";

}
