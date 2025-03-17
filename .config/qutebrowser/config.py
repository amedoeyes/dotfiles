from types import SimpleNamespace


config.load_autoconfig(False)

config.bind(",v", "spawn mpv {url}")
config.bind(",V", "hint links spawn mpv {hint-url}")

c.spellcheck.languages = ["en-US"]

c.tabs.show = "multiple"

c.content.blocking.method = "both"

c.content.blocking.adblock.lists += [
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
]

c.auto_save.session = True

c.editor.command = ["footclient", "nvim", "{}"]


palette = SimpleNamespace(
    hex00="#000000",
    hex01="#101010",
    hex02="#202020",
    hex03="#303030",
    hex04="#404040",
    hex05="#505050",
    hex06="#606060",
    hex07="#707070",
    hex08="#808080",
    hex09="#808080",
    hex10="#a0a0a0",
)


c.colors.completion.fg = palette.hex10
c.colors.completion.even.bg = palette.hex00
c.colors.completion.odd.bg = palette.hex00
c.colors.completion.match.fg = palette.hex10
c.colors.completion.scrollbar.bg = palette.hex01
c.colors.completion.scrollbar.fg = palette.hex03

c.colors.completion.category.bg = palette.hex00
c.colors.completion.category.border.bottom = palette.hex04
c.colors.completion.category.border.top = palette.hex04
c.colors.completion.category.fg = palette.hex10

c.colors.completion.item.selected.bg = palette.hex01
c.colors.completion.item.selected.border.bottom = palette.hex00
c.colors.completion.item.selected.border.top = palette.hex00
c.colors.completion.item.selected.fg = palette.hex10
c.colors.completion.item.selected.match.fg = palette.hex10


c.colors.downloads.bar.bg = palette.hex00
c.colors.downloads.error.bg = palette.hex00
c.colors.downloads.start.bg = palette.hex00
c.colors.downloads.stop.bg = palette.hex00

c.colors.downloads.error.fg = palette.hex10
c.colors.downloads.start.fg = palette.hex10
c.colors.downloads.stop.fg = palette.hex10
c.colors.downloads.system.fg = "none"
c.colors.downloads.system.bg = "none"

c.colors.hints.bg = palette.hex00
c.colors.hints.fg = palette.hex10
c.colors.hints.match.fg = palette.hex04
c.hints.border = "1px solid " + palette.hex04

c.colors.keyhint.bg = palette.hex00
c.colors.keyhint.fg = palette.hex10
c.colors.keyhint.suffix.fg = palette.hex10

c.colors.messages.error.fg = palette.hex10
c.colors.messages.error.bg = palette.hex00
c.colors.messages.error.border = palette.hex00

c.colors.messages.info.fg = palette.hex10
c.colors.messages.info.bg = palette.hex00
c.colors.messages.info.border = palette.hex00

c.colors.messages.warning.fg = palette.hex10
c.colors.messages.warning.bg = palette.hex00
c.colors.messages.warning.border = palette.hex00


c.colors.prompts.fg = palette.hex10
c.colors.prompts.bg = palette.hex00
c.colors.prompts.border = "1px solid " + palette.hex04
c.prompt.radius = 0
c.colors.prompts.selected.fg = palette.hex10
c.colors.prompts.selected.bg = palette.hex01

c.colors.statusbar.normal.fg = palette.hex10
c.colors.statusbar.normal.bg = palette.hex00

c.colors.statusbar.insert.fg = palette.hex10
c.colors.statusbar.insert.bg = palette.hex00

c.colors.statusbar.command.fg = palette.hex10
c.colors.statusbar.command.bg = palette.hex00

c.colors.statusbar.passthrough.fg = palette.hex10
c.colors.statusbar.passthrough.bg = palette.hex00

c.colors.statusbar.progress.bg = palette.hex00

c.colors.statusbar.private.fg = palette.hex10
c.colors.statusbar.private.bg = palette.hex00

c.colors.statusbar.command.private.fg = palette.hex10
c.colors.statusbar.command.private.bg = palette.hex00


c.colors.statusbar.caret.fg = palette.hex10
c.colors.statusbar.caret.bg = palette.hex00
c.colors.statusbar.caret.selection.fg = palette.hex10
c.colors.statusbar.caret.selection.bg = palette.hex00

c.colors.statusbar.url.fg = palette.hex10
c.colors.statusbar.url.error.fg = palette.hex10
c.colors.statusbar.url.hover.fg = palette.hex10
c.colors.statusbar.url.success.http.fg = palette.hex10
c.colors.statusbar.url.success.https.fg = palette.hex10
c.colors.statusbar.url.warn.fg = palette.hex10

c.colors.tabs.bar.bg = palette.hex00

c.colors.tabs.even.fg = palette.hex06
c.colors.tabs.even.bg = palette.hex00

c.colors.tabs.odd.fg = palette.hex06
c.colors.tabs.odd.bg = palette.hex00

c.colors.tabs.selected.even.fg = palette.hex10
c.colors.tabs.selected.even.bg = palette.hex00

c.colors.tabs.selected.odd.fg = palette.hex10
c.colors.tabs.selected.odd.bg = palette.hex00

c.colors.tabs.pinned.even.fg = palette.hex06
c.colors.tabs.pinned.even.bg = palette.hex00

c.colors.tabs.pinned.odd.fg = palette.hex06
c.colors.tabs.pinned.odd.bg = palette.hex00

c.colors.tabs.pinned.selected.even.fg = palette.hex10
c.colors.tabs.pinned.selected.even.bg = palette.hex00

c.colors.tabs.pinned.selected.odd.fg = palette.hex10
c.colors.tabs.pinned.selected.odd.bg = palette.hex00

c.colors.tabs.indicator.start = palette.hex06
c.colors.tabs.indicator.stop = palette.hex10
c.colors.tabs.indicator.error = palette.hex04
c.colors.tabs.indicator.system = "none"

c.colors.contextmenu.menu.fg = palette.hex10
c.colors.contextmenu.menu.bg = palette.hex00

c.colors.contextmenu.disabled.fg = palette.hex04
c.colors.contextmenu.disabled.bg = palette.hex00

c.colors.contextmenu.selected.fg = palette.hex10
c.colors.contextmenu.selected.bg = palette.hex00

c.colors.webpage.preferred_color_scheme = "dark"
