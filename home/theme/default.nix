{ inputs, config, pkgs, ... }:

{
  # Cursor styling
  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };

  # Icon styling
  gtk.iconTheme = {
    name = "Tela-red-dark";
    package = pkgs.tela-icon-theme;
  };

  # Theme styling
  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Red-Dark";
      package = pkgs.orchis-theme;
    };
  };
}

