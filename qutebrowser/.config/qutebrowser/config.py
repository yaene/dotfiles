config.load_autoconfig(False)
c.colors.webpage.preferred_color_scheme = "dark"
c.editor.command = [
    "foot",
    "nvim",
    "{file}",
    "+startinsert",
    "+call cursor({line}, {column})",
]
