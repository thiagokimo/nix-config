# Pixelbook Go
# 
# This setup contains what I would use in a linux container/generic computer
# 
{
  lib,
  config,
  ...
}: {
  imports = [
    ./base
  ];

  home = {
    username = "thiago";
  };
}
