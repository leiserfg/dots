# yaourt -S i3pystatus i3ipc-python python-colour

from i3pystatus import Status
from i3pystatus.weather import weathercom

status = Status()
status.register("clock", format="%a %-d %l:%M", interval=30)

# status.register("moc",
#     # format="%a %-d %l:%M",
#     )

# status.register(
#     "weather",
#     log_level=10,
#     format="{current_temp}{temp_unit}[ {icon}][ {update_error}]",
#     colorize=True,
#     hints={"markup": "pango"},
#     backend=weathercom.Weathercom(
#         location_code="GMXX0007:1:GM",  # Berlin
#         units="metric",
#         update_error='<span color="#ff0000">!</span>',
#     ),
# )

status.register(
    "battery",
    color="#ffffff",
    full_color="#006600",
    charging_color="#006600",
    critical_color="#660000",
    interval=5,
    format="[{status} ]{percentage_design:.2f}%",
    alert=True,
    alert_percentage=15,
    status={"DPL": "DPL", "DIS": "↓", "CHR": "↑", "FULL": ""},
)

status.register("window_title", format="{title}")
status.run()
