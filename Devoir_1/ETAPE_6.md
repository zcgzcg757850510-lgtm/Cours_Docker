# 📁 ÉTAPE 6 : Multi-Instances (Déploiement Multiple)

## 🎯 Objectif
Déployer plusieurs instances de Wordsmith sur la même machine.

## 📋 Fichiers

- `docker-compose.override.example.yml` - Template pour override

## 💡 Cas d'usage

### Pourquoi plusieurs instances ?

1. **Environnements multiples**
   - Instance "prod" sur port 80
   - Instance "dev" sur port 8080
   - Instance "staging" sur port 8081

2. **Tests**
   - Tester différentes versions
   - Comparer les performances

3. **Développement en équipe**
   - Chaque développeur a sa propre instance

## 🚀 Méthode 1 : Project Name (`-p`)

### Principe

Docker Compose utilise le nom du dossier comme nom de projet par défaut.  
On peut le changer avec `-p` :

```bash
# Instance 1 : wordsmith-prod
docker compose -p wordsmith-prod up -d

# Instance 2 : wordsmith-dev
docker compose -p wordsmith-dev up -d
```

### Problème

Les deux instances veulent utiliser le même port 80 ! 💥

**Solution :** Créer des fichiers override avec des ports différents.

### Étapes

#### 1. Créer un fichier override pour chaque instance

**Instance prod (port 80) :**
```yaml
# docker-compose.prod.yml
version: '3.8'
services:
  web:
    ports:
      - "80:80"
```

**Instance dev (port 8080) :**
```yaml
# docker-compose.dev-instance.yml
version: '3.8'
services:
  web:
    ports:
      - "8080:80"
```

**Instance staging (port 8081) :**
```yaml
# docker-compose.staging.yml
version: '3.8'
services:
  web:
    ports:
      - "8081:80"
```

#### 2. Démarrer chaque instance

```bash
# Instance production (port 80)
docker compose -f docker-compose.yml -f docker-compose.prod.yml -p wordsmith-prod up -d

# Instance développement (port 8080)
docker compose -f docker-compose.yml -f docker-compose.dev-instance.yml -p wordsmith-dev up -d

# Instance staging (port 8081)
docker compose -f docker-compose.yml -f docker-compose.staging.yml -p wordsmith-staging up -d
```

#### 3. Vérifier

```bash
# Lister les projets Compose
docker compose ls

# Devrait afficher :
# NAME                STATUS
# wordsmith-prod      running(3)
# wordsmith-dev       running(3)
# wordsmith-staging   running(3)

# Accéder aux instances :
# http://localhost:80      (prod)
# http://localhost:8080    (dev)
# http://localhost:8081    (staging)
```

## 🚀 Méthode 2 : Variables d'environnement

### Principe

Utiliser un fichier `.env` pour chaque instance.

### Étapes

#### 1. Modifier docker-compose.yml pour utiliser des variables

```yaml
services:
  web:
    ports:
      - "${WEB_PORT:-80}:80"
```

`${WEB_PORT:-80}` signifie :
- Utilise la variable `WEB_PORT` si elle existe
- Sinon, utilise `80` par défaut

#### 2. Créer des dossiers pour chaque instance

```bash
mkdir -p instances/prod instances/dev instances/staging
```

#### 3. Créer un fichier .env dans chaque dossier

**instances/prod/.env :**
```
COMPOSE_PROJECT_NAME=wordsmith-prod
WEB_PORT=80
```

**instances/dev/.env :**
```
COMPOSE_PROJECT_NAME=wordsmith-dev
WEB_PORT=8080
```

**instances/staging/.env :**
```
COMPOSE_PROJECT_NAME=wordsmith-staging
WEB_PORT=8081
```

#### 4. Lancer depuis chaque dossier

```bash
# Terminal 1 : Production
cd instances/prod
docker compose -f ../../docker-compose.yml up -d

# Terminal 2 : Dev
cd instances/dev
docker compose -f ../../docker-compose.yml up -d

# Terminal 3 : Staging
cd instances/staging
docker compose -f ../../docker-compose.yml up -d
```

## 🚀 Méthode 3 : Script automatisé

### Créer un script de déploiement

**Windows (PowerShell) :**
```powershell
# deploy-instance.ps1
param(
    [string]$InstanceName,
    [int]$Port
)

if (-not $InstanceName -or -not $Port) {
    Write-Host "Usage: .\deploy-instance.ps1 <nom> <port>"
    Write-Host "Exemple: .\deploy-instance.ps1 prod 80"
    exit 1
}

$override = @"
version: '3.8'
services:
  web:
    ports:
      - "$Port:80"
"@

$override | Out-File -FilePath "docker-compose.$InstanceName.yml"

docker compose -f docker-compose.yml -f "docker-compose.$InstanceName.yml" -p "wordsmith-$InstanceName" up -d

Write-Host "Instance $InstanceName déployée sur http://localhost:$Port"
```

**Utilisation :**
```powershell
.\deploy-instance.ps1 prod 80
.\deploy-instance.ps1 dev 8080
.\deploy-instance.ps1 staging 8081
```

**Linux/Mac (Bash) :**
```bash
#!/bin/bash
# deploy-instance.sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <nom> <port>"
    echo "Exemple: $0 prod 80"
    exit 1
fi

INSTANCE=$1
PORT=$2

cat > docker-compose.$INSTANCE.yml << EOF
version: '3.8'
services:
  web:
    ports:
      - "$PORT:80"
EOF

docker compose -f docker-compose.yml -f docker-compose.$INSTANCE.yml -p wordsmith-$INSTANCE up -d

echo "Instance $INSTANCE déployée sur http://localhost:$PORT"
```

**Utilisation :**
```bash
chmod +x deploy-instance.sh
./deploy-instance.sh prod 80
./deploy-instance.sh dev 8080
./deploy-instance.sh staging 8081
```

## 🔍 Gestion des instances

### Lister toutes les instances

```bash
# Voir tous les projets Compose
docker compose ls

# Voir tous les conteneurs Wordsmith
docker ps --filter "name=wordsmith"
```

### Arrêter une instance spécifique

```bash
# Avec le nom du projet
docker compose -p wordsmith-dev down

# Ou depuis son dossier
cd instances/dev
docker compose down
```

### Voir les logs d'une instance

```bash
docker compose -p wordsmith-prod logs -f
```

### Arrêter toutes les instances

**PowerShell :**
```powershell
docker compose ls --format json | 
    ConvertFrom-Json | 
    Where-Object { $_.Name -like "wordsmith-*" } | 
    ForEach-Object { docker compose -p $_.Name down }
```

**Bash :**
```bash
docker compose ls --format json | 
    jq -r '.[] | select(.Name | startswith("wordsmith-")) | .Name' | 
    xargs -I {} docker compose -p {} down
```

## 💡 Isoler les réseaux et volumes

### Problème

Par défaut, toutes les instances partagent le même projet → conflits !

### Solution : Noms uniques

```yaml
# docker-compose.override.example.yml
version: '3.8'

services:
  db:
    container_name: null  # Laisse Docker générer un nom
  words:
    container_name: null
  web:
    container_name: null
    ports:
      - "8080:80"
```

Docker génère automatiquement des noms avec le project name :
- `wordsmith-prod-db-1`
- `wordsmith-dev-db-1`
- `wordsmith-staging-db-1`

## ✅ Checklist

- [ ] Plusieurs instances peuvent démarrer en même temps
- [ ] Chaque instance utilise un port différent
- [ ] Les conteneurs ont des noms uniques
- [ ] Les réseaux sont isolés
- [ ] Les volumes sont séparés
- [ ] On peut arrêter une instance sans affecter les autres

## 🔗 Prochaine étape

→ Aller dans `k8s/ETAPE_7.md` pour déployer sur Kubernetes

