local terminal = "ghostty"
local fileManager = "nemo"
local menu = "tofi-drun --drun-launch=true"
local mainMod = "SUPER"

local M = {}
function M.setup(fancy)
    -- startup service
    hl.on("hyprland.start", function ()
        hl.exec_cmd("hyprpaper")
        hl.exec_cmd("waybar")
        hl.exec_cmd("fcitx5")
    end)

    -- monitors
    hl.monitor({
        output   = "",
        mode     = "preferred",
        position = "auto",
        scale    = "1",
    })
    hl.monitor({
        output   = "HDMI-A-2",
        mode     = "1920x1080@60",
        position = "0x0",
        scale    = "1",
    })

    -- https://github.com/ful1e5/Bibata_Cursor
    hl.env("XCURSOR_SIZE", 12)
    hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")

    hl.config({
        general = {
            gaps_in = 5,
            gaps_out = 20,

            border_size = 2,
            col = {
                active_border   = "rgba(9dd49dff)",
                inactive_border = "rgba(424940ff)",
            },
            resize_on_border = false,

            -- TODO: make it work one day
            -- allow_tearing = false,

            layout = "dwindle",
        },
        decoration = {
            rounding = 0,
            dim_special = 0.5,

            shadow = {
                enabled = fancy,
                range = 16,
                render_power = 3,
                color = "rgba(0000007f)",
            },

            blur = {
                enabled = fancy,
                size = 3,
                passes = 1,

                vibrancy = 0.1696,
                popups = true,
            },
        },

        dwindle = {
            preserve_split = true
        },
        master = {
            new_status = "master",
        },

        misc = {
            disable_hyprland_logo = false,
        },

        input = {
            kb_layout = "us",
            kb_variant = "",
            kb_model = "",
            kb_options = "",
            kb_rules = "",

            follow_mouse = 1,
            sensitivity = 0,
        },
    })

    -- animations
    hl.curve("easeOutCubic", { type = "bezier", points = {{0.33, 1}, {0.68, 1}} })
    hl.animation({ leaf = "windows",          enabled = fancy, speed = 3, bezier = "easeOutCubic", style = "slide" })
    hl.animation({ leaf = "layers",           enabled = fancy, speed = 3, bezier = "easeOutCubic" })
    hl.animation({ leaf = "border",           enabled = fancy, speed = 3, bezier = "easeOutCubic" })
    hl.animation({ leaf = "workspaces",       enabled = fancy, speed = 3, bezier = "easeOutCubic" })
    hl.animation({ leaf = "zoomFactor",       enabled = fancy, speed = 3, bezier = "easeOutCubic" })
    hl.animation({ leaf = "specialWorkspace", enabled = fancy, speed = 3, bezier = "easeOutCubic", style = "fade" })

    hl.gesture({
        fingers = 3,
        direction = "horizontal",
        action = "workspace",
    })

    -- hyprland control
    hl.bind(mainMod .. " + SHIFT + E",  hl.dsp.exit())
    hl.bind(mainMod .. " + SHIFT + T",  hl.dsp.exec_cmd("grim - | wl-copy"))
    hl.bind(mainMod .. " + T",          hl.dsp.exec_cmd("grim -g \"$(hyprctl activewindow -j | jq -r \'\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"\')\" - | wl-copy"))
    hl.bind(mainMod .. " + C",          hl.dsp.exec_cmd("hyprpicker -a"))

    -- launch things
    hl.bind(mainMod .. " + Return",     hl.dsp.exec_cmd(terminal))
    hl.bind(mainMod .. " + F",          hl.dsp.exec_cmd(fileManager))
    hl.bind(mainMod .. " + R",          hl.dsp.exec_cmd(menu))

    -- window ops
    hl.bind(mainMod .. " + SHIFT + Q",  hl.dsp.window.close())
    hl.bind(mainMod .. " + SHIFT + V",  hl.dsp.window.float())
    hl.bind(mainMod .. " + P",          hl.dsp.window.pseudo())
    hl.bind(mainMod .. " + SHIFT + F",  hl.dsp.window.fullscreen())
    hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

    -- window motion
    local directions = {"left", "right", "up", "down"}
    for _, d in ipairs(directions) do
        local s = string.sub(d, 1, 1)
        hl.bind(mainMod .. " + " .. d,         hl.dsp.focus({ direction = s }))
        hl.bind(mainMod .. " + SHIFT + " .. d, hl.dsp.window.move({ direction = s }))
    end

    -- workspace motion
    for i = 1, 10 do
        local k = i % 10
        hl.bind(mainMod .. " + " .. tostring(k),         hl.dsp.focus({ workspace = i }))
        hl.bind(mainMod .. " + SHIFT + " .. tostring(k), hl.dsp.window.move({ workspace = i }))
    end
    hl.bind(mainMod .. " + grave",     hl.dsp.workspace.toggle_special("htop"))

    -- multimedia keys volume
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"))
    hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

    hl.layer_rule({
        name = "blur-layers",
        match = { namespace = "(launcher|waybar)" },
        blur = true,
        ignore_alpha = 0.01,
    })

    hl.workspace_rule({
        workspace = "special:htop",
        on_created_empty = "[workspace special:htop] " .. terminal .. " -e htop",
    })
end

return M
