#!/bin/bash

# Color definitions
RESET="\033[0m"
CYAN="\033[36m"
BLUE="\033[34m"
GREEN="\033[32m"
YELLOW="\033[33m"
MAGENTA="\033[35m"
BOLD="\033[1m"

# Get system information
HOSTNAME=$(hostname)
IP_ADDRESS=$(hostname -I | awk '{print $1}')
UPTIME=$(uptime -p | sed 's/up //')
OS=$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
KERNEL=$(uname -r)
SHELL_NAME=$(basename "$SHELL")
MEMORY=$(free -h | awk '/^Mem:/ {print $3 " / " $2}')
CPU=$(grep "model name" /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)
USER=$(whoami)

# Display the ANSI art
cat /home/math/fetch/dotfiles-cyan.txt

# Display system information inline
echo ""
echo -e "   ${GREEN}${USER}${RESET}.${CYAN}${HOSTNAME}${RESET}.${CYAN}${IP_ADDRESS}${RESET}.${MAGENTA}${OS}${RESET}.${BLUE}${KERNEL}${RESET}.${YELLOW}${SHELL_NAME}${RESET}"
