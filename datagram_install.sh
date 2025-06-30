#!/bin/bash

# Datagram Node Installation Script
# Prepared for Ubuntu 24

set -e  # Stop script on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Datagram Node Installation Script ===${NC}"

# Check license key parameter
if [ -z "$1" ]; then
    echo -e "${RED}Error: License key not specified!${NC}"
    echo "Usage: $0 LICENSES_KEY"
    echo "Example: $0 abc123def456"
    echo ""
    echo "To get your license key:"
    echo "1. Register at: https://dashboard.datagram.network?ref=492622576"
    echo "2. Go to Wallet > Licenses > Copy your License Key"
    exit 1
fi

LICENSES_KEY="$1"

echo -e "${YELLOW}1. Downloading Datagram CLI...${NC}"
# Remove existing file (if exists)
if [ -f "datagram-cli-x86_64-linux" ]; then
    rm -f datagram-cli-x86_64-linux
fi

# Download latest version
wget -q --show-progress https://github.com/Datagram-Group/datagram-cli-release/releases/latest/download/datagram-cli-x86_64-linux

echo -e "${YELLOW}2. Moving file to /usr/local/bin directory...${NC}"
sudo mv datagram-cli-x86_64-linux /usr/local/bin/datagram-cli

echo -e "${YELLOW}3. Setting execution permissions...${NC}"
sudo chmod +x /usr/local/bin/datagram-cli

echo -e "${YELLOW}4. Checking screen installation...${NC}"
if ! command -v screen &> /dev/null; then
    echo -e "${YELLOW}Screen not installed, installing...${NC}"
    sudo apt update
    sudo apt install -y screen
fi

echo -e "${YELLOW}5. Starting Datagram node...${NC}"
echo -e "${GREEN}License Key: $LICENSES_KEY${NC}"

# Stop existing datagram session if it exists
if screen -list | grep -q "datagram"; then
    echo -e "${YELLOW}Stopping existing datagram session...${NC}"
    screen -S datagram -X quit 2>/dev/null || true
    sleep 2
fi

# Start screen session
screen -dmS datagram bash -c "datagram-cli run -- -key $LICENSES_KEY"

echo -e "${GREEN}✅ Installation completed!${NC}"
echo -e "${GREEN}Node is running in screen session named 'datagram'.${NC}"
echo ""
echo -e "${YELLOW}Useful commands:${NC}"
echo "• To view node status: screen -r datagram"
echo "• To exit from screen: Ctrl+A then D"
echo "• To list all screen sessions: screen -ls"
echo "• To stop the node: screen -S datagram -X quit"
echo ""
echo -e "${GREEN}Installation completed successfully! 🎉${NC}"
echo ""
echo -e "${YELLOW}Registration link: https://dashboard.datagram.network?ref=492622576${NC}"
echo -e "${YELLOW}Get your license key from: Wallet > Licenses > License Key${NC}"
