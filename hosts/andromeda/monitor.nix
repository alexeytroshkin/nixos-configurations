let
  internal = "Tianma Microelectronics Ltd. 0x2038 0x00000001";
  external = "Samsung Electric Company Odyssey G95NC HNTX200010";
in
{
  inherit internal external;
  outputs = {
    "${internal}" = {
      mode = {
        width = 2560;
        height = 1600;
        refresh = 240.0;
      };
      scale = 1.5;
      position = {
        x = 0;
        y = 0;
      };
      layout.always-center-single-column = true;
    };
    "${external}" = {
      mode = {
        width = 7680;
        height = 2160;
        refresh = 119.997;
      };
      scale = 1.5;
      position = {
        x = 0;
        y = 0;
      };
      layout.always-center-single-column = true;
    };
  };
}
