{ config, pkgs, ... }:
{
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";

        fcitx5.addons = with pkgs; [
            # important stuff
            fcitx5-gtk
            qt6Packages.fcitx5-qt

            # config tool
            # qt6Packages.fcitx5-configtool

            # input methods
            fcitx5-rime
            rime-data
            fcitx5-mozc

            # theme
            fcitx5-fluent
        ];
        fcitx5.settings.globalOptions = {
            "Hotkey" = {
                "EnumerateWithTriggerKeys" = true;
                "EnumerateSkipFirst" = false;
                "ModifierOnlyKeyTimeout" = 250;

                "ActivateKeys" = "";
                "DeactivateKeys" = "";
                "EnumerateForwardKeys" = "";
                "EnumerateBackwardKeys" = "";
            };
            "Hotkey/TriggerKeys" = {
                "0" = "Super+space";
            };
            "Hotkey/AltTriggerKeys" = {
                "0" = "Shift_L";
            };
            "Hotkey/EnumerateGroupForwardKeys" = {};
            "Hotkey/EnumerateGroupBackwardKeys" = {};
            "Hotkey/PrevPage" = {
                "0" = "Up";
            };
            "Hotkey/NextPage" = {
                "0" = "Down";
            };
            "Hotkey/PrevCandidate" = {
                "0" = "Tab";
            };
            "Hotkey/NextCandidate" = {
                "0" = "Shift+Tab";
            };
            "Hotkey/TogglePreedit" = {};

            "Behavior" = {
                "ActivateByDefault" = false;
                "resetStateWhenFocusIn" = "No";
                "ShareInputState" = "No";
                "PreeditEnabledByDefault" = true;
                "ShowInputMethodInformation" = true;
                "showInputMethodInformationWhenFocusIn" = false;
                "CompactInputMethodInformation" = true;
                "ShowFirstInputMethodInformation" = true;
                "DefaultPageSize" = 5;
                "OverrideXkbOption" = false;
                "CustomXkbOption" = false;
                "EnabledAddons" = "";
                "DisabledAddons" = "";
                "PreloadInputMethod" = true;
                "AllowInputMethodForPassword" = false;
                "ShowPreeditForPassword" = false;
                "AutoSavePeriod" = 30;
            };
        };
        fcitx5.settings.inputMethod = {
            GroupOrder = {
                "0" = "Default";
            };
            "Groups/0" = {
                "Name" = "Default";
                "Default Layout" = "us";
                "DefaultIM" = "rime";
            };
            "Groups/0/Items/0" = {
                "Name" = "keyboard-us";
            };
            "Groups/0/Items/1" = {
                "Name" = "rime";
            };
            "Groups/0/Items/2" = {
                "Name" = "mozc";
            };
        };
        fcitx5.settings.addons.classicui.globalSection = {
            "Vertical Candidate List" = false;
            "WheelForPaging" = true;
            "Font" = "Noto Sans CJK HK 11";
            "MenuFont" = "Noto Sans CJK HK 11";
            "TrayFont" = "Noto Sans CJK HK Medium 11";
            "TrayOutlineColor" = "#000000";
            "TrayTextColor" = "#ffffff";
            "PreferTextIcon" = false;
            "ShowLayoutNameInIcon" = true;
            "UseInputMethodLanguageToDisplayText" = true;
            "Theme" = "FluentDark";
            "DarkTheme" = "FluentDark";
            "UseDarkTheme" = false;
            "UseAccentColor" = true;
            "PerScreenDPI" = false;
            "ForceWaylandDPI" = 0;
            "EnableFractionalScale" = true;
        };
        fcitx5.settings.addons.rime.globalSection = {
            "PreeditMode" = "Commit preview";
            "InputState" = "All";
            "PreeditCursorPositionAtBeginning" = true;
            "SwitchInputMethodBehavior" = "Commit commit preview";
        };
        fcitx5.waylandFrontend = true;
    };
}
