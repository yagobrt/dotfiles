vim.pack.add {
  {
    src = 'https://github.com/obsidian-nvim/obsidian.nvim',
    version = vim.version.range '*', -- use latest release
  },
}

vim.opt.conceallevel = 1

require('obsidian').setup {
  ft = { 'markdown', 'md' },
  legacy_commands = false, -- this will be removed in 4.0.0
  workspaces = {
    {
      name = 'notas',
      path = '~/Documentos/obsidian-notes/',
    },
  },
  -- disable_frontmatter = true,
}
