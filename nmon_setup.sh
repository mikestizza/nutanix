#!/bin/bash
#
# Nutanix CVM nmon Setup Script
# This script downloads and sets up nmon for Rocky Linux 8
#

# Create temporary directory
echo "Creating temporary directory..."
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download nmon binaries package
echo "Downloading nmon binaries..."
wget -q https://sourceforge.net/projects/nmon/files/nmon16p_32_binaries_feb_2024.tar.gz/download -O nmon_binaries.tar.gz

# Extract package
echo "Extracting files..."
tar xzf nmon_binaries.tar.gz

# Navigate to extracted directory and find Rocky binaries
echo "Setting up nmon..."
cd nmon16p_binaries
chmod +x nmon_x86_64_rocky8

# Create lib symlinks if they don't exist
if [ ! -f /usr/lib64/libncurses.so.5 ]; then
  echo "Creating libncurses.so.5 symlink..."
  sudo ln -s /usr/lib64/libncurses.so.6 /usr/lib64/libncurses.so.5
fi

if [ ! -f /usr/lib64/libtinfo.so.5 ]; then
  echo "Creating libtinfo.so.5 symlink..."
  sudo ln -s /usr/lib64/libtinfo.so.6 /usr/lib64/libtinfo.so.5
fi

# Create user bin directory if it doesn't exist
mkdir -p ~/bin

# Copy nmon to bin directory
echo "Installing nmon to ~/bin..."
cp nmon_x86_64_rocky8 ~/bin/nmon
chmod +x ~/bin/nmon

# Add bin to PATH if not already there
if ! grep -q 'export PATH=$PATH:~/bin' ~/.bashrc; then
  echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
  source ~/.bashrc
fi

# Clean up
echo "Cleaning up..."
cd
rm -rf "$TEMP_DIR"

# Instructions
echo -e "\nInstallation complete!"
echo "You can now run nmon by typing: ~/bin/nmon"
echo "If you sourced your ~/.bashrc, you can simply type: nmon"
echo ""
echo "Interactive commands within nmon:"
echo "  'c' - Display CPU utilization"
echo "  'm' - Display memory information"
echo "  'd' - Display disk information"
echo "  'n' - Display network information"
echo "  'h' - For help"
echo "  'q' - To quit"
echo ""
echo "Would you like to run nmon now? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  ~/bin/nmon
fi
