{ pkgs, ... }:
{
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_LEFTMETA]
    '';
  };
  environment.etc."dual-function-keys.yaml".text = ''
    TIMING:
      # Time window for considering a keypress as a "tap" (in milliseconds)
      TAP_MILLISEC: 200
      DOUBLE_TAP_MILLISEC: 0

    MAPPINGS:
      - KEY: KEY_LEFTMETA
        # When tapped, send F13 (which we'll bind to open control center)
        TAP: KEY_F13
        # When held (as a modifier), keep it as Super
        HOLD: KEY_LEFTMETA
  '';
}

