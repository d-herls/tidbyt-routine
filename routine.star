load("render.star", "render")
load("time.star", "time")
load("encoding/base64.star", "base64")

DEFAULT_TZ = "America/Chicago"  # your household timezone

# ---- Icon images ----
# TV and bike icons as PNG base64 (data:image/png;base64, prefix removed)

TV_ICON = base64.decode("iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAEyGlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSfvu78nIGlkPSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQnPz4KPHg6eG1wbWV0YSB4bWxuczp4PSdhZG9iZTpuczptZXRhLyc+CjxyZGY6UkRGIHhtbG5zOnJkZj0naHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyc+CgogPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9JycKICB4bWxuczpBdHRyaWI9J2h0dHA6Ly9ucy5hdHRyaWJ1dGlvbi5jb20vYWRzLzEuMC8nPgogIDxBdHRyaWI6QWRzPgogICA8cmRmOlNlcT4KICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0nUmVzb3VyY2UnPgogICAgIDxBdHRyaWI6Q3JlYXRlZD4yMDI1LTEyLTA5PC9BdHRyaWI6Q3JlYXRlZD4KICAgICA8QXR0cmliOkV4dElkPjEwMGNjMTU1LTE4YmItNDExZC1hZDBjLWU5MjNmMTAxNWYyYjwvQXR0cmliOkV4dElkPgogICAgIDxBdHRyaWI6RmJJZD41MjUyNjU5MTQxNzk1ODA8L0F0dHJpYjpGYklkPgogICAgIDxBdHRyaWI6VG91Y2hUeXBlPjI8L0F0dHJpYjpUb3VjaFR5cGU+CiAgICA8L3JkZjpsaT4KICAgPC9yZGY6U2VxPgogIDwvQXR0cmliOkFkcz4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PScnCiAgeG1sbnM6ZGM9J2h0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvJz4KICA8ZGM6dGl0bGU+CiAgIDxyZGY6QWx0PgogICAgPHJkZjpsaSB4bWw6bGFuZz0neC1kZWZhdWx0Jz5VbnRpdGxlZCBkZXNpZ24gLSBUVjwvcmRmOmxpPgogICA8L3JkZjpBbHQ+CiAgPC9kYzp0aXRsZT4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRp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")

BIKE_ICON = base64.decode("iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAE1GlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSfvu78nIGlkPSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQnPz4KPHg6eG1wbWV0YSB4bWxuczp4PSdhZG9iZTpuczptZXRhLyc+CjxyZGY6UkRGIHhtbG5zOnJkZj0naHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyc+CgogPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9JycKICB4bWxuczpBdHRyaWI9J2h0dHA6Ly9ucy5hdHRyaWJ1dGlvbi5jb20vYWRzLzEuMC8nPgogIDxBdHRyaWI6QWRzPgogICA8cmRmOlNlcT4KICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0nUmVzb3VyY2UnPgogICAgIDxBdHRyaWI6Q3JlYXRlZD4yMDI1LTEyLTA5PC9BdHRyaWI6Q3JlYXRlZD4KICAgICA8QXR0cmliOkV4dElkPjk4ZTI1ODkyLTJmNzItNDQyNy05NGM5LTlkZmZkOGQzYzUxNDwvQXR0cmliOkV4dElkPgogICAgIDxBdHRyaWI6RmJJZD41MjUyNjU5MTQxNzk1ODA8L0F0dHJpYjpGYklkPgogICAgIDxBdHRyaWI6VG91Y2hUeXBlPjI8L0F0dHJpYjpUb3VjaFR5cGU+CiAgICA8L3JkZjpsaT4KICAgPC9yZGY6U2VxPgogIDwvQXR0cmliOkFkcz4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PScnCiAgeG1sbnM6ZGM9J2h0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvJz4KICA8ZGM6dGl0bGU+CiAgIDxyZGY6QWx0PgogICAgPHJkZjpsaSB4bWw6bGFuZz0neC1kZWZhdWx0Jz5VbnRpdGxlZCBkZXNpZ24gLSBCaWtlIHRvIFNjaG9vbDwvcmRmOmxpPgogICA8L3JkZjpBbHQ+CiAgPC9kYzp0aXRsZT4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxy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")

BREAKFAST_ICON = base64.decode("iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAEz2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSfvu78nIGlkPSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQnPz4KPHg6eG1wbWV0YSB4bWxuczp4PSdhZG9iZTpuczptZXRhLyc+CjxyZGY6UkRGIHhtbG5zOnJkZj0naHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyc+CgogPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9JycKICB4bWxuczpBdHRyaWI9J2h0dHA6Ly9ucy5hdHRyaWJ1dGlvbi5jb20vYWRzLzEuMC8nPgogIDxBdHRyaWI6QWRzPgogICA8cmRmOlNlcT4KICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0nUmVzb3VyY2UnPgogICAgIDxBdHRyaWI6Q3JlYXRlZD4yMDI1LTEyLTA5PC9BdHRyaWI6Q3JlYXRlZD4KICAgICA8QXR0cmliOkV4dElkPmZiZGYyOTJhLTZkOWMtNDVkNy1iZmY5LTUxMzRmNTNhOTZmNDwvQXR0cmliOkV4dElkPgogICAgIDxBdHRyaWI6RmJJZD41MjUyNjU5MTQxNzk1ODA8L0F0dHJpYjpGYklkPgogICAgIDxBdHRyaWI6VG91Y2hUeXBlPjI8L0F0dHJpYjpUb3VjaFR5cGU+CiAgICA8L3JkZjpsaT4KICAgPC9yZGY6U2VxPgogIDwvQXR0cmliOkFkcz4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PScnCiAgeG1sbnM6ZGM9J2h0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvJz4KICA8ZGM6dGl0bGU+CiAgIDxyZGY6QWx0PgogICAgPHJkZjpsaSB4bWw6bGFuZz0neC1kZWZhdWx0Jz5VbnRpdGxlZCBkZXNpZ24gLSBCcmVha2Zhc3Q8L3JkZjpsaT4KICAgPC9yZGY6QWx0PgogIDwvZGM6dGl0bGU+CiA8L3JkZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRl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")

DRESS_ICON = base64.decode("iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAE0WlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSfvu78nIGlkPSdXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQnPz4KPHg6eG1wbWV0YSB4bWxuczp4PSdhZG9iZTpuczptZXRhLyc+CjxyZGY6UkRGIHhtbG5zOnJkZj0naHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyc+CgogPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9JycKICB4bWxuczpBdHRyaWI9J2h0dHA6Ly9ucy5hdHRyaWJ1dGlvbi5jb20vYWRzLzEuMC8nPgogIDxBdHRyaWI6QWRzPgogICA8cmRmOlNlcT4KICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0nUmVzb3VyY2UnPgogICAgIDxBdHRyaWI6Q3JlYXRlZD4yMDI1LTEyLTA5PC9BdHRyaWI6Q3JlYXRlZD4KICAgICA8QXR0cmliOkV4dElkPjk0NjE1ODgyLTNkOTQtNDRmMS1iZTA0LThhNWY2OTQ2MDlmYzwvQXR0cmliOkV4dElkPgogICAgIDxBdHRyaWI6RmJJZD41MjUyNjU5MTQxNzk1ODA8L0F0dHJpYjpGYklkPgogICAgIDxBdHRyaWI6VG91Y2hUeXBlPjI8L0F0dHJpYjpUb3VjaFR5cGU+CiAgICA8L3JkZjpsaT4KICAgPC9yZGY6U2VxPgogIDwvQXR0cmliOkFkcz4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PScnCiAgeG1sbnM6ZGM9J2h0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvJz4KICA8ZGM6dGl0bGU+CiAgIDxyZGY6QWx0PgogICAgPHJkZjpsaSB4bWw6bGFuZz0neC1kZWZhdWx0Jz5VbnRpdGxlZCBkZXNpZ24gLSBHZXQgRHJlc3NlZDwvcmRmOmxpPgogICA8L3JkZjpBbHQ+CiAgPC9kYzp0aXRsZT4KIDwvcmRmOkRlc2NyaXB0aW9uPgoKIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PScnCiAgeG1sbnM6cGRmPSdodHRwOi8vbnMuYWRvYmUuY29tL3BkZi8xLjMvJz4KICA8cGRmOkF1dGhvcj5Eb3VnIEhlcmxpbmc8L3BkZjpBdXRob3I+CiA8L3JkZjpEZXNjcmlwdGlvbj4KCiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0nJwogIHhtbG5zOnhtcD0naHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyc+CiAgPHhtcDpDcmVhdG9yVG9vbD5DYW52YSAoUmVuZGVyZXIpIGRvYz1EQUc2LTFPZ0VQWSB1c2VyPVVBRF9QOXlUcWI0IGJyYW5kPURvdWcgSGVybGluZyYjMzk7cyBUZWFtIHRlbXBsYXRlPTwveG1wOkNyZWF0b3JUb29sPgogPC9yZGY6RGVzY3JpcHRpb24+CjwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9J3InPz57O1dFAAACd0lEQVR4nO2UXUiTURjH/+/mnB85VzraLEQLooyEtQsRRkl3dVmkJnYzYjc1kvKmCLZBIQhaYCGtmoVKQpeBYd0kiGjwtjTFi4hmtg+1bLot3d6P00WmCO+m60B6cX6X5/k4v8N5zuGww+G2W2AzmCAtTJAWJkgLE6SFCdLCBGlhgrSsCTottioAu7fRRQnCOS22MgBwWWz3ARxNk1y2uC8XwrIIlVYNIhHICSllsj4mQSOReQDx1aV8QasyxA05EKJJaPRaiEtJEJko1qtlgj1RCRyxDxEAcPHeajfvHUl5FPsQWeqoQttCBGd0+fiUEDAQjadKh6srgO6XnbVu3vsCAJwWW91le3MfbIdwLTiH7lITrgRmsSjJivWGiID2BzNQcR4rx3msXDq5v+gco3Bk5+PdrxUUZ6lxQV+wWcnGTfkFaFo/orvUhItfQ7htLEZ5tiZtjTqD/s9qSsz1nQeydh036jAnShBAUJ2Xi7GVxIZE59MAPo+NnuuZ6n81HQsLq8tfygpMH4oKjbW3KjS4YzTg7vefOF9YgJgsY1ZcH5fyUALNfeFA6/Djyi0LDoZ8EQDDdag44dOrivhcghlBxIwgIiqvX9PNniD870frW0aeDAyGfGszMB0LC/5oOHAwb+/EqTnd2d7DOfAnBXwTRQQFEUnyZxaP+JfR+ObH1KPXDxvcvHcy42/GabFdOt3oaAoUZys+qPF7ba63QV/7YMgXVYqfNJn1NSXmq5VN111K8f3zyYn+3o52N+/tAv7xHyT2oQYAx5RinMd6Y4s9WlKExjmP9flav8z1/i9MkBYmSAsTpIUJ0sIEaWGCtDBBWna84G/5F+deQ/MBxQAAAABJRU5ErkJggg==")

# ---- Routine definition ----

MORNING_ROUTINE = [
    {"start": "06:30", "end": "07:00", "label": "TV time",     "icon": "tv"},
    {"start": "07:00", "end": "07:15", "label": "Breakfast",   "icon": "breakfast"},
    {"start": "07:15", "end": "07:30", "label": "Get dressed", "icon": "dress"},
    {"start": "07:30", "end": "07:35", "label": "Bike to sch", "icon": "bike"},
]

# ---- Helpers ----

def parse_hhmm(s):
    parts = s.split(":")
    hour = int(parts[0])
    minute = int(parts[1])
    return hour * 60 + minute

def minutes_since_midnight(t):
    return t.hour * 60 + t.minute

def find_active_block(now, routine):
    now_min = minutes_since_midnight(now)
    for block in routine:
        start_min = parse_hhmm(block["start"])
        end_min = parse_hhmm(block["end"])
        if (start_min <= now_min) and (now_min < end_min):
            return block
    return None

def icon_widget(icon_name):
    # scale everything to 20x20 so it fits nicely
    if icon_name == "tv":
        return render.Image(src = TV_ICON, width = 20, height = 20)
    if icon_name == "bike":
        return render.Image(src = BIKE_ICON, width = 20, height = 20)
    if icon_name == "breakfast":
        return render.Image(src = BREAKFAST_ICON, width = 20, height = 20)
    if icon_name == "dress":
        return render.Image(src = DRESS_ICON, width = 20, height = 20)
    # default fallback
    return render.Text(content = ":)", font = "6x13")

# ---- Main entrypoint ----

def main(config):
    tz = config.get("$tz") or DEFAULT_TZ
    now = time.now().in_location(tz)

    routine = MORNING_ROUTINE
    block = find_active_block(now, routine)

    if block == None:
        title = "Free time"
        subtitle = ""
        icon_name = "tv"  # or whatever default icon you like
    else:
        title = block["label"]
        subtitle = "%s–%s" % (block["start"], block["end"])
        icon_name = block["icon"]

    time_str = now.format("3:04")  # e.g. "10:12"

    return render.Root(
        child = render.Column(
            expanded = True,
            main_align = "start",   # <-- top-align everything
            cross_align = "center",
            children = [
                render.Row(
                    cross_align = "center",
                    children = [
                        render.Box(
                            width = 20,
                            height = 20,
                            color = "#202020",
                            child = icon_widget(icon_name),
                        ),
                        render.Box(width = 2, height = 1),
                        render.Text(
                            content = time_str,
                            font = "6x13",
                        ),
                    ],
                ),
                render.Box(width = 1, height = 2),  # small spacer
                render.Text(
                    content = title,
                    font = "5x8",
                ),
                render.Text(
                    content = subtitle,
                    font = "5x8",
                ),
            ],
        ),
    )