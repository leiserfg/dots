import os
import signal
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()


@lazy.function
def kill_app(qtile):
    pid = qtile.current_window.get_pid()
    os.kill(pid, signal.SIGTERM)


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack"),
    Key(
        [mod],
        "Return",
        lazy.spawn(f"sh -c 'exec {terminal} -d $(xcwd || echo .)'"),
        desc="Launch terminal",
    ),
    Key([mod], "slash", lazy.spawn("firefox"), desc="Firefox"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "q", kill_app, desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Togle fullscreen"),
    # Globals
    Key([mod], "r", lazy.restart(), desc="Reload the config"),
    Key(
        [mod],
        "0",
        lazy.spawn(os.path.expanduser("~/.local/bin/rofi_power")),
        desc="Power management",
    ),
    Key(
        [mod],
        "g",
        lazy.spawn(
            """
             gamemoderun sh -c " ls ~/Games/*/*start.sh  --quoting-style=escape \
                |xargs -n 1 -d '\n' dirname \
                |xargs -d '\n' -n 1 basename \
                |rofi -dmenu -i  \
                |xargs  -d '\n'  -I__  bash -c  'exec bash  $HOME/Games/__/*start.sh'"
            """
        ),
        desc="Games List",
    ),
    Key(
        [mod],
        "d",
        lazy.spawn(
            "rofi -combi-modi window,drun,ssh -show combi -modi combi -show-icons"
        ),
        desc="App launcher",
    ),
]
groups_names = "₁ ₂ ₃ 󰍥₄ ₅ ₆ ₇ ₈ ₉".split()

groups_rules = {
    1: [Match(wm_class="Navigator")],
    2: [Match(wm_class="Slack")],
    4: [Match(wm_class="TelegramDesktop")],
}

groups = [Group(n, matches=groups_rules.get(i + 1)) for i, n in enumerate(groups_names)]

for i, g in enumerate(groups):
    key = str(i + 1)
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                key,
                lazy.group[g.name].toscreen(toggle=True),
                desc="Switch to group {}".format(g.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                key,
                lazy.window.togroup(g.name),
                desc=f"Move focused window to group {g.name}",
            ),
        ]
    )


layout_config = dict(
    single_border_width=0, single_margin=0, border_focus="#AAAACC", margin=2
)

layouts = [
    layout.MonadTall(**layout_config),
    layout.MonadWide(**layout_config),
]

widget_defaults = dict(
    font="sans",
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper=os.path.expanduser("~/wall.png"),
        top=bar.Bar(
            [
                widget.GroupBox(
                    hide_unused=True,
                    highlight_method="line",
                    rounded=False,
                    this_current_screen_border="AAAACC",
                ),
                widget.Prompt(),
                widget.Spacer(),
                widget.WindowName(width=bar.CALCULATED, max_chars=60),
                widget.Spacer(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # widget.Net(prefix='M'),
                # widget.Battery(format="{char} {percent:2.0%}"),
                # widget.PulseVolume(
                #     update_interval=0.2,
                #     volume_app="pavucontrol",
                # ),
                widget.Systray(),
                # widget.StatusNotifier(), # Some progrms don't work the "new" way OMG!
                widget.Clock(format="%d-%m-%y %a %I:%M"),
            ],
            24,
        ),
    ),
]

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
# Drag floating layouts.
floating_layout = layout.Floating(
    float_rules=(
        layout.Floating.default_float_rules
        # Run the utility of `xprop` to see the wm class and name of an X client.
        + [
            Match(title=title)
            for title in [
                "PureRef" "MEGAsync",
                "gmic_qt",
                "Preferences",
            ]
        ]
        + [
            Match(wm_class=cls)
            for cls in [
                "Pavucontrol",
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "PureRef",
                "Sxiv",
                "xtightvncviewer",
                "PureRef",
                "MEGAsync",
                "gmic_qt",
                "Pavucontrol",
                "vokoscreenNG",
                "file_progress",
                "confirm",
                "dialog",
                "download",
                "error",
                "notification",
                "splash",
                "toolbar",
            ]
        ]
    )
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

wmname = "LG3D"

# Hooks

startup_script = os.path.expanduser("~/bin/autostart.sh")


@hook.subscribe.startup
def autostart():
    subprocess.run([startup_script])

sticky_windows = set()

sticky_rules = [
    Match(wm_class="Dragon"),
    Match(title="Picture-in-Picture"),
]

@hook.subscribe.setgroup
def move_sticky_windows():
    for window in sticky_windows:
        window.togroup()


@hook.subscribe.client_killed
def remove_sticky_windows(window):
    if window in sticky_windows:
        sticky_windows.remove(window)

@hook.subscribe.client_managed
def auto_sticky_windows(window):
    for r in sticky_rules:
        if r.compare(window):
            sticky_windows.add(window)

# @hook.subscribe.screen_change
# def set_screens(qtile, event):
#     if not os.path.exists(os.path.expanduser('~/NO-AUTORANDR')):
#         subprocess.run(["autorandr", "--change"])
#         qtile.cmd_restart()
