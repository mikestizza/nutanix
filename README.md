# Nutanix nmon Setup and Removal Scripts

These scripts provide a convenient way to install and remove the nmon performance monitoring tool on Nutanix Controller VMs (CVMs).

## Overview

- `nmon_setup.sh`: Installs nmon and necessary libraries on a Nutanix CVM
- `remove_nmon.sh`: Removes nmon and cleans up changes made by the setup script

## Setup Instructions

### Download and Run from Home Directory

The Nutanix CVM environment has certain restrictions. For best results:

1. Download the setup script to your home directory:
```bash
curl -o ~/nmon_setup.sh https://raw.githubusercontent.com/mikestizza/nutanix/main/nmon_setup.sh
```

2. Make it executable and run it:
```bash
chmod +x ~/nmon_setup.sh
~/nmon_setup.sh
```

### Alternative Method: Run with Bash

If you encounter permission issues, you can run the script directly with bash:

```bash
# Download
curl -o ~/nmon_setup.sh https://raw.githubusercontent.com/mikestizza/nutanix/main/nmon_setup.sh

# Execute with bash (no need for executable permissions)
bash ~/nmon_setup.sh
```

### What the Setup Script Does

- Downloads nmon binaries from SourceForge
- Extracts the appropriate Rocky Linux 8 binary
- Creates necessary library symlinks
- Sets up nmon in your ~/bin directory
- Adds the bin directory to your PATH

## Usage

After installation, you can run nmon by typing:
```bash
nmon
```

### Interactive Commands in nmon

- `c` - Display CPU utilization
- `m` - Display memory information
- `d` - Display disk information 
- `n` - Display network information
- `h` - For help
- `q` - To quit

## Removal Instructions

### Download and Run from Home Directory

1. Download the removal script:
```bash
curl -o ~/remove_nmon.sh https://raw.githubusercontent.com/mikestizza/nutanix/main/remove_nmon.sh
```

2. Execute it with bash:
```bash
bash ~/remove_nmon.sh
```

### What the Removal Script Does

- Removes the nmon binary from ~/bin
- Removes symbolic links created during installation
- Cleans up PATH modifications in ~/.bashrc

## Important Notes

- **Nutanix System File Protection**: Nutanix CVMs have file protection mechanisms that prevent deleting certain files. If you encounter permissions issues when cleaning up, you may need to use one of the alternative approaches in the removal script.

- **/tmp Execution**: The /tmp directory on Nutanix CVMs is mounted with the `noexec` flag, so scripts cannot be executed directly from there. Always download and run scripts from your home directory or use `bash script.sh` to execute them.

- **Alternative CPUs**: If you're on a different CPU architecture or OS version, you might need to modify the script to use a different nmon binary from the package.

## Troubleshooting

- **"System files detected" error**: This is a Nutanix protection mechanism. Try using the provided removal script instead of directly deleting files.
  
- **"Permission denied" error**: If you can't run the scripts with `./script.sh`, use `bash script.sh` instead.

- **Libraries not found**: If nmon fails with a library error, the symlinks might not be created correctly. Check the script output for errors.

## License

These scripts are provided as-is with no warranty. Use at your own risk.
