
````markdown
# nvim-config

A lightweight personal Neovim configuration inspired by [Radley Lewis’ nvim-lite](https://github.com/radleylewis/nvim-lite), focused on simplicity, speed, and a clean developer experience.

## Features

- Minimal Neovim setup
- Custom statusline
- Floating terminal with tab support
- Fuzzy finding with `fzf-lua`
- File explorer with `nvim-tree`
- Syntax highlighting with Treesitter
- LSP support
- Handy `mini.nvim` modules
- Clean editor defaults
- Nerd Font icon support

## Requirements

Make sure you have the following installed:

```bash
neovim
git
xclip
fzf
tree-sitter
````

For Ubuntu:

```bash
sudo apt update
sudo apt install neovim git fzf npm
sudo npm install -g tree-sitter-cli
```

## Font

This config uses Nerd Font icons.

Recommended font:

```text
JetBrainsMono Nerd Font Mono
```

Download from:

```text
https://www.nerdfonts.com/font-downloads
```

After installing, set your terminal font to `JetBrainsMono Nerd Font Mono`.

## Installation

Clone this config into your Neovim config directory:

```bash
$ mkdir -p  ~/.local/share/fonts

$ wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

$ unzip JetBrainsMono.zip

$ fc-cache -fv
```

Open Neovim:

```bash
nvim
```

Plugins should be added using Neovim’s built-in package manager setup.

## Keymaps

| Keymap       | Action                   |
| ------------ | ------------------------ |
| `<leader>e`  | Toggle file explorer     |
| `<leader>ff` | Find files               |
| `<leader>fg` | Live grep                |
| `<leader>fb` | Find buffers             |
| `<leader>fh` | Help tags                |
| `<leader>fx` | Document diagnostics     |
| `<leader>fX` | Workspace diagnostics    |
| `<leader>t`  | Toggle floating terminal |
| `<A-t>`      | New terminal tab         |
| `<A-w>`      | Close terminal tab       |
| `<A-h>`      | Previous terminal tab    |
| `<A-l>`      | Next terminal tab        |

## Plugins

This config includes:

* [fzf-lua](https://github.com/ibhagwan/fzf-lua)
* [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [mini.nvim](https://github.com/echasnovski/mini.nvim)
* [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

## Inspiration

This configuration is inspired by:

[Radley Lewis’ nvim-lite](https://github.com/radleylewis/nvim-lite)

## License

MIT

```
```
