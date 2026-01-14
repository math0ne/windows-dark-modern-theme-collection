# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a system information display script (sysfetch) that shows custom ASCII art alongside system details. Available in both Bash (Linux/WSL) and PowerShell (Windows) versions.

## Usage

### Bash (Linux/WSL)
```bash
./sysfetch.sh          # Run the system fetch display
```

### PowerShell (Windows)
```powershell
.\sysfetch.ps1         # Run the system fetch display
```

## Architecture

### Main Scripts

#### `sysfetch.sh` (Bash)
- Bash script that gathers system information using standard Linux utilities
- Displays ASCII art from `dotfiles-cyan.txt` followed by system info
- System information collected:
  - Hostname, IP address, uptime
  - OS distribution and kernel version
  - Current user and shell
  - Memory usage and CPU model

#### `sysfetch.ps1` (PowerShell)
- PowerShell script that gathers system information using Windows CIM/WMI
- Displays the same ASCII art from `dotfiles-cyan.txt`
- System information collected:
  - Computer name, username, IP address
  - OS version and kernel version
  - PowerShell version
  - Memory usage and CPU model

### ASCII Art Files
- `dotfiles-cyan.txt` - ANSI art file with embedded color codes and cursor positioning (used by bash script)
- `dotfiles-plain.txt` - Plain text version with spaces instead of ANSI codes (used by PowerShell script)

## Key Implementation Details

### Color Scheme
Both scripts use consistent colors for system information:
- Green for username
- Cyan for hostname and IP address
- Magenta for OS
- Blue for kernel
- Yellow for shell

**Note**: The PowerShell version displays the ASCII art in cyan, while the bash version uses ANSI color codes embedded in the art file.

### System Information Commands
- `hostname` / `hostname -I` for network info
- `uptime -p` for system uptime
- `/etc/os-release` for OS distribution name
- `uname -r` for kernel version
- `free -h` for memory usage
- `/proc/cpuinfo` for CPU details

### Hardcoded Paths
- **Bash version**: References absolute path `/home/math/fetch/dotfiles-cyan.txt` on line 24
- **PowerShell version**: Uses `Split-Path` to find the script directory dynamically (portable)

## Running on Startup

### Bash (Linux/WSL)
Add to `~/.bashrc`:
```bash
/home/math/fetch/sysfetch.sh
```

### PowerShell (Windows)
Add to your PowerShell profile. Find profile location with `$PROFILE`, then add:
```powershell
& "C:\path\to\fetch\sysfetch.ps1"
```
Note: PowerShell may require execution policy adjustment: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
