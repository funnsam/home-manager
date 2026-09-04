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

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-hyprland
            xdg-desktop-portal-gtk
        ];
        config.common.default = [ "hyprland" "gtk" ];
    };

    home.shell.enableZshIntegration = true;
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
        shellAliases = {
            zigb = "zig build -fincremental";
            zigstd = "zig std --port 3000";
        };
    };

    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
        # compositor stuff
        bibata-cursors
        hyprpaper

        # status bar stuff
        dunst
        waybar
        playerctl

        # utils used in hotkeys
        grim
        jq
        wl-clipboard

        # useful stuff triggered by hotkeys
        ghostty
        hyprpicker
        nemo

        # cli stuff used in neovim
        ripgrep
        tinyxxd

        # ui config stuff
        fluent-gtk-theme

        # gui apps
        discord
        inkscape
        feh
        gimp
        gparted

        # games
        ckan
        osu-lazer-bin
        prismlauncher

        # hw dev
        freecad
        kicad

        # sw dev
        android-studio
        android-tools
    ];
    programs.tofi.enable = true;
    programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
            wlrobs
        ];
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

    systemd.user.services.open-link = {
        Unit = {
            Description = "Open Link server service";
            After = [ "network-online.target" ];
            Wants = [ "network-online.target" ];
        };
        Service = {
            ExecStart = "${pkgs.writeShellScriptBin "run-service" ''
                exec ${pkgs.nix}/bin/nix run github:funnsam/openlink
            ''}/bin/run-service";
            Restart = "on-failure";
        };
        Install = {
            WantedBy = [ "default.target" ];
        };
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
