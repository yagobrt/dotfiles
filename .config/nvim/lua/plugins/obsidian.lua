vim.opt.conceallevel = 1

return {
	"epwalsh/obsidian.nvim",
	lazy = false,
	ft = { "markdown", "md" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "notas",
				path = "~/Documentos/obsidian-notes/",
			},
		},
		new_notes_location = "current_dir",
		disable_frontmatter = true,
	},
}
