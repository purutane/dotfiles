import os
import subprocess
from libqtile import hook

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()


def backlight(ope):
    def f(qtile):
        delta = 5
        # inc or dec brightness
        subprocess.run(
            "xbacklight -{ope} {delta}".format(ope=ope, delta=delta), shell=True)
        # notify brightness
        brightness = int(subprocess.run("xbacklight -get",
                         shell=True, stdout=subprocess.PIPE).stdout)
        subprocess.run(
            "notify-send Brightness {brightness}".format(brightness=brightness), shell=True)

    return f


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html

    # dmenu runcher
    Key([mod], "space",
        lazy.spawn("dmenu_run -p '> '"),
        desc="Run Launcher"
        ),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(),
    #    desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(),
    #    desc="Spawn a command using a prompt widget"),

    # backlight
    Key([], "XF86MonBrightnessUp", lazy.function(backlight("inc")),
        desc="Increase the screen brightness"),
    Key([], "XF86MonBrightnessDown", lazy.function(
        backlight("dec")), desc="Decrease the screen brightness"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layouts = [
    layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

colors = [['#EEEEEE', '#EEEEEE'],  # 0, Cultured
          ['#808080', '#808080'],  # 1, Gray Web
          ['#494949', '#494949'],  # 2, Davys Grey
          ['#2D2D2D', '#2D2D2D'],  # 3, Jet
          ['#1F1F1F', '#1F1F1F'],  # 4, Eerie Black
          ['#181818', '#181818'],  # 5, Eerie Black
          ['#151515', '#151515'],  # 6, Eerie Black
          ['#111111', '#111111']]  # 7, Smoky Black

widget_defaults = dict(
    # font='sans',
    font='NotoMono Nerd Font Mono',
    fontsize=20,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # Current Layout
                widget.Sep(
                    linewidth=0,
                    padding=20,
                    background=colors[7]
                ),
                widget.CurrentLayout(
                    foreground=colors[0],
                    background=colors[7]
                ),
                # Group Box
                widget.Sep(
                    linewidth=0,
                    padding=20,
                    background=colors[7]
                ),
                widget.GroupBox(
                    disable_drag='true',
                    active=colors[0],
                    inactive=colors[2],
                    background=colors[7],
                    highlight_method='line',
                    highlight_color=colors[4]
                ),
                # Window Name
                widget.Sep(
                    linewidth=0,
                    padding=20,
                    background=colors[7]
                ),
                widget.WindowName(
                    foreground=colors[0],
                    background=colors[7]
                ),
                # Systray
                widget.TextBox(
                    foreground=colors[3],
                    background=colors[7],
                    text='',
                    padding=0,
                    fontsize=20
                ),
                widget.Sep(
                    linewidth=0,
                    padding=10,
                    background=colors[3]
                ),
                widget.Systray(
                    foreground=colors[0],
                    background=colors[3],
                    padding=5,
                ),
                widget.Sep(
                    linewidth=0,
                    padding=10,
                    background=colors[3]
                ),
                # CPU
                widget.TextBox(
                    foreground=colors[4],
                    background=colors[3],
                    text='',
                    padding=0,
                    fontsize=20
                ),
                widget.CPU(
                    foreground=colors[0],
                    background=colors[4],
                    padding=10,
                    format='CPU:{load_percent:>4.1f}%'
                ),
                # MEM
                widget.TextBox(
                    foreground=colors[3],
                    background=colors[4],
                    text='',
                    padding=0,
                    fontsize=20
                ),
                widget.Memory(
                    foreground=colors[0],
                    background=colors[3],
                    padding=10,
                    measure_mem='G',
                    format='MEM:{MemUsed:>4.1f}{mm}/{MemTotal:>4.1f}{mm}'
                ),
                # NET
                widget.TextBox(
                    foreground=colors[4],
                    background=colors[3],
                    text='',
                    padding=0,
                    fontsize=20
                ),
                widget.Net(
                    foreground=colors[0],
                    background=colors[4],
                    padding=10,
                    format='NET:{down} ↑↓ {up}',
                ),
                # BAT
                widget.TextBox(
                    foreground=colors[3],
                    background=colors[4],
                    text='',
                    padding=0,
                    fontsize=20
                ),
                widget.Battery(
                    foreground=colors[0],
                    background=colors[3],
                    padding=10,
                    format='BAT: {char} {percent:>2.0%}'
                ),
                # CLOCK
                widget.TextBox(
                    foreground=colors[4],
                    background=colors[3],
                    text='',
                    padding=0,
                    fontsize=20
                ),
                widget.Clock(
                    foreground=colors[0],
                    background=colors[4],
                    padding=10,
                    format='%Y/%m/%d %H:%M'
                ),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                    linewidth=0,
                    padding=20,
                    background=colors[7]
                ),
                widget.CurrentLayout(
                    foreground=colors[4],
                    background=colors[7]
                ),
                widget.Sep(
                    linewidth=0,
                    padding=20,
                    background=colors[7]
                ),
                widget.GroupBox(
                    disable_drag='true',
                    foreground=colors[4],
                    background=colors[7],
                    highlight_method='line',
                ),
                # Window Name
                widget.Sep(
                    linewidth=0,
                    padding=20,
                    background=colors[7]
                ),
                widget.WindowName(
                    foreground=colors[4],
                    background=colors[7]
                ),
            ],
            24
        )
    )
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([home])
