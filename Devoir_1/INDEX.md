# 📚 INDEX - Guide Complet Wordsmith pour Débutants

Bienvenue ! Ce projet vous guide pas à pas dans l'apprentissage de Docker et Kubernetes.

## 🗺️ Parcours d'apprentissage

### 📁 ÉTAPE 1 : Base de données PostgreSQL
**Dossier :** `db/`  
**Fichiers :**
- `Dockerfile` - Image PostgreSQL annotée
- `ETAPE_1.md` - Guide détaillé
- `words.sql` - Données initiales

**Ce que vous apprenez :**
- ✅ Créer un Dockerfile simple
- ✅ Utiliser une image de base (postgres:alpine)
- ✅ Copier des fichiers dans une image
- ✅ Configurer des variables d'environnement

**Temps estimé :** 15 minutes  
**Niveau :** Débutant ⭐

---

### 📁 ÉTAPE 2 : API REST Java
**Dossier :** `words/`  
**Fichiers :**
- `Dockerfile` - Multi-stage build annoté
- `ETAPE_2.md` - Guide détaillé
- `src/main/java/Main.java` - Code Java
- `pom.xml` - Configuration Maven

**Ce que vous apprenez :**
- ✅ Multi-stage build (technique avancée!)
- ✅ Optimiser la taille des images (400 MB → 60 MB)
- ✅ Layer caching pour builds rapides
- ✅ Différence JDK vs JRE

**Temps estimé :** 30 minutes  
**Niveau :** Intermédiaire ⭐⭐

---

### 📁 ÉTAPE 3 : Serveur Web Go
**Dossier :** `web/`  
**Fichiers :**
- `Dockerfile` - Multi-stage build annoté
- `ETAPE_3.md` - Guide détaillé
- `dispatcher.go` - Code Go
- `static/` - Interface utilisateur

**Ce que vous apprenez :**
- ✅ Multi-stage build avec Go
- ✅ Créer des images ultra-légères (12 MB!)
- ✅ Binaires statiques vs runtime
- ✅ Servir des fichiers statiques

**Temps estimé :** 25 minutes  
**Niveau :** Intermédiaire ⭐⭐

---

### 📁 ÉTAPE 4 : Docker Compose (Orchestration)
**Fichier :** `docker-compose.yml`  
**Guide :** `ETAPE_4.md`

**Ce que vous apprenez :**
- ✅ Orchestrer plusieurs conteneurs
- ✅ Créer des réseaux Docker
- ✅ Gérer des volumes (persistance)
- ✅ Dépendances entre services
- ✅ Health checks

**Temps estimé :** 30 minutes  
**Niveau :** Intermédiaire ⭐⭐

---

### 📁 ÉTAPE 5 : Mode Développement
**Fichier :** `docker-compose.dev.yml`

**Ce que vous apprenez :**
- ✅ Monter des volumes pour le dev
- ✅ Hot reload (modifications sans rebuild)
- ✅ Fichiers override Compose

**Temps estimé :** 15 minutes  
**Niveau :** Débutant ⭐

---

### 📁 ÉTAPE 6 : Multi-instances
**Fichier :** `docker-compose.override.example.yml`

**Ce que vous apprenez :**
- ✅ Déployer plusieurs instances
- ✅ Isolation des applications
- ✅ Project names Docker Compose

**Temps estimé :** 20 minutes  
**Niveau :** Intermédiaire ⭐⭐

---

### 📁 ÉTAPE 7 : Kubernetes (Production)
**Dossier :** `k8s/`  
**Guide :** `k8s/ETAPE_7.md`  
**Fichiers :** 8 manifests YAML

**Ce que vous apprenez :**
- ✅ Deployments Kubernetes
- ✅ Services (ClusterIP, LoadBalancer)
- ✅ Scaling horizontal
- ✅ Rolling updates
- ✅ Health probes (liveness, readiness)
- ✅ Resource limits

**Temps estimé :** 45 minutes  
**Niveau :** Avancé ⭐⭐⭐

---

## 🚀 Démarrage Rapide

### Pour les impatients

```bash
# Tout démarrer
docker compose up -d

# Attendre 25 secondes
sleep 25

# Ouvrir dans le navigateur
# http://localhost

# Arrêter
docker compose down
```

### Pour les apprenants

1. **Commencez par lire** `db/ETAPE_1.md`
2. **Construisez** l'image : `docker build -t wordsmith-db ./db`
3. **Testez** : `docker run -d --name test-db wordsmith-db`
4. **Passez** à l'étape suivante : `words/ETAPE_2.md`
5. **Répétez** jusqu'à l'étape 7

## 📖 Glossaire pour débutants

### Docker

- **Image** : Modèle/Template pour créer des conteneurs
- **Conteneur** : Instance en cours d'exécution d'une image
- **Dockerfile** : Recette pour créer une image
- **Layer** : Couche d'une image (chaque instruction = 1 layer)
- **Cache** : Réutilisation de layers pour builds rapides
- **Volume** : Stockage persistant pour les données
- **Network** : Réseau privé pour que les conteneurs communiquent

### Docker Compose

- **Service** : Définition d'un conteneur dans docker-compose.yml
- **Stack** : Ensemble de services qui fonctionnent ensemble
- **Orchestration** : Coordination de plusieurs conteneurs

### Kubernetes

- **Pod** : Plus petit objet K8s (enveloppe autour de conteneurs)
- **Deployment** : Gère des pods identiques
- **Service** : Point d'accès stable vers des pods
- **Replica** : Copie identique d'un pod
- **Probe** : Vérification de santé d'un conteneur
- **Rolling Update** : Mise à jour sans interruption

## 🎯 Objectifs d'apprentissage

À la fin de ce projet, vous saurez :

### Niveau Docker
- ✅ Écrire des Dockerfiles optimisés
- ✅ Utiliser multi-stage builds
- ✅ Réduire la taille des images (90%+)
- ✅ Optimiser le temps de build (layer caching)
- ✅ Gérer des réseaux et volumes

### Niveau Docker Compose
- ✅ Orchestrer plusieurs services
- ✅ Configurer les dépendances
- ✅ Gérer environnements (dev/prod)
- ✅ Déployer plusieurs instances

### Niveau Kubernetes
- ✅ Créer des Deployments
- ✅ Exposer des Services
- ✅ Scaler horizontalement
- ✅ Faire des rolling updates
- ✅ Configurer health checks

## 📊 Résultats attendus

| Exercice | Image | Taille objectif | Résultat attendu |
|----------|-------|-----------------|------------------|
| 1. db | postgres:alpine | < 300 MB | ~230 MB ✅ |
| 2. words | JRE + JAR | < 200 MB | ~60 MB 🏆 |
| 3. web | Alpine + binary | < 100 MB | ~12 MB 🏆 |

## 🛠️ Commandes essentielles

### Docker

```bash
# Construire une image
docker build -t nom-image ./dossier

# Lister les images
docker images

# Lancer un conteneur
docker run -d --name mon-conteneur nom-image

# Voir les conteneurs
docker ps

# Arrêter un conteneur
docker stop mon-conteneur

# Supprimer un conteneur
docker rm mon-conteneur

# Voir les logs
docker logs mon-conteneur
```

### Docker Compose

```bash
# Tout démarrer
docker compose up -d

# Voir l'état
docker compose ps

# Voir les logs
docker compose logs -f

# Arrêter
docker compose down

# Reconstruire
docker compose build
```

### Kubernetes

```bash
# Déployer
kubectl apply -f fichier.yaml

# Voir l'état
kubectl get all

# Voir les pods
kubectl get pods

# Voir les logs
kubectl logs nom-pod

# Scaler
kubectl scale deployment nom --replicas=3

# Supprimer
kubectl delete -f fichier.yaml
```

## 📝 Fichiers utiles

- **`QUICK_START.md`** : Guide de démarrage rapide
- **`deploy.ps1`** : Script PowerShell pour Windows
- **`.dockerignore`** : Fichiers à exclure des builds
- **`README.fr.md`** : Instructions originales des exercices

## 🎓 Conseils pour apprendre

### 1. Allez dans l'ordre
Ne sautez pas d'étapes ! Chaque étape s'appuie sur la précédente.

### 2. Lisez les annotations
Les Dockerfiles sont très annotés. Lisez chaque commentaire !

### 3. Testez vous-même
Lancez chaque commande manuellement. Ne copiez pas aveuglément.

### 4. Cassez des choses
Essayez de modifier les fichiers pour voir ce qui se passe.

### 5. Utilisez les guides ETAPE_X.md
Chaque guide contient des explications détaillées.

## ❓ Besoin d'aide ?

### Problèmes communs

**Docker ne démarre pas :**
- Vérifiez que Docker Desktop est lancé
- Redémarrez Docker Desktop

**Port 80 déjà utilisé :**
- Modifiez `docker-compose.yml` : `ports: - "8080:80"`
- Accédez à http://localhost:8080

**L'application ne répond pas :**
- Attendez 25 secondes (Java est lent à démarrer)
- Vérifiez les logs : `docker compose logs`

**Les images sont trop grosses :**
- Vérifiez que vous utilisez bien les multi-stage builds
- Assurez-vous d'utiliser Alpine comme image de base

## 🎉 Félicitations !

Une fois toutes les étapes complétées, vous maîtriserez :
- Docker (images, conteneurs, volumes, réseaux)
- Docker Compose (orchestration multi-conteneurs)
- Kubernetes (déploiement production)

**Bon apprentissage ! 🚀**

