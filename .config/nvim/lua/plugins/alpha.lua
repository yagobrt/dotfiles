return {
	'goolord/alpha-nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                     ]],
			[[       ████ ██████           █████      ██                     ]],
			[[      ███████████             █████                             ]],
			[[      █████████ ███████████████████ ███   ███████████   ]],
			[[     █████████  ███    █████████████ █████ ██████████████   ]],
			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
			[[                                                                       ]],
			[[                                                                       ]],
			[[                                                                       ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", "<cmd>ene<cr>"),
			dashboard.button("p", "  File Explorer", "<cmd>Ex<cr>"),
			dashboard.button("f", "  Find File", "<cmd>Telescope find_files<cr>"),
			dashboard.button("w", "󰈭  Find Word", "<cmd>Telescope live_grep<cr>"),
			dashboard.button("q", "  Quit", "<cmd>qa<cr>")
		}

		dashboard.section.footer.val = function()
			local total = require("lazy").stats().count
			local version = vim.version()
			local version_info = "󰋼  Neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch
			return "󰂖  " .. total .. " plugins \t" .. version_info
		end
		alpha.setup(dashboard.opts)
	end
}
