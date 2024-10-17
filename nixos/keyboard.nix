{config, ...}: {
  services.xserver.xkb = {
    layout = config.var.keyboardLayout;
    variant = config.var.keyboardVariant;
  };
}
