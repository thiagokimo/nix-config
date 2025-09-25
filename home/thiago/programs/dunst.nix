{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        format = "<b>%s %p</b>\n%b";
        sort = "yes";
        indicate_hidden = true;
        idle_threshold = 0;
        width = 300;
        alignment = "center";
        show_age_threshold = 40;
        sticky_history = "yes";
        follow = "mouse";
        word_wrap = "yes";
        separator_height = 2;
        horizontal_padding = 10;
        monitor = 0;
        frame_width = 3;
        offset = "(20,20)";
      };
      urgency_low = {
        timeout = 7;
      };
      urgency_normal = {
        timeout = 7;
      };
      urgency_critical = {
        timeout = 7;
      };
    };
  };
}
