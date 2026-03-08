local awful = require("awful")

local _M = {}

function _M.get()
	local tags = {}
	-- local names = { "main", "www", "office", "msgs", "5", "6", "7", "8", "9" }
	local names = { " ", " ", " ", " ", "5 ", "6 ", "7 ", "8 ", "9 " }

	awful.screen.connect_for_each_screen(function(s)
		-- Each screen has its own tag table.
		tags[s] = awful.tag(names, s, awful.layout.suit.tile)
	end)

	return tags
end

return setmetatable({}, {
	__call = function(_, ...)
		return _M.get(...)
	end,
})
