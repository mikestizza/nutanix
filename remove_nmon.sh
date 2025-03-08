#!/bin/bash
#
# Nutanix CVM nmon Removal Script
# This script removes nmon and cleans up any changes made during installation
#

echo "Starting nmon removal..."

# Remove nmon binary
if [ -f ~/bin/nmon ]; then
  echo "Removing nmon binary..."
  rm -f ~/bin/nmon
  
  # Remove bin directory if it's empty
  if [ -z "$(ls -A ~/bin 2>/dev/null)" ]; then
    echo "Removing empty bin directory..."
    rmdir ~/bin
  else
    echo "~/bin directory contains other files and will not be removed."
  fi
else
  echo "nmon binary not found in ~/bin."
fi

# Remove symbolic links if they exist and appear to be our symlinks
if [ -L /usr/lib64/libncurses.so.5 ]; then
  if [ "$(readlink /usr/lib64/libncurses.so.5)" == "/usr/lib64/libncurses.so.6" ]; then
    echo "Removing libncurses.so.5 symlink..."
    sudo rm -f /usr/lib64/libncurses.so.5
  else
    echo "Found libncurses.so.5 but it doesn't point to libncurses.so.6. Leaving it intact."
  fi
fi

if [ -L /usr/lib64/libtinfo.so.5 ]; then
  if [ "$(readlink /usr/lib64/libtinfo.so.5)" == "/usr/lib64/libtinfo.so.6" ]; then
    echo "Removing libtinfo.so.5 symlink..."
    sudo rm -f /usr/lib64/libtinfo.so.5
  else
    echo "Found libtinfo.so.5 but it doesn't point to libtinfo.so.6. Leaving it intact."
  fi
fi

# Remove PATH entry from .bashrc
if grep -q 'export PATH=$PATH:~/bin' ~/.bashrc; then
  echo "Removing PATH entry from .bashrc..."
  sed -i '/export PATH=$PATH:~\/bin/d' ~/.bashrc
  echo "Note: You'll need to start a new shell or run 'source ~/.bashrc' for PATH changes to take effect."
fi

# Check for any remaining nmon binaries from the original package
echo "Checking for any other nmon binaries..."
NMON_FILES=$(find ~ -name "nmon*" 2>/dev/null)
if [ -n "$NMON_FILES" ]; then
  echo "Found the following nmon-related files that you may want to review:"
  echo "$NMON_FILES"
  echo "These files were not automatically removed."
fi

echo -e "\nnmon removal complete!"
echo "All changes made by the nmon setup script have been reversed."
