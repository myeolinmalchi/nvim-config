# Neovim Configuration Installer for Windows
# Run: powershell -ExecutionPolicy Bypass -File install.ps1

$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/myeolinmalchi/nvim-config.git"

function Write-Color {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color
}

function Get-NvimConfigPath {
    $localAppData = $env:LOCALAPPDATA
    if (-not $localAppData) {
        $localAppData = "$env:USERPROFILE\AppData\Local"
    }
    return "$localAppData\nvim"
}

function Test-Command {
    param([string]$Command)
    $null = Get-Command $Command -ErrorAction SilentlyContinue
    return $?
}

function Check-Dependencies {
    Write-Color "`nChecking dependencies..." "Cyan"

    $missing = @()

    # Required
    if (Test-Command "nvim") {
        $version = & nvim --version | Select-Object -First 1
        Write-Color "  [OK] $version" "Green"
    } else {
        $missing += "neovim"
        Write-Color "  [X] Neovim not found" "Red"
    }

    if (Test-Command "git") {
        Write-Color "  [OK] Git" "Green"
    } else {
        $missing += "git"
        Write-Color "  [X] Git not found" "Red"
    }

    # Optional
    if (Test-Command "node") {
        Write-Color "  [OK] Node.js" "Green"
    } else {
        Write-Color "  [!] Node.js (recommended for LSP servers)" "Yellow"
    }

    if (Test-Command "python") {
        Write-Color "  [OK] Python" "Green"
    } elseif (Test-Command "python3") {
        Write-Color "  [OK] Python3" "Green"
    } else {
        Write-Color "  [!] Python (recommended for some plugins)" "Yellow"
    }

    if (Test-Command "rg") {
        Write-Color "  [OK] ripgrep" "Green"
    } else {
        Write-Color "  [!] ripgrep (recommended for search)" "Yellow"
    }

    if (Test-Command "fd") {
        Write-Color "  [OK] fd" "Green"
    } else {
        Write-Color "  [!] fd (recommended for file finding)" "Yellow"
    }

    if ($missing.Count -gt 0) {
        Write-Color "`nMissing required dependencies: $($missing -join ', ')" "Red"
        Write-Color "Please install them before continuing." "Red"
        Write-Color "`nInstall with:" "Yellow"
        Write-Color "  winget install Neovim.Neovim" "White"
        Write-Color "  winget install Git.Git" "White"
        exit 1
    }
}

function Backup-Config {
    param([string]$ConfigPath)

    if (Test-Path $ConfigPath) {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backupPath = "${ConfigPath}.backup.${timestamp}"
        Write-Color "Backing up existing config to: $backupPath" "Yellow"
        Move-Item -Path $ConfigPath -Destination $backupPath
    }
}

function Install-Config {
    param([string]$ConfigPath)

    $parentDir = Split-Path -Parent $ConfigPath
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    Write-Color "`nInstalling Neovim config to: $ConfigPath" "Cyan"

    & git clone $RepoUrl $ConfigPath

    if ($LASTEXITCODE -eq 0) {
        Write-Color "[OK] Configuration installed successfully!" "Green"
    } else {
        Write-Color "[X] Failed to clone repository" "Red"
        exit 1
    }
}

function Show-PostInstall {
    Write-Color "`n========================================" "Green"
    Write-Color "  Installation Complete!" "Green"
    Write-Color "========================================`n" "Green"

    Write-Color "Next steps:" "White"
    Write-Color "  1. Open Neovim: nvim" "Cyan"
    Write-Color "  2. Wait for lazy.nvim to install plugins" "White"
    Write-Color "  3. Run :Mason to install LSP servers`n" "White"

    Write-Color "Recommended LSP servers to install:" "White"
    Write-Color "  - pyright (Python)" "White"
    Write-Color "  - typescript-language-server (JS/TS)" "White"
    Write-Color "  - lua-language-server (Lua)" "White"
    Write-Color "  - html, cssls, tailwindcss (Web)`n" "White"

    Write-Color "Key bindings: See CLAUDE.md or press <leader>? in Neovim" "Cyan"
}

# Main
function Main {
    Write-Color "========================================" "Cyan"
    Write-Color "  Neovim Configuration Installer" "Cyan"
    Write-Color "========================================" "Cyan"
    Write-Color "OS: Windows`n" "Cyan"

    Check-Dependencies

    $configPath = Get-NvimConfigPath

    Write-Color "`nConfig will be installed to: $configPath" "Cyan"
    $response = Read-Host "Continue? [Y/n]"

    if ($response -eq 'n' -or $response -eq 'N') {
        Write-Color "Installation cancelled." "Yellow"
        exit 0
    }

    Backup-Config -ConfigPath $configPath
    Install-Config -ConfigPath $configPath
    Show-PostInstall
}

Main
