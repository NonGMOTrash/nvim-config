-- options

vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.incsearch = true

vim.opt.smartindent = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3

vim.opt.list = true
vim.opt.listchars = {space='·', tab='» '}

vim.opt.breakindent = true
vim.opt.wrap = true;

vim.o.clipboard = "unnamed"

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
			vim.g.sonokai_enable_italic = false
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
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},
	-- {
	-- 	'nvim-lualine/lualine.nvim',
	-- 	dependencies = { 'nvim-tree/nvim-web-devicons' }
	-- },
	{
		'gukz/ftFT.nvim',
		keys = { "f", "t", "F", "T" },
		config = true
	},
	{ -- all lsp stuff
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
}
)

-- barbar

vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
	auto_hide = 1
}

-- lualine
--
-- require('lualine').setup {
-- 	options = {
-- 		icons_enabled = true,
-- 		theme = 'horizon',
-- 		component_separators = { left = '', right = ''},
-- 		section_separators = { left = '', right = ''},
-- 		disabled_filetypes = {
-- 			statusline = {},
-- 			winbar = {},
-- 		},
-- 		ignore_focus = {},
-- 		always_divide_middle = true,
-- 		globalstatus = false,
-- 		refresh = {
-- 			statusline = 1000,
-- 			tabline = 1000,
-- 			winbar = 1000,
-- 		}
-- 	},
-- 	sections = {
-- 		lualine_a = {'mode'},
-- 		lualine_b = {'branch', 'diff', 'diagnostics'},
-- 		lualine_c = {'filename'},
-- 		lualine_x = {'encoding', 'fileformat', 'filetype'},
-- 		lualine_y = {'progress'},
-- 		lualine_z = {'location'}
-- 	},
-- 	inactive_sections = {
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_c = {'filename'},
-- 		lualine_x = {'location'},
-- 		lualine_y = {},
-- 		lualine_z = {}
-- 	},
-- 	tabline = {},
-- 	winbar = {},
-- 	inactive_winbar = {},
-- 	extensions = {}
-- }

-- mason

-- require("mason").setup()
-- require("mason-lspconfig").setup()

-- lspconfig

-- local lspconfig = require('lspconfig')
-- lspconfig.clangd.setup {
-- 	-- Server-specific settings. See `:help lspconfig-setup`
-- 	settings = {
--
-- 	},
-- }
