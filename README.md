# Datagram Node Installation Script

An automated installation script for Datagram Node on Ubuntu 24 servers. This script simplifies the installation process and allows you to deploy Datagram nodes across multiple servers quickly.

## 🚀 Quick Start

### Step 1: Register for Datagram
Before using this script, you must register for Datagram:
1. Visit the registration link: [Register](https://dashboard.datagram.network?ref=492622576)
2. Complete the registration process
3. Log in to your dashboard

### Step 2: Get Your License Key
1. In the Datagram dashboard, navigate to **Wallet** section
2. Click on the **Licenses** tab
3. Copy your **License Key** from the "Licenses Key" field
4. Keep this key ready - you'll need it for the installation

### Step 3: Run the Installation Script
```bash
# Download and run the script directly
wget -O - https://raw.githubusercontent.com/halilunay/DataGram/refs/heads/main/datagram_install.sh | bash -s YOUR_LICENSES_KEY

# Or download first, then run
wget https://raw.githubusercontent.com/halilunay/DataGram/refs/heads/main/datagram_install.sh
chmod +x datagram_install.sh
./datagram_install.sh YOUR_LICENSES_KEY
```

**Replace `YOUR_LICENSES_KEY` with the actual license key you copied from the dashboard.**

## 📋 What This Script Does

1. **Downloads** the latest Datagram CLI binary
2. **Installs** it to `/usr/local/bin/datagram-cli`
3. **Sets** proper execution permissions
4. **Checks and installs** screen (if not already installed)
5. **Starts** the Datagram node in a screen session named "datagram"

## 🖥️ Managing Your Node

After installation, your Datagram node will be running in a screen session. Here are useful commands:

### View Node Status
```bash
screen -r datagram
```
*Press `Ctrl+A` then `D` to detach from screen without stopping the node*

### List All Screen Sessions
```bash
screen -ls
```

### Stop the Node
```bash
screen -S datagram -X quit
```

### Restart the Node
```bash
screen -dmS datagram bash -c "datagram-cli run -- -key YOUR_LICENSES_KEY"
```

## 🔧 Requirements

- **Operating System**: Ubuntu 24.04 LTS
- **Architecture**: x86_64 (64-bit)
- **Privileges**: sudo access required
- **Network**: Internet connection for downloading components
- **Account**: Valid Datagram account with license key

## 🌐 Multi-Server Installation

For installing on multiple servers, you can use SSH to run the script remotely:

```bash
# Single command for multiple servers
for server in server1.com server2.com 192.168.1.10; do
    ssh $server "wget -O - https://raw.githubusercontent.com/halilunay/DataGram/refs/heads/main/datagram_install.sh | bash -s YOUR_LICENSES_KEY"
done
```

## 🛡️ Security Notes

- Ensure your license key is kept secure and not shared
- The script requires sudo privileges for system-level installation
- Screen sessions persist after SSH disconnection, keeping your node running

## ❓ Troubleshooting

### Script Fails to Download
- Check your internet connection
- Verify the GitHub repository is accessible
- Try downloading manually with `wget` or `curl`

### Permission Denied Errors
- Ensure you have sudo privileges on the server
- Check if the user can execute commands with sudo

### Node Not Starting
- Verify your license key is correct
- Check if screen is properly installed: `screen --version`
- Look for error messages in the screen session: `screen -r datagram`

### Can't Connect to Screen Session
```bash
# List all sessions
screen -ls

# If the session exists but you can't connect, try:
screen -d -r datagram
```

## 📞 Support

If you encounter issues:
1. Check the [Datagram official documentation](https://dashboard.datagram.network)
2. Verify your license key in the dashboard
3. Ensure your server meets all requirements

## 📄 License

This installation script is provided as-is for the Datagram community. Please refer to Datagram's official terms of service for node operation guidelines.

---

**Important**: Always ensure you're using the latest version of this script and that your Datagram account is in good standing before running nodes.
