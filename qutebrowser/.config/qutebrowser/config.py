config.load_autoconfig(False)
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True
c.editor.command = [
    "foot",
    "nvim",
    "{file}",
    "+startinsert",
    "+call cursor({line}, {column})",
]
