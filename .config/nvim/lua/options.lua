-- Load cached Lua modules
vim.loader.enable()

-- Navigation
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.scrolloff = 10
vim.opt.cursorline = true

--  Indentation
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.foldenable = false

-- History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'XDG_DATA_HOME' .. '/nvim/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 250

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- Window
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.splitbelow = false
vim.opt.splitright = true
vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Behaviour
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.confirm = true
vim.opt.clipboard:append 'unnamedplus'
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.isfname:append '@-@'
vim.opt.mouse = 'a'

-- Writing
vim.opt.spell = true
vim.opt.spelllang = { 'en', 'es', 'cjk', 'nl' }
