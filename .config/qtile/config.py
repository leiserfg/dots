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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "slash", lazy.spawn("firefox"), desc="Firefox"),
    # Toggle between different layouts as defined below
    # Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "q", kill_app, desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Togle fullscreen"),
    # Globals
    Key([mod], "r", lazy.restart(), desc="Reload the config"),
    Key([mod], "0", lazy.spawn("rofi_power"), desc="Power management"),
    Key(
        [mod],
        "g",
        lazy.spawn(
            """
        sh -c "lutris -lo 2>/dev/null |cut -f 1,2 -d '|' | rofi -dmenu -i|
        cut -f 1 -d '|'  | xargs -I__ lutris lutris:rungameid/__"
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
    )
    # Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(),
    #     desc="Spawn a command using a prompt widget"),
]
groups_names = "₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉".split()
groups_rules = {1: [Match(wm_class="Firefox")], 4: [Match(wm_class="TelegramDesktop")]}

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


layout_config = dict(single_border_width=0, border_focus="#AAAACC", margin=2)
layouts = [
    layout.MonadTall(**layout_config),
]

widget_defaults = dict(
    font="sans",
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
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
                widget.WindowName(width=bar.CALCULATED),
                widget.Spacer(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # widget.Net(prefix='M'),
                widget.PulseVolume(
                    emoji=True, mouse_callbacks={"Button3": lazy.spawn("pavucontrol")}
                ),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
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
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(title="Zathura"),
        Match(title="PureRef"),
        Match(title="MEGAsync"),
        Match(title="gmic_qt"),
        # Match(wm_class='ssh-askpass'),  # ssh-askpass
        # Match(title='branchdialog'),  # gitk
        # Match(title='pinentry'),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

wmname = "LG3D"

# Hooks

startup_script = os.path.expanduser("~/.config/qtile/autostart.sh")


@hook.subscribe.startup
def autostart():
    subprocess.run([startup_script])