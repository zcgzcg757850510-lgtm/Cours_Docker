# 🚀 Guide d'utilisation Wordsmith - Devoir_2

## 📋 Fichiers créés dans ce dossier

### Essentiels (Exercices 1-4)
- ✅ `db/Dockerfile` - Image PostgreSQL
- ✅ `words/Dockerfile` - API Java (multi-stage build)
- ✅ `web/Dockerfile` - Frontend Go (multi-stage build)
- ✅ `docker-compose.yml` - Orchestration des 3 services
- ✅ `.dockerignore` - Optimisation du build

### Bonus (Exercice 5)
- ✅ `docker-compose.dev.yml` - Mode développement

---

## 🧪 Commandes pour tester

### Exercice 1 : Construction des images

```bash
# Aller dans le dossier
cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2

# Construire les 3 images séparément
docker build -t wordsmith-db ./db
docker build -t wordsmith-words ./words
docker build -t wordsmith-web ./web

# Ou tout construire avec Compose
docker compose build
```

### Exercice 2 : Vérifier l'optimisation

```bash
# Voir les tailles des images
docker images | findstr wordsmith

# Objectifs :
# wordsmith-web   : < 100 MB (attendu ~12 MB) ✅
# wordsmith-words : < 200 MB (attendu ~62 MB) ✅
# wordsmith-db    : < 300 MB (attendu ~231 MB) ✅
```

### Exercice 4 : Lancer l'application complète

```bash
# Démarrer tous les services
docker compose up -d

# Attendre 25 secondes (Java démarre lentement)
# Puis ouvrir : http://localhost

# Voir les logs
docker compose logs -f

# Arrêter
docker compose down
```

### Exercice 5 : Mode développement

```bash
# Démarrer en mode dev
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# Modifier web/static/index.html
# Rafraîchir le navigateur → Changements visibles immédiatement !
```

---

## 📊 Résumé

**Ce dossier contient tout ce qu'il faut pour les exercices 1-5 du projet Wordsmith !**

✅ Dockerfiles optimisés et annotés  
✅ Docker Compose configuré  
✅ Mode développement  
✅ Prêt à être poussé sur GitHub  
✅ Prêt pour le CI/CD  

**Prochaine étape : GitHub Actions + Docker Hub !** 🚀

