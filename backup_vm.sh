#!/bin/bash

# === Configuration (à modifier selon votre installation) ===
VM_NAME="T-800"  # Nom de la VM dans VirtualBox
SOURCE="/path/to/your/vm/T-800.vdi"  # Chemin vers votre disque virtuel
BACKUP_DIR="/path/to/your/backup/directory"  # Chemin où stocker les backups

# === Vérification du dossier de backup ===
mkdir -p "$BACKUP_DIR"

# === Lister les backups existants et compter combien il y en a ===
BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/"$VM_NAME"-Backup-*.vdi 2>/dev/null | wc -l)

# === Définir le nom du nouveau backup avec un numéro ===
NEXT_NUM=$((BACKUP_COUNT + 1))
DEST="$BACKUP_DIR/$VM_NAME-Backup-$NEXT_NUM.vdi"

# === Supprimer l'ancien backup s'il y en a plus de 2 ===
if [ "$BACKUP_COUNT" -ge 2 ]; then
    OLDEST_BACKUP=$(ls -1t "$BACKUP_DIR"/"$VM_NAME"-Backup-*.vdi | tail -1)
    echo "Removing oldest backup: $OLDEST_BACKUP"
    rm -f "$OLDEST_BACKUP"
fi

# === Vérifier si la VM est en cours d'exécution ===
VM_RUNNING=$(VBoxManage list runningvms | grep "$VM_NAME")

if [ -z "$VM_RUNNING" ]; then
    echo "Starting backup..."
    rsync -av --progress "$SOURCE" "$DEST"
    echo "Backup completed: $(date)"
else
    echo "The VM is running. Backup canceled."
fi
