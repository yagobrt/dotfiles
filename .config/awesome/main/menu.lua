local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local freedesktop = require("freedesktop") -- for all apps installed

-- Theme handling library
local beautiful = require("beautiful")

local M = {}
local _M = {}

local terminal = RC.vars.terminal
local editor = RC.vars.editor

local editor_cmd = terminal .. " -e " .. editor

M.awesome = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focus())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "logout", "oblogout" },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

function _M.get()
	-- Main menu
	local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
	local menu_terminal = { "open terminal", terminal }

	local menu_items = freedesktop.menu.build({
		before = { menu_awesome },
		after = { menu_terminal },
	})

	return menu_items
end

return setmetatable({}, {
	__call = function(_, ...)
		return _M.get
	end,
})
