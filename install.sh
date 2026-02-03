#!/usr/bin/env bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

REPO_URL="https://github.com/myeolinmalchi/nvim-config.git"

# Detect OS and set config path
detect_os() {
    case "$(uname -s)" in
        Linux*)     OS="Linux";;
        Darwin*)    OS="macOS";;
        CYGWIN*|MINGW*|MSYS*) OS="Windows";;
        *)          OS="Unknown";;
    esac
    echo -e "${BLUE}Detected OS: ${OS}${NC}"
}

get_nvim_config_path() {
    if [[ "$OS" == "Windows" ]]; then
        echo "$LOCALAPPDATA/nvim"
    else
        echo "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
    fi
}

# Check dependencies
check_dependencies() {
    echo -e "${BLUE}Checking dependencies...${NC}"

    local missing=()

    # Required
    if ! command -v nvim &> /dev/null; then
        missing+=("neovim")
    else
        local nvim_version=$(nvim --version | head -1 | grep -oP 'v\K[0-9]+\.[0-9]+')
        echo -e "  ${GREEN}✓${NC} Neovim $nvim_version"
    fi

    if ! command -v git &> /dev/null; then
        missing+=("git")
    else
        echo -e "  ${GREEN}✓${NC} Git"
    fi

    # Optional but recommended
    if ! command -v node &> /dev/null; then
        echo -e "  ${YELLOW}!${NC} Node.js (recommended for LSP servers)"
    else
        echo -e "  ${GREEN}✓${NC} Node.js"
    fi

    if ! command -v npm &> /dev/null; then
        echo -e "  ${YELLOW}!${NC} npm (recommended for LSP servers)"
    else
        echo -e "  ${GREEN}✓${NC} npm"
    fi

    if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
        echo -e "  ${YELLOW}!${NC} Python (recommended for some plugins)"
    else
        echo -e "  ${GREEN}✓${NC} Python"
    fi

    if ! command -v rg &> /dev/null; then
        echo -e "  ${YELLOW}!${NC} ripgrep (recommended for telescope/fzf)"
    else
        echo -e "  ${GREEN}✓${NC} ripgrep"
    fi

    if ! command -v fd &> /dev/null && ! command -v fdfind &> /dev/null; then
        echo -e "  ${YELLOW}!${NC} fd (recommended for file finding)"
    else
        echo -e "  ${GREEN}✓${NC} fd"
    fi

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "${RED}Missing required dependencies: ${missing[*]}${NC}"
        echo -e "Please install them before continuing."
        exit 1
    fi
}

# Backup existing config
backup_config() {
    local config_path="$1"

    if [[ -d "$config_path" ]]; then
        local backup_path="${config_path}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}Backing up existing config to: ${backup_path}${NC}"
        mv "$config_path" "$backup_path"
    fi
}

# Install config
install_config() {
    local config_path="$1"
    local parent_dir=$(dirname "$config_path")

    # Create parent directory if it doesn't exist
    mkdir -p "$parent_dir"

    echo -e "${BLUE}Installing Neovim config to: ${config_path}${NC}"

    # Clone the repository
    git clone "$REPO_URL" "$config_path"

    echo -e "${GREEN}✓ Configuration installed successfully!${NC}"
}

# Post-install instructions
post_install() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Installation Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "Next steps:"
    echo -e "  1. Open Neovim: ${BLUE}nvim${NC}"
    echo -e "  2. Wait for lazy.nvim to install plugins"
    echo -e "  3. Run ${BLUE}:Mason${NC} to install LSP servers"
    echo ""
    echo -e "Recommended LSP servers to install:"
    echo -e "  - pyright (Python)"
    echo -e "  - typescript-language-server (JS/TS)"
    echo -e "  - lua-language-server (Lua)"
    echo -e "  - html, cssls, tailwindcss (Web)"
    echo ""
    echo -e "Key bindings: See ${BLUE}CLAUDE.md${NC} or press ${BLUE}<leader>?${NC} in Neovim"
}

# Main
main() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  Neovim Configuration Installer${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""

    detect_os
    check_dependencies

    local config_path=$(get_nvim_config_path)

    echo ""
    echo -e "Config will be installed to: ${BLUE}${config_path}${NC}"
    read -p "Continue? [Y/n] " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    backup_config "$config_path"
    install_config "$config_path"
    post_install
}

main "$@"
