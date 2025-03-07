# VirtualBox Auto Backup

This project provides scripts to automatically back up your VirtualBox VM disk before launching VirtualBox. The system is designed to keep only the last two backups (by deleting the oldest one), so that you always have a recent backup without filling up your storage.

## Features
- **Automatic backup before launching VirtualBox**
- **Keeps only the last two backups** (the oldest backup is automatically removed)
- **Customizable for any VirtualBox VM**
- **Easy integration via a launcher script and alias**

## Installation

### 1. Clone the Repository
Clone this repository into your local machine:
```sh
git clone https://github.com/yourusername/vm-backup.git
cd vm-backup

Configuration: What You Need to Modify

Before using the scripts, you must modify two files to match your VirtualBox setup. A. Modify backup_vm.sh (Backup Configuration)

This script creates a backup of your VM's disk.

Open backup_vm.sh in your favorite editor:

nano backup_vm.sh

Modify the following lines (the ones in the Configuration section):

# Configuration - CHANGE THESE VALUES TO MATCH YOUR SETUP
VM_NAME="Your-VM-Name"                 # Change to the name of your VirtualBox VM
SOURCE="/path/to/your/vm.vdi"          # Change to the full path of your VM disk (the .vdi file)
BACKUP_DIR="/path/to/your/backup/"     # Change to the directory where you want to store your backups

Example:

VM_NAME="Ubuntu-VM"
SOURCE="/media/user/VirtualBox VMs/Ubuntu-VM/Ubuntu-VM.vdi"
BACKUP_DIR="/media/user/Backups/"

Save and exit (press CTRL + X, then Y, then Enter).

B. Modify start_virtualbox.sh (Launcher Configuration)

This script runs the backup before launching VirtualBox.

Open start_virtualbox.sh:

nano start_virtualbox.sh

Modify the following line to point to the correct location of backup_vm.sh:

BACKUP_SCRIPT="/path/to/your/vm-backup/backup_vm.sh"

Example:

BACKUP_SCRIPT="/home/user/vm-backup/backup_vm.sh"

Save and exit (press CTRL + X, then Y, then Enter).

Final Steps

    Make the Scripts Executable

Run the following command to ensure the scripts have execution permissions:

chmod +x backup_vm.sh start_virtualbox.sh

    Launch VirtualBox with Backup

Instead of launching VirtualBox normally, run the launcher script:

./start_virtualbox.sh

This will:

    Execute the backup (if your VM is not running).
    Keep only the two most recent backups (deleting the oldest one if necessary).
    Launch VirtualBox afterwards.

    (Optional) Create an Alias for Easy Launching

To replace the default VirtualBox command with your backup launcher, add an alias to your shell configuration file.

Open your shell configuration file (e.g., ~/.bashrc or ~/.zshrc):

nano ~/.zshrc

Add the following line at the end:

alias virtualbox="~/vm-backup/start_virtualbox.sh"

Save and exit, then source your configuration:

source ~/.zshrc

Now, whenever you type virtualbox in the terminal, it will run your backup script first, then launch VirtualBox.

How the Backup System Works

    Backup Creation: Before launching VirtualBox, the backup_vm.sh script creates a new backup of your VM's .vdi file. The backup is saved in the directory specified by BACKUP_DIR with a numbered name (e.g., Ubuntu-VM-Backup-1.vdi, Ubuntu-VM-Backup-2.vdi).

    Backup Retention: The script automatically checks the number of backups present. If there are already two backups, it deletes the oldest one before creating a new backup. This ensures that you always have the two most recent backups without using unnecessary disk space.

    Backup Condition: The backup will only run if the VirtualBox VM is not currently running. This helps ensure the backup file is consistent and not corrupted by live disk changes.