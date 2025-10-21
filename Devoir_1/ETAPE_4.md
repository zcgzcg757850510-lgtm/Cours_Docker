# 📁 ÉTAPE 4 : Docker Compose (Orchestration)

## 🎯 Objectif
Orchestrer les 3 services (db, words, web) pour qu'ils fonctionnent ensemble.

## 📋 Fichier principal

### `docker-compose.yml` ⭐
**Rôle :** Fichier de configuration pour démarrer toute l'application
**Ce qu'il définit :**
- 3 services (db, words, web)
- 1 réseau (wordsmith-network)
- 1 volume (db-data)
- Dépendances et ordre de démarrage

## 🚀 Commandes Docker Compose

### Démarrer l'application
```bash
# Construction + démarrage en arrière-plan
docker compose up -d

# -d = detached mode (arrière-plan)
# Sans -d, les logs s'affichent dans le terminal
```

### Voir l'état
```bash
# Liste des conteneurs
docker compose ps

# Logs de tous les services
docker compose logs

# Logs d'un service spécifique
docker compose logs web
docker compose logs -f words  # -f = suivi en temps réel
```

### Arrêter l'application
```bash
# Arrêt simple
docker compose stop

# Arrêt + suppression des conteneurs
docker compose down

# Arrêt + suppression des conteneurs + volumes
docker compose down -v
```

### Reconstruire les images
```bash
# Reconstruire toutes les images
docker compose build

# Reconstruire une image spécifique
docker compose build words

# Reconstruire sans utiliser le cache
docker compose build --no-cache
```

## 💡 Concepts clés pour débutants

### Qu'est-ce que Docker Compose ?

**Sans Docker Compose :**
```bash
# Il faut lancer 3 commandes séparées :
docker run --name db ...
docker run --name words --link db ...
docker run --name web --link words ...
```

**Avec Docker Compose :**
```bash
# Une seule commande :
docker compose up
```

### Services vs Conteneurs

- **Service :** Définition dans docker-compose.yml (ex: "db", "words", "web")
- **Conteneur :** Instance en cours d'exécution d'un service

Un service peut avoir plusieurs conteneurs (scaling) :
```bash
docker compose up --scale words=3
# → Crée 3 conteneurs du service "words"
```

### Réseaux Docker

```
┌───────────────────────────────────────────┐
│      Réseau: wordsmith-network            │
│   (Isolé du réseau de votre PC)           │
├───────────────────────────────────────────┤
│                                           │
│  ┌──────┐     ┌────────┐     ┌────────┐  │
│  │  db  │ ←── │ words  │ ←── │  web   │  │
│  │:5432 │     │ :8080  │     │  :80   │  │
│  └──────┘     └────────┘     └───┬────┘  │
│                                   │       │
└───────────────────────────────────┼───────┘
                                    │
                         Port mappé │:80
                                    ▼
                            Votre navigateur
                         http://localhost:80
```

**Communication entre services :**
- `words` peut contacter `db` via `postgresql://db:5432`
- `web` peut contacter `words` via `http://words:8080`
- Les noms de services deviennent des noms de domaine !

### Volumes Docker

**Problème sans volume :**
```
Conteneur db démarré → Données écrites
Conteneur db supprimé → ❌ Données perdues !
```

**Solution avec volume :**
```
Conteneur db démarré → Données écrites dans volume
Conteneur db supprimé → ✅ Données toujours dans volume
Nouveau conteneur db → ✅ Récupère les données
```

Le volume `db-data` assure que les mots de la base de données ne sont pas perdus !

## 📊 Ordre de démarrage

```
1. Réseau créé : wordsmith-network
2. Volume créé : db-data
3. Service db démarre
   ├─ Health check : pg_isready
   └─ État : healthy ✅
4. Service words démarre (dépend de db)
   └─ Connexion à db:5432
5. Service web démarre (dépend de words)
   ├─ Connexion à words:8080
   └─ Écoute sur :80
6. Application prête ! 🎉
```

## 🔍 Commandes de debug

```bash
# Inspecter un service
docker compose exec web sh
# → Ouvre un shell dans le conteneur "web"

# Vérifier les logs
docker compose logs --tail=50 words
# → Affiche les 50 dernières lignes de logs

# Inspecter le réseau
docker network inspect wordsmith_wordsmith-network

# Inspecter le volume
docker volume inspect wordsmith_db-data

# Redémarrer un service
docker compose restart words
```

## ✅ Checklist

- [ ] Le fichier `docker-compose.yml` existe
- [ ] Les 3 services sont définis (db, words, web)
- [ ] Le réseau est configuré
- [ ] Le volume est configuré
- [ ] Les dépendances sont correctes (db ← words ← web)
- [ ] Le port 80 est mappé
- [ ] `docker compose up` fonctionne
- [ ] L'application est accessible sur http://localhost

## 🧪 Tester l'application

```bash
# Démarrer
docker compose up -d

# Attendre 20 secondes (Java démarre lentement)
sleep 20

# Vérifier les conteneurs
docker compose ps
# → Tous devraient être "Up"

# Tester l'API
curl http://localhost/words/noun
# → {"word":"cloud"}

# Ouvrir dans le navigateur
# http://localhost
# → L'interface web s'affiche

# Arrêter
docker compose down
```

## 🔗 Prochaine étape

→ Voir `docker-compose.dev.yml` pour l'étape 5 (Mode développement)

