{ config, pkgs, ... }:
let
    settings = import ./settings.nix;
in {
    programs.waybar = {
        enable = true;
        settings = [{
            layer = "top";
            margin = "8 8 0 8";

            modules-left = ["wireplumber" "mpris" "custom/fcitx5"];
            modules-center = ["hyprland/workspaces"];
            modules-right = ["group/hardware" "clock"];

            # left
            wireplumber = {
                format = "{icon} {volume}%";
                format-muted = "  {volume}%";
                format-icons = [" " " " " "];
                scroll-step = 3;
                max-volume = 150;
                on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            };
            mpris = {
                format = "{status_icon} {position}";
                tooltip-format = "{player} ({status}) {dynamic}";
                status-icons = {
                    playing = " ";
                    paused = " ";
                    stopped = " ";
                };
                interval = 1;
            };
            "custom/fcitx5" = {
                format = "󰌌  {}";
                tooltip-format = "";
                exec = "~/.config/waybar/fcitx5.sh";
                interval = 1;
            };

            # center
            "hyprland/workspaces" = {
                format = "{icon}";
                format-icons = {
                    special = "*";
                };
                show-special = true;
                special-visible-only = true;
                on-scroll-up = "hyprctl dispatch workspace e-1";
                on-scroll-down = "hyprctl dispatch workspace e+1";
            };

            # right
            "group/hardware" = {
                orientation = "horizontal";
                modules = ["network" "battery" "cpu" "memory" "temperature"];
            };
            network = {
                format-wifi = "  {essid} {signalStrength}%";
                format-ethernet = "  {bandwidthTotalBits}";
                format-disconnected = " ";
                format = "";
                tooltip-format-wifi = "  {signalStrength}%\n  {bandwidthUpBits}\n  {bandwidthDownBits}";
                tooltip-format-ethernet = "  {bandwidthUpBits}\n  {bandwidthDownBits}";
                max-length = 50;
                interval = 5;
            };
            battery = {
                format = "  {capacity:2}%";
                interval = 5;
            };
            cpu = {
                format = "  {usage:2}%";
                interval = 5;
            };
            memory = {
                format = "  {used:0.1f}G";
                tooltip-format = "Phys: {used:0.1f}G / {total:0.1f}G ({percentage:2}%)\nSwap: {swapUsed:0.1f}G / {swapTotal:0.1f}G ({swapPercentage:2}%)";
                interval = 5;
            };
            temperature = {
                format = "  {temperatureC:2}°C";
                tooltip-format = "";
                interval = 5;
                critical-threshold = 80;
                thermal-zone = settings.thermal_zone;
            };
            clock = {
                tooltip-format = "{:%Y-%m-%d}\n\n{calendar}";
                calendar = {
                    mode = "month";
                    mode-mon-col = 4;
                    format = {
                        months = "<span color='#9dd49d'><b>{}</b></span>";
                        weekdays = "<span color='#a1ced6'>{}</span>";
                        today = "<b>{}</b>";
                    };
                };
                actions = {
                    on-click-right = "mode";
                    on-scroll-up = "shift_up";
                    on-scroll-down = "shift_down";
                };
            };
        }];
        style = ./dotfiles/waybar/style.css;
    };
}
