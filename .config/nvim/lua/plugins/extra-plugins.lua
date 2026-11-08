-- [[ Some pluggins that dont require a lot of configuration ]]

-- mini.nvim
vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

require('mini.surround').setup()
require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}



-- Parenthesis
vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}

-- Version Control
vim.pack.add { 'https://github.com/tpope/vim-fugitive' }
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tatus' })

vim.pack.add { 'https://github.com/mbbill/undotree' }
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndotree' })

-- Indent
vim.pack.add { 'https://github.com/NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}
vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {}

-- Info and Diagnostics
vim.pack.add { 'https://github.com/folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }
vim.pack.add { 'https://github.com/folke/trouble.nvim' }
require('trouble').setup {}
vim.keymap.set('n', '<leader>tt', ':Trouble diagnostics toggle<cr>', { desc = '[T]rouble [T]oggle diagnostics' })

-- Typst
vim.pack.add {
  'https://github.com/kaarmu/typst.vim',
  'https://github.com/chomosuke/typst-preview.nvim',
}
