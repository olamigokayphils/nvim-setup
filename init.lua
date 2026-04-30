vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax")

vim.opt.number = true -- line number
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- TAB SPACE --
vim.opt.tabstop = 4 -- tabwidth
vim.opt.shiftwidth = 4 --indent width
vim.opt.softtabstop = 4 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
smartindent = true -- smart auto-indent
autoindent = true -- copy indent from current line

-- SEARCH OPTION --
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- COLUMN --
vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 postion chars
vim.opt.showmatch = true -- highligths matching brackets
vim.opt.cmdheight = 1 --single line commnad line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- don not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highllighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

-- BACKUPS && UNDO DIR --
local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not autosave

vim.opt.hidden = true --allow hideen buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behavior
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") --include - in-words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" --include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8" -- set encoding

-- CURSOR --
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" --cursor blinking config

--FOLDING
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true --horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- ============================
-- STATUSLINE
-- ===========================

-- Git branch Function withc caching and Nerd Font Icon
local cached_branch = ""
local last_check = 0
local function git_branch()
	local now = vim.loop.now()
	if now - last_check > 5000 then -- Check every 5 seconds
		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d ''")
		last_check = now
	end
	if cached_branch ~= "" then
		return "\u{e725} " .. cached_branch .. " " --nf-dev-git_branch
	end
	return ""
end

-- File type with Nerd Font icon
local function file_type()
	local ft = vim.bo.filetype
	local icons = {
		lua = "\u{e620} ", -- nf-dev-lua
		python = "\u{e73c} ", -- nf-dev-python
		javascript = "\u{e74e} ", -- nf-dev-javascript
		typescript = "\u{e628} ", -- nf-dev-typescript
		javascriptreact = "\u{e7ba} ",
		typescriptreact = "\u{e7ba} ",
		html = "\u{e736} ", -- nf-dev-html5
		css = "\u{e749} ", -- nf-dev-css3
		scss = "\u{e749} ",
		json = "\u{e60b} ", -- nf-dev-json
		markdown = "\u{e73e} ", -- nf-dev-markdown
		vim = "\u{e62b} ", -- nf-dev-vim
		sh = "\u{f489} ", -- nf-oct-terminal
		bash = "\u{f489} ",
		zsh = "\u{f489} ",
		rust = "\u{e7a8} ", -- nf-dev-rust
		go = "\u{e724} ", -- nf-dev-go
		c = "\u{e61e} ", -- nf-dev-c
		cpp = "\u{e61d} ", -- nf-dev-cplusplus
		java = "\u{e738} ", -- nf-dev-java
		php = "\u{e73d} ", -- nf-dev-php
		ruby = "\u{e739} ", -- nf-dev-ruby
		swift = "\u{e755} ", -- nf-dev-swift
		kotlin = "\u{e634} ",
		dart = "\u{e798} ",
		elixir = "\u{e62d} ",
		haskell = "\u{e777} ",
		sql = "\u{e706} ",
		yaml = "\u{f481} ",
		toml = "\u{e615} ",
		xml = "\u{f05c} ",
		dockerfile = "\u{f308} ", -- nf-linux-docker
		gitcommit = "\u{f418} ", -- nf-oct-git_commit
		gitconfig = "\u{f1d3} ", -- nf-fa-git
		vue = "\u{fd42} ", -- nf-md-vuejs
		svelte = "\u{e697} ",
		astro = "\u{e628} ",
	}

	if ft == "" then
		return " \u{f15b} " -- nf-fa-file_o
	end

	return ((icons[ft] or " \u{f15b} ") .. ft)
end

-- File size with Nerd Font icon
local function file_size()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size < 0 then
		return ""
	end
	local size_str
	if size < 1024 then
		size_str = size .. "B"
	elseif size < 1024 * 1024 then
		size_str = string.format("%.1fK", size / 1024)
	else
		size_str = string.format("%.1fM", size / 1024 / 1024)
	end
	return " \u{f016} " .. size_str .. " " -- nf-fa-file_o
end

-- Mode indicators with Nerd Font icons
local function mode_icon()
	local mode = vim.fn.mode()
	local modes = {
		n = " \u{f121}  NORMAL",
		i = " \u{f11c}  INSERT",
		v = " \u{f0168} VISUAL",
		V = " \u{f0168} V-LINE",
		["\22"] = " \u{f0168} V-BLOCK",
		c = " \u{f120} COMMAND",
		s = " \u{f0c5} SELECT",
		S = " \u{f0c5} S-LINE",
		["\19"] = " \u{f0c5} S-BLOCK",
		R = " \u{f044} REPLACE",
		r = " \u{f044} REPLACE",
		["!"] = " \u{f489} SHELL",
		t = " \u{f120} TERMINAL",
	}
	return modes[mode] or (" \u{f059} " .. mode)
end

-- (_G means global variables)
_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

-- Function to change statusline based on window focus
local function is_not_empty(str)
	return str and str:match("%S")
end

local function relative_cwd()
	local file_dir = vim.fn.expand("%:p:h")
	local cwd = vim.fn.getcwd()

	if file_dir == "" then
		return ""
	end

	local relative = vim.fn.fnamemodify(file_dir, ":.")
	if relative == "." then
		return ""
	end

	return " " .. relative
end

_G.relative_cwd = relative_cwd

local function setup_dynamic_statusline()
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			local parts = {
				"  ",
				"%#StatusLineBold#",
				"%{v:lua.mode_icon()}",
				"%#StatusLine#",
			}

			local function add_section(content)
				if is_not_empty(content) then
					table.insert(parts, " \u{e0b1} ")
					table.insert(parts, content)
				end
			end

			add_section("%{v:lua.relative_cwd()}")
			add_section("%{v:lua.git_branch()}")
			add_section("%{v:lua.file_type()}")
			add_section("%{v:lua.file_size()}")

			table.insert(parts, "%=")
			table.insert(parts, " \u{f017} %l:%c  %P ")

			vim.opt_local.statusline = table.concat(parts)
		end,
	})

	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = "  %f %h%m%r %{v:lua.file_type()} %= %l:%c %P "
		end,
	})
end

setup_dynamic_statusline()

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- ===========================
-- AUTO COMMANDS
-- ===========================
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor postion",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if last_line > row or row < 1 then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

--- Wrap , linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- FORMAT ON SAVE (For real file buffers, Only when efm [linters & formatter manager] is attached.)
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.go",
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
		"*.json",
		"*.css",
		"*.scss",
		"*.html",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.c",
		"*.cpp",
		"*.h",
		"*.hpp",
	},
	callback = function(args)
		-- avoid formatting non-file buffers (helps prevent weird write prompts)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		if not vim.bo[args.buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end

		local has_efm = false
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "efm" then
				has_efm = true
				break
			end
		end
		if not has_efm then
			return
		end

		pcall(vim.lsp.buf.format, {
			bufnr = args.buf,
			timeout_ms = 2000,
			filter = function(c)
				return c.name == "efm"
			end,
		})
	end,
})

-- ========================================
-- PLUGINS
-- ========================================

vim.pack.add({
	"https://www.github.com/lewis6991/gitsigns.nvim",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://www.github.com/mason-org/mason.nvim",
	"https://www.github.com/creativenull/efmls-configs-nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/L3MON4D3/LuaSnip",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end

packadd("nvim-treesitter")
packadd("gitsigns.nvim")
packadd("mini.nvim")
packadd("fzf-lua")
packadd("nvim-tree.lua")
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("efmls-configs-nvim")
packadd("blink.cmp")
packadd("LuaSnip")

-- ===================================
-- PLUGINS Config
-- ===================================
-- nvim-tree
require("nvim-tree").setup({
	view = {
		width = 35,
	},
	filters = {
		dotfiles = false,
	},
	renderer = {
		group_empty = true,
	},
})
vim.keymap.set("n", "<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree" })

-- fzf -lua
require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

-- Lua Mini module
require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})

-- Git signs
require("gitsigns").setup({
	signs = {
		add = { text = "\u{2590}" }, -- ▏
		change = { text = "\u{2590}" }, -- ▐
		delete = { text = "\u{2590}" }, -- ◦
		topdelete = { text = "\u{25e6}" }, -- ◦
		changedelete = { text = "\u{25cf}" }, -- ●
		untracked = { text = "\u{25cb}" }, -- ○
	},
	signcolumn = true,
	current_line_blame = false,
})

require("mason").setup({})

vim.keymap.set("n", "]h", function()
	require("gitsigns").nav_hunk("next")
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
	require("gitsigns").nav_hunk("prev")
end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })
vim.keymap.set("n", "<leader>hB", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline blame" })
vim.keymap.set("n", "<leader>hd", function()
	require("gitsigns").diffthis()
end, { desc = "Diff this" })

--  TREE SITTER
local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"vim",
		"vimdoc",
		"rust",
		"c",
		"cpp",
		"html",
		"htmldjango",
		"jinja",
		"jinja_inline",
		"css",
		"scss",
		"javascript",
		"typescript",
		"json",
		"jsx",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"vue",
		"svelte",
		"bash",
		"php",
		"php_only",
		"perl",
		"sql",
		"yaml",
		"tmux",
	}

	local config = require("nvim-treesitter.config")
	local already_installed = config.get_installed()
	local parsers_to_install = {}

	for _, parser in ipairs(ensure_installed) do
		if not vim.tbl_contains(already_installed, parser) then
			table.insert(parsers_to_install, parser)
		end
	end

	if #parsers_to_install > 0 then
		treesitter.install(parsers_to_install)
	end

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

-- ========================
-- LSP CONFIG
-- ========================
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

--
local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)

	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	vim.keymap.set("n", "hh", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>fd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Blink (Auto Suggest && Completion engine for efm LSP)

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = { menu = { auto_show = true } },
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},

	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("clangd", {})

do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local cpplint = require("efmls-configs.linters.cpplint")
	local clangfmt = require("efmls-configs.formatters.clang_format")

	local go_revive = require("efmls-configs.linters.go_revive")
	local gofumpt = require("efmls-configs.formatters.gofumpt")

	vim.lsp.config("efm", {
		filetypes = {
			"c",
			"cpp",
			"css",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"python",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				c = { clangfmt, cpplint },
				cpp = { clangfmt, cpplint },
				css = { prettier_d },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				markdown = { prettier_d },
				python = { flake8, black },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { eslint_d, prettier_d },
				svelte = { eslint_d, prettier_d },
			},
		},
	})
end

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"bashls",
	"ts_ls",
	"clangd",
	"efm",
})

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================
-- ============================================================================
-- FLOATING TERMINAL WITH TABS
-- ============================================================================

-- local terminal_augroup = vim.api.nvim_create_augroup("FloatingTerminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- ============================================================================
-- STATE
-- ============================================================================

---@class TermTab
---@field buf integer
---@field label string

---@class TermState
---@field tabs TermTab[]
---@field active integer
---@field win integer|nil
---@field hdr_win integer|nil
---@field hdr_buf integer|nil
---@field is_open boolean
---@field prev_win integer|nil

local state = {
	tabs = {},
	active = 1,
	win = nil,
	hdr_win = nil,
	hdr_buf = nil,
	is_open = false,
	prev_win = nil,
}

local closing_bufs = {}

-- ============================================================================
-- MODULE
-- ============================================================================

local M = {}

-- ============================================================================
-- HELPERS
-- ============================================================================

local HDR_HEIGHT = 1
local PADDING = 2

local function valid_win(win)
	return win and vim.api.nvim_win_is_valid(win)
end

local function valid_buf(buf)
	return buf and vim.api.nvim_buf_is_valid(buf)
end

local function win_dims()
	local width = math.floor(vim.o.columns * 0.82)
	local height = math.floor(vim.o.lines * 0.80)
	local row = math.floor((vim.o.lines - height - HDR_HEIGHT - 1) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	return width, height, row, col
end

local function setup_hl()
	vim.api.nvim_set_hl(0, "FloatTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatTermBorder", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatTermHdrBg", { bg = "none" })

	vim.api.nvim_set_hl(0, "FloatTermTabActive", {
		bold = true,
		fg = "#89b4fa",
		bg = "none",
	})

	vim.api.nvim_set_hl(0, "FloatTermTabInact", {
		fg = "#585b70",
		bg = "none",
	})

	vim.api.nvim_set_hl(0, "FloatTermTabSep", {
		fg = "#313244",
		bg = "none",
	})

	vim.api.nvim_set_hl(0, "FloatTermHint", {
		italic = true,
		fg = "#45475a",
		bg = "none",
	})

	vim.api.nvim_set_hl(0, "FloatTermClose", {
		fg = "#f38ba8",
		bg = "none",
	})

	vim.api.nvim_set_hl(0, "FloatTermPlus", {
		fg = "#a6e3a1",
		bg = "none",
	})
end

local function close_float()
	local content_win = state.win
	local header_win = state.hdr_win
	local prev_win = state.prev_win

	state.is_open = false
	state.win = nil
	state.hdr_win = nil

	-- First return focus to the original editor window if possible.
	-- This prevents Neovim from jumping into the header float after closing terminal.
	if valid_win(prev_win) then
		pcall(vim.api.nvim_set_current_win, prev_win)
	end

	-- Close terminal content window.
	if valid_win(content_win) then
		pcall(vim.api.nvim_win_close, content_win, false)
	end

	-- Close header window.
	if valid_win(header_win) then
		pcall(vim.api.nvim_win_close, header_win, false)
	end
end

local function setup_terminal_keymaps(buf)
	local function tm(lhs, rhs, desc)
		vim.keymap.set("t", lhs, rhs, {
			buffer = buf,
			noremap = true,
			silent = true,
			desc = desc,
		})
	end

	tm("<Esc>", function()
		vim.cmd("stopinsert")

		vim.schedule(function()
			close_float()
		end)
	end, "FloatTerm: close and return to editor")

	tm("<A-t>", function()
		M.new_tab()
	end, "FloatTerm: new tab")

	tm("<A-w>", function()
		vim.cmd("stopinsert")

		vim.schedule(function()
			M.close_tab()
		end)
	end, "FloatTerm: close tab")

	tm("<A-l>", function()
		M.next_tab()
	end, "FloatTerm: next tab")

	tm("<A-h>", function()
		M.prev_tab()
	end, "FloatTerm: previous tab")
end

local function new_term_buf(label)
	local buf = vim.api.nvim_create_buf(false, true)

	vim.bo[buf].bufhidden = "hide"

	vim.api.nvim_buf_call(buf, function()
		vim.fn.termopen(os.getenv("SHELL") or "sh", {

			on_exit = function()
				if closing_bufs[buf] then
					closing_bufs[buf] = nil
					return
				end

				for i, tab in ipairs(state.tabs) do
					if tab.buf == buf then
						table.remove(state.tabs, i)

						if #state.tabs == 0 then
							close_float()
							state.active = 1
						else
							if state.active > #state.tabs then
								state.active = #state.tabs
							end

							if state.is_open and valid_win(state.win) then
								vim.api.nvim_win_set_buf(state.win, state.tabs[state.active].buf)
								M.refresh_header()
							end
						end

						break
					end
				end
			end,
		})
	end)

	setup_terminal_keymaps(buf)

	return {
		buf = buf,
		label = label,
	}
end

-- ============================================================================
-- HEADER RENDERING
-- ============================================================================

local function build_header(width)
	local parts = {}
	local col = 0

	local plus = " + "
	parts[#parts + 1] = {
		text = plus,
		hl = "FloatTermPlus",
	}

	local plus_start = col
	col = col + #plus
	local plus_end = col - 1

	local sep = " │ "

	for i, tab in ipairs(state.tabs) do
		local label = " " .. tab.label .. " "
		local is_active = i == state.active
		local close = is_active and " ✕" or "  "
		local entry = label .. close

		parts[#parts + 1] = {
			text = entry,
			hl = is_active and "FloatTermTabActive" or "FloatTermTabInact",
			tab = i,
		}

		col = col + #entry

		if i < #state.tabs then
			parts[#parts + 1] = {
				text = sep,
				hl = "FloatTermTabSep",
			}

			col = col + #sep
		end
	end

	local hint = " <A-t> new  <A-w> close  <A-h/l> switch "
	local pad = math.max(0, width - col - #hint)

	local line = ""
	local hls = {}

	local c = 0

	for _, part in ipairs(parts) do
		local start_col = c
		local end_col = c + #part.text - 1

		hls[#hls + 1] = {
			start_col,
			end_col,
			part.hl,
			part.tab,
		}

		line = line .. part.text
		c = c + #part.text
	end

	line = line .. string.rep(" ", pad) .. hint

	hls[#hls + 1] = {
		c + pad,
		c + pad + #hint - 1,
		"FloatTermHint",
		nil,
	}

	return line, hls, plus_start, plus_end
end

function M.refresh_header()
	if not valid_buf(state.hdr_buf) then
		return
	end

	local width = win_dims()
	local line, hls = build_header(width)

	local ns = vim.api.nvim_create_namespace("FloatTermHdr")

	vim.bo[state.hdr_buf].modifiable = true
	vim.api.nvim_buf_set_lines(state.hdr_buf, 0, -1, false, { line })
	vim.api.nvim_buf_clear_namespace(state.hdr_buf, ns, 0, -1)

	for _, hl in ipairs(hls) do
		vim.api.nvim_buf_add_highlight(state.hdr_buf, ns, hl[3], 0, hl[1], hl[2] + 1)
	end

	vim.bo[state.hdr_buf].modifiable = false
end

-- ============================================================================
-- HEADER CLICK HANDLING
-- ============================================================================

local function setup_header_clicks()
	if not valid_buf(state.hdr_buf) then
		return
	end

	vim.keymap.set("n", "<LeftMouse>", function()
		local mpos = vim.fn.getmousepos()
		local click_col = mpos.column - 1

		local width = win_dims()
		local _, hls, plus_start, plus_end = build_header(width)

		if click_col >= plus_start and click_col <= plus_end then
			M.new_tab()
			return
		end

		for _, hl in ipairs(hls) do
			local start_col = hl[1]
			local end_col = hl[2]
			local tab_idx = hl[4]

			if tab_idx and click_col >= start_col and click_col <= end_col then
				if tab_idx == state.active and click_col >= end_col - 1 then
					M.close_tab()
				else
					M.switch_tab(tab_idx)
				end

				return
			end
		end
	end, {
		buffer = state.hdr_buf,
		noremap = true,
		silent = true,
		desc = "FloatTerm: header click",
	})
end

-- ============================================================================
-- TAB OPERATIONS
-- ============================================================================

function M.new_tab()
	local idx = #state.tabs + 1
	local tab = new_term_buf("term " .. idx)

	table.insert(state.tabs, tab)
	state.active = #state.tabs

	if state.is_open and valid_win(state.win) then
		vim.api.nvim_win_set_buf(state.win, tab.buf)
		M.refresh_header()
		vim.cmd("startinsert")
	end
end

function M.close_tab()
	if #state.tabs <= 1 then
		vim.notify("FloatTerm: cannot close last tab", vim.log.levels.WARN)
		return
	end

	local closed_index = state.active
	local closed_tab = state.tabs[closed_index]

	-- Remove the tab from the list first
	table.remove(state.tabs, closed_index)

	-- Switch to next tab.
	-- If we closed the last tab, wrap to the first tab.
	if closed_index > #state.tabs then
		state.active = 1
	else
		state.active = closed_index
	end

	local next_tab = state.tabs[state.active]

	-- Important:
	-- Move the floating terminal window to the next buffer BEFORE deleting
	-- the old buffer. This prevents Neovim from closing the terminal window.
	if state.is_open and valid_win(state.win) and valid_buf(next_tab.buf) then
		vim.api.nvim_win_set_buf(state.win, next_tab.buf)
	end

	M.refresh_header()

	-- Now delete the old terminal buffer after it is no longer displayed.
	if valid_buf(closed_tab.buf) then
		closing_bufs[closed_tab.buf] = true
		pcall(vim.api.nvim_buf_delete, closed_tab.buf, { force = true })
	end

	if state.is_open and valid_win(state.win) then
		vim.cmd("startinsert")
	end
end

function M.switch_tab(index)
	if index < 1 or index > #state.tabs then
		return
	end

	if index == state.active then
		return
	end

	state.active = index

	if state.is_open and valid_win(state.win) then
		vim.api.nvim_win_set_buf(state.win, state.tabs[state.active].buf)
		M.refresh_header()
		vim.cmd("startinsert")
	end
end

function M.next_tab()
	if #state.tabs <= 1 then
		return
	end

	local next_index = state.active < #state.tabs and state.active + 1 or 1
	M.switch_tab(next_index)
end

function M.prev_tab()
	if #state.tabs <= 1 then
		return
	end

	local prev_index = state.active > 1 and state.active - 1 or #state.tabs
	M.switch_tab(prev_index)
end

-- ============================================================================
-- OPEN / CLOSE FLOAT
-- ============================================================================
local function recalibrate_term_labels()
	for i, tab in ipairs(state.tabs) do
		tab.label = "term " .. i
	end
end

local function open_float()
	state.prev_win = vim.api.nvim_get_current_win()

	local width, height, row, col = win_dims()

	if #state.tabs == 0 then
		table.insert(state.tabs, new_term_buf("term 1"))
		state.active = 1
	end

	recalibrate_term_labels()

	if not valid_buf(state.hdr_buf) then
		state.hdr_buf = vim.api.nvim_create_buf(false, true)
		vim.bo[state.hdr_buf].bufhidden = "hide"
		vim.bo[state.hdr_buf].filetype = "floatermhdr"
	end

	setup_hl()

	state.hdr_win = vim.api.nvim_open_win(state.hdr_buf, false, {
		relative = "editor",
		width = width,
		height = HDR_HEIGHT,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		zindex = 50,
	})

	vim.wo[state.hdr_win].winhighlight = "Normal:FloatTermHdrBg,FloatBorder:FloatTermBorder"
	vim.wo[state.hdr_win].winblend = 0

	local content_row = row + HDR_HEIGHT + PADDING

	state.win = vim.api.nvim_open_win(state.tabs[state.active].buf, true, {
		relative = "editor",
		width = width,
		height = height - HDR_HEIGHT - PADDING,
		row = content_row,
		col = col,
		style = "minimal",
		border = "rounded",
		zindex = 49,
	})

	vim.wo[state.win].winhighlight = "Normal:FloatTermNormal,FloatBorder:FloatTermBorder"
	vim.wo[state.win].winblend = 0

	state.is_open = true

	M.refresh_header()
	setup_header_clicks()

	vim.cmd("startinsert")
end

local function FloatingTerminal()
	if state.is_open and valid_win(state.win) then
		close_float()
	else
		open_float()
	end
end

-- ============================================================================
-- GLOBAL KEYMAPS
-- ============================================================================

vim.keymap.set("n", "<leader>t", FloatingTerminal, {
	noremap = true,
	silent = true,
	desc = "Toggle floating terminal",
})

vim.keymap.set("n", "<A-t>", function()
	if state.is_open then
		M.new_tab()
	end
end, {
	noremap = true,
	silent = true,
	desc = "FloatTerm: new tab",
})

vim.keymap.set("n", "<A-w>", function()
	if state.is_open then
		M.close_tab()
	end
end, {
	noremap = true,
	silent = true,
	desc = "FloatTerm: close tab",
})

vim.keymap.set("n", "<A-l>", function()
	if state.is_open then
		M.next_tab()
	end
end, {
	noremap = true,
	silent = true,
	desc = "FloatTerm: next tab",
})

vim.keymap.set("n", "<A-h>", function()
	if state.is_open then
		M.prev_tab()
	end
end, {
	noremap = true,
	silent = true,
	desc = "FloatTerm: previous tab",
})
