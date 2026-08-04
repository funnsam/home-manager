{ config, pkgs, ... }:
let
    settings = import ./settings.nix;
in {
    home.username = "funnsam";
    home.homeDirectory = "/home/funnsam";

    imports = [ ./input.nix ./waybar.nix ];

    gtk = {
        enable = true;
        theme.package = pkgs.fluent-gtk-theme;
        theme.name = "Fluent-Dark";
    };
    qt = {
        enable = true;
        style.name = "Fusion";
    };

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        # compositor stuff
        bibata-cursors
        hyprpaper

        # status bar stuff
        waybar
        playerctl

        # utils used in hotkeys
        grim
        jq
        wl-clipboard

        # useful stuff triggered by hotkeys
        dunst
        ghostty
        hyprpicker
        nemo
        tofi

        # ui config stuff
        fluent-gtk-theme

        # gui apps
        discord

        # games
        steam
        ckan
        prismlauncher
    ];
    programs.zsh = {
        enable = true;
        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
                "git"
                "z"
            ];
        };
        initContent = "fastfetch";
    };

    home.file = {
        ".tmux.conf".source                         = dotfiles/tmux.conf;
        ".config/dunst/dunstrc".source              = dotfiles/dunstrc;
        ".config/fastfetch/config.jsonc".source     = dotfiles/fastfetch.jsonc;
        ".config/ghostty/config".source             = dotfiles/ghostty;

        ".config/hypr/hyprland.lua".source          = dotfiles/hypr/hyprland_ + "${settings.mode}.lua";
        ".config/hypr/hyprland_common.lua".source   = dotfiles/hypr/hyprland_common.lua;
        ".config/hypr/hyprpaper.conf".source        = dotfiles/hypr/hyprpaper.conf;
        ".config/hypr/wallpaper.png".source         = dotfiles/hypr/wallpaper.png;

        ".config/tofi/config".source                = dotfiles/tofi;
        ".config/waybar/fcitx5.sh".source           = dotfiles/waybar/fcitx5.sh;
    };

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    programs.home-manager.enable = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "26.05"; # Please read the comment before changing.
}
