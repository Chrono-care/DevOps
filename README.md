# DevOps pour ChronoCare

## Description

Ce projet permet de déployer automatiquement l'infrastructure complète (front-end, back-end et services communs) via Docker. Le processus de déploiement vérifie la présence des dépôts front-end et back-end et les clone si nécessaire avant de lancer les conteneurs Docker.

## Installation

1. **Cloner le dépôt DevOps**

```bash
git clone https://github.com/Chrono-care/DevOps.git
cd DevOps
```

2. **Lancer le Makefile**

Le Makefile gère automatiquement le clonage des dépôts front-end et back-end s'ils n'existent pas déjà dans le dossier parent.

```bash
make start-dev
```

### Ce que fait la commande `make start-dev` :

- Vérifie si les dossiers `Front` et `Backend` existent dans le dossier parent :
  - S'ils existent, les conteneurs Docker sont directement lancés.
  - S'ils n'existent pas, les dépôts front-end et back-end sont clonés, puis les conteneurs sont lancés.

## Structure du projet

```
parent-folder/
├── Backend/            # Dépôt du back-end
├── DevOps/          # Dépôt DevOps
│   └── Makefile
└── Font/           # Dépôt du front-end
```

## Commandes Utiles

- **Lancer les services :**

```bash
make start-dev
```

- **Arrêter les services :**

```bash
make down
```