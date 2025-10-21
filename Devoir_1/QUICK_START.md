# 🚀 Guide de démarrage rapide Wordsmith

## Qu'est-ce que Wordsmith ?

Wordsmith est une application de démonstration multi-conteneurs qui génère des phrases aléatoires amusantes en combinant des mots tirés d'une base de données PostgreSQL.

**Exemple de sortie :** *"A pink whale smashes the nordic fjørd"* 🐋

## Architecture

```
┌─────────────────┐
│   Navigateur    │
└────────┬────────┘
         │ http://localhost
         ▼
┌─────────────────┐
│   web (Go)      │  Frontend - Port 80
│   Serveur web   │
└────────┬────────┘
         │ http://words:8080
         ▼
┌─────────────────┐
│  words (Java)   │  API REST - Port 8080
│   API REST      │
└────────┬────────┘
         │ postgresql://db:5432
         ▼
┌─────────────────┐
│  db (PostgreSQL)│  Database - Port 5432
│  Base de données│
└─────────────────┘
```

## 🎯 Option 1 : Démarrage avec Docker Compose (Recommandé)

### Prérequis
- Docker Desktop installé
- Docker Compose installé

### Étapes

```bash
# 1. Naviguer dans le répertoire du projet
cd Devoir/wordsmith

# 2. Construire et lancer l'application
docker compose up -d

# 3. Vérifier que tout fonctionne
docker compose ps

# 4. Ouvrir dans votre navigateur
# http://localhost

# 5. Voir les logs (optionnel)
docker compose logs -f

# 6. Arrêter l'application
docker compose down

# 7. Arrêter et supprimer les volumes
docker compose down -v
```

### Mode développement

Pour modifier les fichiers HTML/CSS/JS sans reconstruire :

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d
```

Maintenant, modifiez les fichiers dans `web/static/` et rafraîchissez votre navigateur !

## 🎯 Option 2 : Construire les images manuellement

```bash
# Construire chaque image
docker build -t wordsmith-db ./db
docker build -t wordsmith-words ./words
docker build -t wordsmith-web ./web

# Créer un réseau
docker network create wordsmith-network

# Lancer la base de données
docker run -d \
  --name wordsmith-db \
  --network wordsmith-network \
  -e POSTGRES_HOST_AUTH_METHOD=trust \
  wordsmith-db

# Attendre que la DB soit prête (environ 10 secondes)
sleep 10

# Lancer l'API
docker run -d \
  --name wordsmith-words \
  --network wordsmith-network \
  wordsmith-words

# Lancer le frontend
docker run -d \
  --name wordsmith-web \
  --network wordsmith-network \
  -p 80:80 \
  wordsmith-web

# Ouvrir http://localhost
```

## 🎯 Option 3 : Déploiement sur Kubernetes

### Avec minikube

```bash
# Démarrer minikube
minikube start

# Déployer l'application
kubectl apply -f k8s/all-in-one.yaml

# Vérifier le déploiement
kubectl get pods

# Exposer le service
minikube service web

# Ou utiliser le tunnel
minikube tunnel
# Dans un autre terminal :
kubectl get service web
# Accéder à l'IP externe affichée
```

### Avec un cluster existant

```bash
# Déployer
kubectl apply -f k8s/all-in-one.yaml

# Obtenir l'URL du service
kubectl get service web

# Si LoadBalancer, attendre l'IP externe
kubectl get service web --watch
```

## 🧪 Tester l'application

### Via le navigateur
Ouvrir http://localhost et cliquer sur "Go!" pour générer des phrases amusantes.

### Via curl

```bash
# Page principale
curl http://localhost

# API - Obtenir un nom
curl http://localhost/words/noun

# API - Obtenir un verbe
curl http://localhost/words/verb

# API - Obtenir un adjectif
curl http://localhost/words/adjective
```

## 📊 Vérifier l'état de l'application

### Docker Compose

```bash
# Voir les conteneurs en cours
docker compose ps

# Voir les logs
docker compose logs web
docker compose logs words
docker compose logs db

# Inspecter un conteneur
docker compose exec web sh
docker compose exec words sh
docker compose exec db psql -U postgres
```

### Kubernetes

```bash
# Voir les pods
kubectl get pods -l app=wordsmith

# Voir les services
kubectl get services -l app=wordsmith

# Voir les logs
kubectl logs -l component=frontend
kubectl logs -l component=api
kubectl logs -l component=database
```

## 🐛 Dépannage

### L'application ne démarre pas

```bash
# Vérifier les logs
docker compose logs

# Reconstruire les images
docker compose build --no-cache

# Nettoyer et redémarrer
docker compose down -v
docker compose up -d --build
```

### Le service web ne répond pas

```bash
# Vérifier que tous les conteneurs sont en cours
docker compose ps

# Vérifier les logs du service web
docker compose logs web

# Tester la connectivité interne
docker compose exec web wget -O- http://words:8080/noun
```

### La base de données ne se connecte pas

```bash
# Vérifier que la DB est prête
docker compose exec db pg_isready -U postgres

# Vérifier les données
docker compose exec db psql -U postgres -c "SELECT * FROM nouns LIMIT 5;"

# Recréer la base de données
docker compose down -v
docker compose up -d
```

## 🚀 Déployer plusieurs instances

```bash
# Instance 1 (port 8080)
docker compose -p wordsmith-prod up -d

# Instance 2 (port 8081)
docker compose -f docker-compose.yml -f docker-compose.instance2.yml -p wordsmith-dev up -d

# Voir toutes les instances
docker compose ls
```

Consultez [DEPLOYMENT.md](DEPLOYMENT.md) pour plus de détails.

## 📦 Vérifier la taille des images

```bash
# Lister les images et leur taille
docker images | grep wordsmith

# Résultats attendus :
# wordsmith-web    : ~10-15 MB (excellent)
# wordsmith-words  : ~50-70 MB (excellent)
# wordsmith-db     : ~200-250 MB (bon)
```

## 🧹 Nettoyage

### Docker Compose

```bash
# Arrêter et supprimer les conteneurs
docker compose down

# Supprimer aussi les volumes
docker compose down -v

# Supprimer les images
docker rmi wordsmith-web wordsmith-words wordsmith-db
```

### Kubernetes

```bash
# Supprimer toutes les ressources
kubectl delete -f k8s/all-in-one.yaml

# Ou tout le namespace
kubectl delete namespace wordsmith
```

### Tout nettoyer (Docker)

```bash
# Nettoyer tous les conteneurs, images et volumes Wordsmith
docker compose down -v
docker rmi wordsmith-web wordsmith-words wordsmith-db
docker volume prune -f
docker network prune -f
```

## 📚 Documentation complète

- [README.fr.md](README.fr.md) - Instructions détaillées des exercices (français)
- [README.en.md](README.en.md) - Detailed exercise instructions (English)
- [DEPLOYMENT.md](DEPLOYMENT.md) - Guide de déploiement avancé
- [k8s/README.md](k8s/README.md) - Documentation Kubernetes

## 🎓 Exercices réalisés

- ✅ Exercice 1 : Dockerfiles pour les 3 services
- ✅ Exercice 2 : Optimisation de la taille des images (multi-stage builds)
- ✅ Exercice 3 : Optimisation du temps de build
- ✅ Exercice 4 : Fichier docker-compose.yml
- ✅ Exercice 5 : Configuration pour développement itératif
- ✅ Exercice 6 : Déploiement de plusieurs stacks
- ✅ Exercice 7 : Manifests Kubernetes

## ⚡ Commandes utiles

```bash
# Reconstruire une seule image
docker compose build web

# Reconstruire tout sans cache
docker compose build --no-cache

# Scaler un service (Compose v2)
docker compose up -d --scale words=3

# Voir l'utilisation des ressources
docker stats

# Inspecter le réseau
docker network inspect wordsmith_wordsmith-network

# Sauvegarder une image
docker save wordsmith-web > wordsmith-web.tar

# Charger une image
docker load < wordsmith-web.tar
```

## 🌟 Bonnes pratiques appliquées

1. **Multi-stage builds** : Séparer compilation et exécution
2. **Images Alpine** : Images légères pour la production
3. **Health checks** : Vérification de l'état des conteneurs
4. **Layer caching** : Optimisation du temps de build
5. **Network isolation** : Seul le frontend est exposé
6. **Volume persistence** : Données de la DB persistées
7. **Secrets management** : Variables d'environnement
8. **Resource limits** : Limites de CPU et mémoire (Kubernetes)

Bon développement ! 🎉


