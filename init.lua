-- options

vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.incsearch = true

vim.opt.smartindent = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.breakindent = true
vim.opt.wrap = true
vim.opt.scrolloff = 10

vim.opt.list = true
vim.opt.listchars = {space='·', tab='» '}

vim.o.clipboard = "unnamed"

-- autocompletion

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
})

-- lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- plugins

require("lazy").setup(
{
	{
		'sainnhe/sonokai',
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.sonokai_enable_italic = true 
			vim.g.sonokai_disable_italic_comment = true
			vim.cmd.colorscheme('sonokai')
		end
	},
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
			auto_hide = 1
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},
	{
		'gukz/ftFT.nvim',
		keys = { "f", "t", "F", "T" },
		config = true
	},
	{ -- all lsp / completion stuff
		"mason-org/mason.nvim", -- package manager for LSPs 
		"mason-org/mason-lspconfig.nvim", -- mason to lsp bridget
		"neovim/nvim-lspconfig", -- a bundle of good LSP configurations so i don't have to do it myself
		"hrsh7th/nvim-cmp", -- completion engine
		"hrsh7th/cmp-nvim-lsp", -- lsp completion source
	},
	{
		'wsdjeg/rooter.nvim',
	},
	{
		'bluz71/nvim-linefly',
	}
})

-- mason stuff

require("mason").setup({
	-- log_level = vim.log.levels.DEBUG
})

require('mason-lspconfig').setup({
	ensure_installed = {
		"clangd"
	},
	automatic_enable = true, -- Mason-LSPConfig v2 auto-enables servers by default
})

-- cmp

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}),
})

-- setup lspconfig with cmp capabilities
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- require("lspconfig").clangd.setup({
-- 	capabilities = capabilities,
-- })
