# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using lazy.nvim as the plugin manager. The configuration is structured in a modular way with separate files for different concerns (LSP, UI, editor features, coding tools). It also supports VSCode Neovim extension with separate configuration.

## Architecture

### Plugin Management
- **Plugin manager**: lazy.nvim (bootstrapped in `init.lua`)
- **Plugin loading**: All plugins are auto-loaded from `lua/plugins/` directory
- Lazy.nvim automatically requires any `.lua` file in `lua/plugins/` and subdirectories as plugin specs

### Configuration Structure
```
init.lua                    # Entry point: bootstraps lazy.nvim, sets leader key, loads config (or VSCode config)
lua/
  config/
    init.lua               # Loads all config modules
    options.lua            # Vim options (indentation, encoding, UI settings)
    keymaps.lua            # Global keybindings
    autocmds.lua           # Autocommands (window resize, markdown settings)
  config-vscode/           # VSCode Neovim extension specific config
    init.lua
    keymaps.lua
    options.lua
  plugins/
    lsp.lua                # LSP configuration with Mason, conform.nvim (formatting), nvim-lint
    ui.lua                 # UI components (lualine, bufferline, notify, indent guides, mini.indentscope)
    editor.lua             # Editor features (neo-tree, fzf-lua, flash, zen-mode, markdown-preview, auto-session, noice, which-key, gitsigns, snacks)
    colorscheme.lua        # Color schemes (oxocarbon, tokyonight, gruvbox, monoglow)
    terminal.lua           # Terminal integration (toggleterm)
    coding/
      blink_cmp.lua        # Completion engine (blink.cmp)
      nvim_autopairs.lua   # Auto-pairing brackets
      autoclose.lua        # Auto-close tags
      treesitter.lua       # Treesitter for coding
      trouble.lua          # Diagnostic viewer
      todo_comments.lua    # TODO comment highlighting
      lazygit.lua          # Git integration
      claude.lua           # Claude Code integration (claude-code.nvim)
      copilot.lua          # GitHub Copilot
      tailwind_fold.lua    # Tailwind CSS class folding
```

### Key Architectural Patterns

1. **Modular Plugin Organization**: Plugins are split by function (UI, editor, LSP, coding)
2. **Lazy Loading**: Most plugins use lazy loading with `event`, `cmd`, `keys`, or `ft` triggers
3. **Leader Key**: Space (`<leader> = " "`)
4. **Split Window Strategy**: Custom split commands that create new buffers and sync with neo-tree (see `keymaps.lua:52-66`)
5. **LSP Integration**: Uses Mason for LSP server management, configured with blink.cmp for completions
6. **VSCode Support**: Separate configuration loaded when running as VSCode Neovim extension

## Language Server Configuration

LSP servers are configured in `lua/plugins/lsp.lua`:
- **Python**: pyright
- **TypeScript/JavaScript**: ts_ls + eslint (auto-fix on save)
- **Web**: html, cssls, cssmodules_ls, tailwindcss, emmet_ls
- **Astro**: astro
- **Lua**: lua_ls (with lazydev.nvim for Neovim API completions)

### Formatting (conform.nvim)
- **JavaScript/TypeScript/CSS/HTML/JSON/YAML/Markdown/Astro**: prettier
- **Python**: yapf
- **Lua**: stylua
- Format on save enabled by default

### Linting (nvim-lint)
- **JavaScript/TypeScript/Astro**: eslint_d

## Important Keybindings

### Window Management
- `<C-h/j/k/l>`: Navigate between windows
- `<leader>h/j/k/l`: Split windows (custom behavior with neo-tree sync)
- `<C-q>`: Close buffer and window
- `<C-w>`: Close buffer without closing window
- `<S-h/l>`: Navigate between buffers
- `<C-s>`: Save file (works in insert mode too)

### Editor Features
- `<C-p>`: Fuzzy file finder (fzf-lua)
- `<leader>nt`: Toggle neo-tree file explorer
- `<leader>nq`: Close neo-tree
- `<C-\>`: Toggle terminal (toggleterm)
- `<leader>gg`: Open LazyGit
- `<leader>gm`: Open Gemini CLI in terminal
- `<leader>z`: Toggle zen-mode
- `gt`: Pick buffer in tabline
- `<leader>?`: Show buffer local keymaps (which-key)
- `<leader>un`: Dismiss all notifications
- `<leader>f`: Format buffer (conform.nvim)

### Flash (Navigation)
- `s`: Flash jump
- `S`: Flash treesitter
- `r`: Remote flash (operator-pending)
- `R`: Treesitter search
- `<C-s>`: Toggle flash search (command mode)

### Git (gitsigns)
- `]h` / `[h`: Next/prev hunk
- `<leader>ghs`: Stage hunk
- `<leader>ghr`: Reset hunk
- `<leader>ghp`: Preview hunk
- `<leader>ghb`: Blame line

### LSP (when LSP is attached)
- `gd`: Go to definition
- `gD`: Go to declaration
- `gi`: Go to implementation
- `gr`: Go to references
- `K`: Hover documentation
- `<space>D`: Type definition
- `<space>rn`: Rename symbol
- `<space>ca`: Code action
- `<space>wa/wr/wl`: Workspace folder management
- `<leader>cr`: Restart LSP

### Trouble (Diagnostics)
- `<leader>xx`: Toggle diagnostics
- `<leader>xX`: Toggle buffer diagnostics
- `<leader>cs`: Toggle symbols
- `<leader>cl`: Toggle LSP definitions/references
- `<leader>xL`: Toggle location list
- `<leader>xQ`: Toggle quickfix list

### Completion (blink.cmp)
- `<C-n>` / `<C-p>`: Select next/prev item
- `<C-b>` / `<C-f>`: Scroll documentation
- `<C-Space>`: Show completions
- `<C-e>`: Cancel
- `<CR>`: Accept

## Development Workflow

### Testing Configuration Changes
1. Source the file: `:source %` or `:so %`
2. For plugin changes: `:Lazy reload {plugin-name}`
3. Restart Neovim to fully test initialization

### Adding New Plugins
1. Create a new `.lua` file in `lua/plugins/` or `lua/plugins/coding/`
2. Return a table with plugin spec(s)
3. Plugin will be auto-loaded by lazy.nvim on next restart
4. Run `:Lazy sync` to install

### LSP Server Management
- Install servers: `:Mason` (opens UI) or configure in `lsp.lua` with Mason-lspconfig
- Restart LSP: `<leader>cr` or `:LspRestart`

### Updating Plugins
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install/update/clean plugins

## Special Considerations

### Encoding
Configuration handles Korean encoding (cp949) in addition to UTF-8 (see `options.lua:19`)

### Auto-formatting
All formatting is handled by conform.nvim with format-on-save enabled:
- Prettier for web technologies (JS, TS, CSS, HTML, JSON, YAML, Markdown, Astro)
- yapf for Python
- stylua for Lua
- ESLint auto-fix on save for JS/TS

### Terminal Integration
- ToggleTerm for general terminal use (`<C-\>`)
- Custom Gemini CLI terminal integration (`<leader>gm`)
- Terminal escape: `<Esc>` to enter normal mode in terminal
- Terminal window navigation: `<C-h/j/k/l>` works in terminal mode

### Colorscheme
- Current: oxocarbon (set in `init.lua:20`)
- Available: tokyonight (moon style), gruvbox, monoglow, oxocarbon

### Buffer Management
Buffer closing commands (`<C-q>`, `<C-w>`) use complex logic to maintain buffer list integrity:
- `:bp<bar>sp<bar>bn<bar>bd` pattern prevents closing window when closing last buffer

### UI Enhancements
- **noice.nvim**: Better UI for cmdline, messages, and notifications
- **which-key.nvim**: Shows pending keybindings
- **gitsigns.nvim**: Git integration in signcolumn
- **snacks.nvim**: Various utilities (bigfile handling, dashboard, quickfile)
