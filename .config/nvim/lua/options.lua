-- Navigation
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"

--  Indentation
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("XDG_DATA_HOME") .. "/nvim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 250

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Window
vim.opt.title = true
vim.opt.isfname:append("@-@")
vim.opt.termguicolors = true
vim.opt.splitbelow = false
vim.opt.splitright = true
vim.opt.colorcolumn = "80"

vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.clipboard:append("unnamedplus")
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.mouse = "a"

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
