from libqtile import bar, layout, qtile, widget
from libqtile.lazy import lazy
from colors import colors
import autostart

from keys import mod, keys
from screens import screens


layouts = [
    layout.Columns(
        border_focus_stack=["#d75f5f", "#8f3d3d"],
        border_width=4,
        single_border_width=0,
        margin=8,
        border_focus=colors["color7"],
        border_normal=colors["color8"],
    ),
    layout.Max(margin=8),
]

widget_defaults = dict(
    font="Hack Nerd Font Mono",
    fontsize=30,
    padding=20,
)

extension_defaults = widget_defaults.copy()


dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"
