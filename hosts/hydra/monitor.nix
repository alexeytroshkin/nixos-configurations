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

}
