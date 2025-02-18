return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LSPAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local nmap = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					nmap("<leader>sS", require("telescope.builtin").lsp_document_symbols, "[S]earch document [S]ymbols")
					nmap(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					nmap("K", vim.lsp.buf.hover, "Hover Documentation")
					nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
					vim.keymap.set(
						"i",
						"<C-h>",
						vim.lsp.buf.signature_help,
						{ buffer = event.buf, desc = "Signature Documentation" }
					)

					-- Lesser used LSP functionality
					nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
					nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
					nmap("<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, "[W]orkspace [L]ist Folders")

					-- Create a command `:Format` local to the LSP buffer
					vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
						vim.lsp.buf.format()
					end, { desc = "Format current buffer with LSP" })
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities =
				vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities(capabilities))

			local util = require("lspconfig.util")
			local servers = {
				clangd = {},
				gopls = {
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = util.root_pattern("go.mod", "go.work", ".git"),
					cmd = { "gopls" },
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
							},
						},
					},
				},
				pyright = {},
				rust_analyzer = {
					filetypes = { "rust" },
					root_dir = util.root_pattern("Cargo.toml"),
					settings = {
						["rust_analyzer"] = {
							cargo = {
								allFeatures = true,
							},
						},
					},
				},
				-- tsserver = {},
				-- html = { filetypes = { 'html', 'twig', 'hbs'} },

				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
					},
				},
			}
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua" })

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function()
			require("gopher").setup({
				log_level = vim.log.levels.INFO,
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "gotests",
					impl = "impl",
					iferr = "iferr",
					dlv = "dlv",
				},
				gotests = {
					-- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
					template = "default",
					-- path to a directory containing custom test code templates
					template_dir = nil,
					-- switch table tests from using slice to map (with test name for the key)
					-- works only with gotests installed from develop branch
					named = false,
				},
				gotag = {
					transform = "snakecase",
				},
			})
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
		opts = {},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.keymap.set("n", "<leader>tt", vim.cmd.TroubleToggle, { desc = "[T]rouble [T]oggle" })
		end,
	},
}
