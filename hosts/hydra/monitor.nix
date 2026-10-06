let
  # One physical monitor connected twice. EDID differs between its inputs.
  displayPort = "Xiaomi Corporation Mi Monitor Unknown";
  hdmi = "Xiaomi Corporation Mi Monitor 0000000000000";
in
{
  outputs = {
    "${displayPort}" = {
      mode = {
        width = 3440;
        height = 1440;
        refresh = 144.0;
      };
      scale = 1.0;
      position = {
        x = 0;
        y = 0;
      };
    };
    "${hdmi}".enable = false;
  };

  # A custom greeter config replaces its default, so retain the greeter basics.
  greeterConfig = ''
    hotkey-overlay {
      skip-at-startup
    }
    environment {
      DMS_RUN_GREETER "1"
    }
    gestures {
      hot-corners {
        off
      }
    }
    layout {
      background-color "#000000"
    }
    output "${displayPort}" {
      mode "3440x1440@144.000"
      scale 1
      position x=0 y=0
    }
    output "${hdmi}" {
      off
    }
  '';
}
