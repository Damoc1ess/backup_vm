# VirtualBox Auto Backup

Ce projet fournit des scripts pour sauvegarder automatiquement le disque de votre VM VirtualBox avant de lancer VirtualBox. Le système est conçu pour ne conserver que les deux dernières sauvegardes (en supprimant la plus ancienne), afin que vous ayez toujours une sauvegarde récente sans remplir votre espace de stockage.

## Fonctionnalités
- **Sauvegarde automatique avant le lancement de VirtualBox**
- **Conserve uniquement les deux dernières sauvegardes** (la sauvegarde la plus ancienne est automatiquement supprimée)
- **Personnalisable pour toute VM VirtualBox**
- **Intégration facile via un script de lancement et un alias**

## Installation

### 1. Cloner le dépôt
Clonez ce dépôt sur votre machine locale :
```sh
git clone https://github.com/yourusername/vm-backup.git
cd vm-backup
```

### 2. Configuration : Ce que vous devez modifier

Avant d'utiliser les scripts, vous devez modifier deux fichiers pour correspondre à votre configuration VirtualBox.

#### A. Modifier `backup_vm.sh` (Configuration de la sauvegarde)

Ce script crée une sauvegarde du disque de votre VM.

Ouvrez `backup_vm.sh` dans votre éditeur préféré :
```sh
nano backup_vm.sh
```

Modifiez les lignes suivantes (dans la section Configuration) :
```sh
# Configuration - CHANGE THESE VALUES TO MATCH YOUR SETUP
VM_NAME="Your-VM-Name"                 # Changez pour le nom de votre VM VirtualBox
SOURCE="/path/to/your/vm.vdi"          # Changez pour le chemin complet de votre disque VM (.vdi)
BACKUP_DIR="/path/to/your/backup/"     # Changez pour le répertoire où vous souhaitez stocker vos sauvegardes
```

Exemple :
```sh
VM_NAME="Ubuntu-VM"
SOURCE="/media/user/VirtualBox VMs/Ubuntu-VM/Ubuntu-VM.vdi"
BACKUP_DIR="/media/user/Backups/"
```

Enregistrez et quittez (appuyez sur `CTRL + X`, puis `Y`, puis `Entrée`).

#### B. Modifier `start_virtualbox.sh` (Configuration du lanceur)

Ce script exécute la sauvegarde avant de lancer VirtualBox.

Ouvrez `start_virtualbox.sh` :
```sh
nano start_virtualbox.sh
```

Modifiez la ligne suivante pour pointer vers l'emplacement correct de `backup_vm.sh` :
```sh
BACKUP_SCRIPT="/path/to/your/vm-backup/backup_vm.sh"
```

Exemple :
```sh
BACKUP_SCRIPT="/home/user/vm-backup/backup_vm.sh"
```

Enregistrez et quittez (appuyez sur `CTRL + X`, puis `Y`, puis `Entrée`).

### Étapes finales

#### 1. Rendre les scripts exécutables

Exécutez la commande suivante pour vous assurer que les scripts ont les permissions d'exécution :
```sh
chmod +x backup_vm.sh start_virtualbox.sh
```

#### 2. Lancer VirtualBox avec sauvegarde

Au lieu de lancer VirtualBox normalement, exécutez le script de lancement :
```sh
./start_virtualbox.sh
```

Cela va :
1. Exécuter la sauvegarde (si votre VM n'est pas en cours d'exécution).
2. Conserver uniquement les deux sauvegardes les plus récentes (en supprimant la plus ancienne si nécessaire).
3. Lancer VirtualBox ensuite.

#### (Optionnel) Créer un alias pour un lancement facile

Pour remplacer la commande VirtualBox par défaut par votre lanceur de sauvegarde, ajoutez un alias à votre fichier de configuration de shell.

Ouvrez votre fichier de configuration de shell (par exemple, `~/.bashrc` ou `~/.zshrc`) :
```sh
nano ~/.zshrc
```

Ajoutez la ligne suivante à la fin :
```sh
alias virtualbox="~/vm-backup/start_virtualbox.sh"
```

Enregistrez et quittez, puis sourcez votre configuration :
```sh
source ~/.zshrc
```

Maintenant, chaque fois que vous tapez `virtualbox` dans le terminal, cela exécutera d'abord votre script de sauvegarde, puis lancera VirtualBox.

## Comment fonctionne le système de sauvegarde

1. **Création de la sauvegarde** : Avant de lancer VirtualBox, le script `backup_vm.sh` crée une nouvelle sauvegarde du fichier .vdi de votre VM. La sauvegarde est enregistrée dans le répertoire spécifié par `BACKUP_DIR` avec un nom numéroté (par exemple, `Ubuntu-VM-Backup-1.vdi`, `Ubuntu-VM-Backup-2.vdi`).

2. **Rétention des sauvegardes** : Le script vérifie automatiquement le nombre de sauvegardes présentes. S'il y a déjà deux sauvegardes, il supprime la plus ancienne avant de créer une nouvelle sauvegarde. Cela garantit que vous avez toujours les deux sauvegardes les plus récentes sans utiliser d'espace disque inutile.

3. **Condition de sauvegarde** : La sauvegarde ne s'exécutera que si la VM VirtualBox n'est pas en cours d'exécution. Cela permet de s'assurer que le fichier de sauvegarde est cohérent et non corrompu par des modifications en direct du disque.