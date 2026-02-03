# Neovim Configuration

A modern, modular Neovim configuration with lazy.nvim plugin manager.

## Features

- **Plugin Management**: lazy.nvim with lazy loading
- **LSP Support**: Mason for easy LSP server management
- **Completion**: blink.cmp with snippets support
- **Formatting**: conform.nvim (prettier, yapf, stylua)
- **Linting**: nvim-lint with eslint_d
- **File Explorer**: neo-tree
- **Fuzzy Finder**: fzf-lua
- **Git Integration**: lazygit, gitsigns
- **AI Assistants**: GitHub Copilot, Claude Code
- **UI**: bufferline, lualine, noice, which-key

## Requirements

### Required
- Neovim >= 0.9.0
- Git

### Recommended
- Node.js & npm (for LSP servers)
- Python 3 (for some plugins)
- ripgrep (`rg`) - for searching
- fd - for file finding

## Installation

### Linux / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/myeolinmalchi/nvim-config/main/install.sh | bash
```

Or manually:

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone repository
git clone https://github.com/myeolinmalchi/nvim-config.git ~/.config/nvim
```

### Windows (PowerShell)

```powershell
# Download and run installer
irm https://raw.githubusercontent.com/myeolinmalchi/nvim-config/main/install.ps1 | iex
```

Or manually:

```powershell
# Backup existing config
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup

# Clone repository
git clone https://github.com/myeolinmalchi/nvim-config.git $env:LOCALAPPDATA\nvim
```

## Post-Installation

1. Open Neovim: `nvim`
2. Wait for lazy.nvim to install plugins
3. Run `:Mason` to install LSP servers

### Recommended LSP Servers

Install via `:Mason`:
- `pyright` - Python
- `typescript-language-server` - JavaScript/TypeScript
- `lua-language-server` - Lua
- `html-lsp`, `css-lsp`, `tailwindcss-language-server` - Web

## Key Bindings

Leader key: `<Space>`

### Navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows |
| `<S-h/l>` | Navigate buffers |
| `<C-p>` | Fuzzy file finder |
| `s` | Flash jump |

### Files & Buffers
| Key | Action |
|-----|--------|
| `<leader>nt` | Toggle file explorer |
| `<C-q>` | Close buffer + window |
| `<C-w>` | Close buffer only |
| `gt` | Pick buffer |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<space>rn` | Rename |
| `<space>ca` | Code action |
| `<leader>f` | Format |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |
| `]h` / `[h` | Next/prev hunk |
| `<leader>ghs` | Stage hunk |

### Tools
| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>z` | Toggle zen mode |
| `<leader>?` | Show keybindings |
| `<leader>xx` | Toggle diagnostics |

See `CLAUDE.md` for complete keybinding reference.

## Structure

```
init.lua                 # Entry point
lua/
  config/                # Core configuration
    options.lua          # Vim options
    keymaps.lua          # Key bindings
    autocmds.lua         # Autocommands
  plugins/               # Plugin configurations
    lsp.lua              # LSP, formatting, linting
    ui.lua               # UI components
    editor.lua           # Editor features
    terminal.lua         # Terminal
    colorscheme.lua      # Color schemes
    coding/              # Coding tools
```

## Customization

### Change Colorscheme

Edit `init.lua`:
```lua
vim.cmd[[colorscheme tokyonight]]  -- or: gruvbox, monoglow, oxocarbon
```

### Add Plugins

Create a new file in `lua/plugins/` or `lua/plugins/coding/`:
```lua
return {
  "author/plugin-name",
  opts = {},
}
```

## License

MIT
