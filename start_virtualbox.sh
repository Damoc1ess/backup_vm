#!/bin/bash

# === Configuration (à modifier selon votre installation) ===
VM_NAME="T-800"  # Nom de la VM dans VirtualBox
BACKUP_SCRIPT="$HOME/vm-backup/backup_vm.sh"  # Chemin du script de backup

# === Exécuter le script de backup ===
echo "Starting backup before launching VirtualBox..."
bash "$BACKUP_SCRIPT"

# === Lancer VirtualBox ===
echo "Launching VirtualBox..."
virtualbox &
