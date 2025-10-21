# 📁 ÉTAPE 5 : Mode Développement (Hot Reload)

## 🎯 Objectif
Configurer Docker Compose pour le développement itératif sans rebuild.

## 📋 Fichier principal

### `docker-compose.dev.yml`
**Rôle :** Override de configuration pour le développement
**Ce qu'il ajoute :**
- Volumes montés pour modifier les fichiers sans rebuild
- Variables d'environnement de debug

## 💡 Problème à résoudre

### Sans mode développement

```bash
# Modifier index.html
nano web/static/index.html

# Reconstruire l'image (lent!)
docker compose build web

# Redémarrer (lent!)
docker compose up -d web
```

**Temps total : 1-2 minutes par modification ! 😞**

### Avec mode développement

```bash
# Modifier index.html
nano web/static/index.html

# Rafraîchir le navigateur
# → Changement visible immédiatement ! ✅
```

**Temps total : 0 secondes ! 🎉**

## 🚀 Utilisation

### Démarrer en mode développement

```bash
# Combiner les deux fichiers
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# Ou créer un alias
# PowerShell:
function dev { docker compose -f docker-compose.yml -f docker-compose.dev.yml @args }
dev up -d

# Bash/Zsh:
alias dev='docker compose -f docker-compose.yml -f docker-compose.dev.yml'
dev up -d
```

### Modifier l'interface

```bash
# Ouvrir web/static/index.html dans votre éditeur
code web/static/index.html

# Faire vos modifications
# ...

# Sauvegarder

# Rafraîchir http://localhost dans le navigateur
# → Les changements apparaissent instantanément !
```

## 📊 Comment ça fonctionne ?

### Volumes Docker

#### Mode production (sans volume)
```
Votre PC                  Conteneur
┌─────────────┐           ┌────────────┐
│ web/static/ │ ─ build → │ /app/static│
│  index.html │           │  index.html│ (copie)
└─────────────┘           └────────────┘
     ↓ modifier                 ↕
  (besoin de                (pas de lien)
   rebuild!)
```

#### Mode développement (avec volume)
```
Votre PC                  Conteneur
┌─────────────┐           ┌────────────┐
│ web/static/ │ ←────────→│ /app/static│
│  index.html │  (monté)  │  index.html│ (lien direct)
└─────────────┘           └────────────┘
     ↓ modifier                 ↓
  (changement           (changement
   instantané!)          visible!)
```

### Configuration dans docker-compose.dev.yml

```yaml
services:
  web:
    volumes:
      # Monte le dossier local dans le conteneur
      - ./web/static:/app/static:ro
      #  ↑               ↑           ↑
      #  Dossier local   |           ro = read-only
      #                  Dossier conteneur
```

## 🔍 Détails techniques

### Read-Only (`:ro`)

```yaml
volumes:
  - ./web/static:/app/static:ro
```

**Pourquoi `:ro` ?**
- Évite que le conteneur modifie vos fichiers locaux
- Sécurité : le conteneur peut lire mais pas écrire
- Bonne pratique en développement

### Variables d'environnement de dev

```yaml
environment:
  - ENV=development
  - DEBUG=true
```

Permet au code de savoir qu'il est en mode dev :
- Afficher plus de logs
- Désactiver le cache
- Activer le mode debug

## ✅ Fichiers modifiables sans rebuild

Avec ce mode, vous pouvez modifier :

### Dans `web/static/`
- ✅ `index.html` - HTML
- ✅ `style.css` - Styles CSS
- ✅ `app.js` - JavaScript
- ✅ Images dans `images/`
- ✅ Polices dans `fonts/`

### Ce qui nécessite encore un rebuild

- ❌ `dispatcher.go` (code Go compilé)
- ❌ `Main.java` (code Java compilé)
- ❌ Dockerfiles
- ❌ Configuration Compose

## 🧪 Tester le mode développement

```bash
# 1. Démarrer en mode dev
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# 2. Ouvrir http://localhost dans le navigateur

# 3. Modifier le titre dans web/static/index.html
# Trouver la ligne avec <h1> et changer le texte

# 4. Sauvegarder le fichier

# 5. Rafraîchir le navigateur (F5)
# → Le nouveau titre apparaît immédiatement !

# 6. Arrêter
docker compose down
```

## 💡 Astuces

### Live Reload automatique

Pour un rechargement automatique du navigateur, ajoutez un outil comme :
- **Browser-sync** (Node.js)
- **LiveReload** (Extension navigateur)

### Voir les logs en temps réel

```bash
# Terminal 1 : Lancer l'app
docker compose -f docker-compose.yml -f docker-compose.dev.yml up

# Les logs s'affichent en direct
# Ctrl+C pour arrêter

# Ou en arrière-plan + logs séparés:
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d
docker compose logs -f web
```

### Créer un script de démarrage

**Windows (PowerShell) :**
```powershell
# dev.ps1
docker compose -f docker-compose.yml -f docker-compose.dev.yml @args

# Utilisation :
.\dev.ps1 up -d
.\dev.ps1 logs -f
.\dev.ps1 down
```

**Linux/Mac (Bash) :**
```bash
# dev.sh
#!/bin/bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml "$@"

# Utilisation :
./dev.sh up -d
./dev.sh logs -f
./dev.sh down
```

## 🔗 Prochaine étape

→ Voir `ETAPE_6.md` pour déployer plusieurs instances de Wordsmith

