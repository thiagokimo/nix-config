rec {
  hexToDec = h: let
    mapping = {
      "0" = 0;
      "1" = 1;
      "2" = 2;
      "3" = 3;
      "4" = 4;
      "5" = 5;
      "6" = 6;
      "7" = 7;
      "8" = 8;
      "9" = 9;
      "a" = 10;
      "b" = 11;
      "c" = 12;
      "d" = 13;
      "e" = 14;
      "f" = 15;
      "A" = 10;
      "B" = 11;
      "C" = 12;
      "D" = 13;
      "E" = 14;
      "F" = 15;
    };
    c1 = builtins.substring 0 1 h;
    c2 = builtins.substring 1 1 h;
  in
    (mapping.${c1} * 16) + mapping.${c2};

  hexToRgb = hex: let
    r = hexToDec (builtins.substring 0 2 hex);
    g = hexToDec (builtins.substring 2 2 hex);
    b = hexToDec (builtins.substring 4 2 hex);
  in "${toString r};${toString g};${toString b}";

  ansi = rgb: "\\u001b[38;2;${rgb}m";
  reset = "\\u001b[0m";
}
