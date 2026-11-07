---------------------
---- MY PROGRAMS ----
---------------------

-- Definition of apps and programs that I use

local M = {}

M.terminal = os.getenv("TERMINAL") or "alacritty"
M.fileManager = "nautilus"
-- M.menu = "hyprlauncher"
M.menu = "rofi -show drun"
M.fullMenu = "rofi -show run"
M.browser = os.getenv("BROWSER")
M.discord = "vencord"
M.torrent = "qbittorrent"
M["contraseñas"] = "keepassxc"
M.tasks = "super-productivity"
M.notas = "obsidian"
M.paint = "gimp"

return M
