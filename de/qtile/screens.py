from libqtile import bar, layout, qtile
from libqtile import widget as d_widget
from qtile_extras import widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from qtile_extras.widget.bluetooth import Bluetooth
from qtile_extras.widget.decorations import RectDecoration, BorderDecoration
from colors import colors
from utils import *


widget_radius = 18
fontsize = 50
wallpaper = "~/.config/wallpapers/ancientcastle.jpg"

sep_config = {
        "size_percent": 0,
        "padding": 8,
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    borderwidth=0,
                    block_highlight_text_color=colors["color3"],
                    active=colors["foreground"],
                    inactive=colors["color8"],
                    disable_drag=True,
                    fontsize=fontsize,
                    radius=True,
                    padding_x=0,
                    margin_x=50,
                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ]
                ),
                widget.Spacer(),
                widget.Net(
                    format='{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}',
                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ]
                ),
                widget.Sep(**sep_config),
                widget.Clock(
                    format="󰥔 %I:%M",
                    foreground=colors["color4"],
                    fontsize=fontsize,
                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ], 
                ),
                widget.Sep(**sep_config),
                # widget.Wlan(
                #     interface="wlp1s0",
                # ),
                widget.Memory(
                    fontsize=fontsize,
                    format="󰍛 {MemUsed:.0f}{mm}",
                    foreground=colors["color5"],

                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ]
                ),
                widget.Sep(**sep_config),
                widget.CPU(
                    fontsize=fontsize,
                    format="󰘚 {load_percent}%",
                    foreground=colors["color6"],

                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ]
                ),
                widget.Sep(**sep_config),
                widget.Sep(**sep_config),
                widget.Battery(
                    fontsize=fontsize,
                    format="{char} {percent:2.0%}",
                    charge_char="󰂄",
                    discharge_char="󰁹",
                    empty_char="󰂃",
                    full_char="󰁹",
                    show_short_text=False,
                    not_charging_char="󰁹",
                    foreground=colors["color2"],

                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ]
                ),
                widget.Sep(**sep_config),
                widget.Volume(
                    device="pulse",
                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ], 
                ),
                widget.Sep(**sep_config),
                widget.Backlight(
                    fontsize=fontsize,
                    fmt="󰃚 {}",
                    backlight_name=get_backlight_device(),
                    foreground=colors["color3"],

                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ]
                ),
                widget.Sep(**sep_config),
                widget.KeyboardLayout(
                    fontsize=fontsize,
                    configured_keyboards=['us','ru'],
                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                            padding_y=0
                        )
                    ]
                ),
            ],
            fontsize,
            opacity = 1,
            background="#00000000",
            # border_width=[0, 0, 0, 0],
            margin=[10, 10, 10, 10],
            # border_color=["000000", "000000", "000000", "000000"],
        ),
        x11_drag_polling_rate = 120,
        wallpaper = wallpaper,
        wallpaper_mode = "fill",
    ),
]
