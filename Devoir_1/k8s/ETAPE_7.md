# 📁 ÉTAPE 7 : Kubernetes (Orchestration Production)

## 🎯 Objectif
Déployer l'application Wordsmith sur Kubernetes pour la production.

## 📋 Fichiers dans ce dossier

### Manifests par service (6 fichiers)

#### Base de données
1. `db-deployment.yaml` - Déploie PostgreSQL
2. `db-service.yaml` - Expose PostgreSQL en interne (ClusterIP)

#### API REST
3. `words-deployment.yaml` - Déploie l'API Java (2 replicas)
4. `words-service.yaml` - Expose l'API en interne (ClusterIP)

#### Frontend Web
5. `web-deployment.yaml` - Déploie le serveur Go (2 replicas)
6. `web-service.yaml` - Expose le web vers l'extérieur (LoadBalancer)

### Fichiers spéciaux

7. `web-service-nodeport.yaml` - Alternative pour clusters locaux
8. `all-in-one.yaml` ⭐ - Tout en un seul fichier (démarrage rapide)

## 🔍 Docker Compose vs Kubernetes

### Docker Compose (Développement)
```yaml
services:
  db:
    image: wordsmith-db
    ports:
      - "5432:5432"
```

### Kubernetes (Production)
```yaml
# Deployment (comment lancer le conteneur)
apiVersion: apps/v1
kind: Deployment
...

# Service (comment y accéder)
apiVersion: v1
kind: Service
...
```

**Différence clé :** Kubernetes sépare "comment lancer" (Deployment) de "comment accéder" (Service)

## 🚀 Déploiement rapide

### Option 1 : Fichier all-in-one (Recommandé pour débuter)

```bash
# Déployer tout
kubectl apply -f k8s/all-in-one.yaml

# Vérifier
kubectl get all

# Voir les pods
kubectl get pods
# → db-xxx, words-xxx (x2), web-xxx (x2)

# Accéder au service (minikube)
minikube service web
```

### Option 2 : Fichiers séparés

```bash
# Base de données
kubectl apply -f k8s/db-deployment.yaml
kubectl apply -f k8s/db-service.yaml

# API REST
kubectl apply -f k8s/words-deployment.yaml
kubectl apply -f k8s/words-service.yaml

# Frontend
kubectl apply -f k8s/web-deployment.yaml
kubectl apply -f k8s/web-service.yaml
```

## 💡 Concepts Kubernetes pour débutants

### Pod
**C'est quoi ?** Le plus petit objet Kubernetes = 1 ou plusieurs conteneurs
```
Pod = Enveloppe autour d'un conteneur Docker
```

### Deployment
**C'est quoi ?** Gère un ensemble de pods identiques
```yaml
replicas: 2  # → Crée 2 pods identiques
```

**Avantage :** Si un pod crash, Kubernetes en recrée un automatiquement !

### Service
**C'est quoi ?** Point d'accès stable vers des pods

**Types de services :**
- **ClusterIP** : Accessible uniquement DANS le cluster
  - Exemple : db, words (services internes)
- **LoadBalancer** : Accessible depuis l'EXTÉRIEUR
  - Exemple : web (interface utilisateur)
- **NodePort** : Alternative pour clusters locaux

### Architecture Kubernetes Wordsmith

```
┌─────────────────────────────────────────────────┐
│          Cluster Kubernetes                      │
├─────────────────────────────────────────────────┤
│                                                  │
│  ┌────────────────────────────────────────────┐ │
│  │ Deployment: web (2 replicas)               │ │
│  │ ┌──────────┐  ┌──────────┐                │ │
│  │ │ Pod web  │  │ Pod web  │                │ │
│  │ │  :80     │  │  :80     │                │ │
│  │ └──────────┘  └──────────┘                │ │
│  └────────────┬───────────────────────────────┘ │
│               │ Service: web (LoadBalancer)     │
│               └───────────┬─────────────────────┤
│                          Port :80               │
└──────────────────────────┼─────────────────────┘
                          │
                    Internet / Utilisateur
```

## 🧪 Commandes de test

### Vérifier le déploiement

```bash
# Tous les objets
kubectl get all

# Seulement les pods
kubectl get pods

# Seulement les services
kubectl get services

# Seulement les deployments
kubectl get deployments

# Avec plus de détails
kubectl get pods -o wide
```

### Voir les logs

```bash
# Logs d'un pod spécifique
kubectl logs <nom-du-pod>

# Logs de tous les pods d'un deployment
kubectl logs -l app=wordsmith,component=api

# Suivre les logs en temps réel
kubectl logs -f <nom-du-pod>
```

### Débugger

```bash
# Décrire un pod (voir les événements)
kubectl describe pod <nom-du-pod>

# Décrire un service
kubectl describe service web

# Se connecter à un pod
kubectl exec -it <nom-du-pod> -- sh

# Tester depuis un pod temporaire
kubectl run debug --image=alpine --rm -it -- sh
# Dans le pod :
wget -O- http://words:8080/noun
```

### Scaling (ajuster le nombre de replicas)

```bash
# Augmenter le nombre de pods
kubectl scale deployment words --replicas=5

# Vérifier
kubectl get pods -l component=api
# → 5 pods words

# Réduire
kubectl scale deployment words --replicas=2
```

## 📊 Healthchecks (Probes)

Kubernetes utilise 2 types de probes :

### Liveness Probe
**Question :** "Le conteneur fonctionne-t-il ?"
**Si échec :** Redémarre le pod

```yaml
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 10
  periodSeconds: 10
```

### Readiness Probe
**Question :** "Le conteneur est-il prêt à recevoir du trafic ?"
**Si échec :** Retire le pod du Service (pas de trafic envoyé)

```yaml
readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 5
```

## 🔄 Rolling Updates

```bash
# Mettre à jour une image
kubectl set image deployment/web web=wordsmith-web:v2

# Voir le statut du rollout
kubectl rollout status deployment/web

# Annuler une mise à jour
kubectl rollout undo deployment/web

# Historique des rollouts
kubectl rollout history deployment/web
```

## 🌐 Accéder à l'application

### Sur minikube

```bash
# Option 1 : Service URL
minikube service web --url
# → http://192.168.49.2:30000 (exemple)

# Option 2 : Tunnel
minikube tunnel
# → http://localhost:80
```

### Sur un cloud (GCP, AWS, Azure)

```bash
# Obtenir l'IP externe du LoadBalancer
kubectl get service web

# Attendre que EXTERNAL-IP soit assignée
kubectl get service web --watch

# Accéder à l'application
curl http://<EXTERNAL-IP>
```

## ✅ Checklist

- [ ] Tous les fichiers YAML existent
- [ ] `kubectl apply` fonctionne sans erreur
- [ ] Tous les pods sont "Running"
- [ ] Tous les pods sont "Ready" (1/1 ou 2/2)
- [ ] Les services sont créés
- [ ] Le service web a une EXTERNAL-IP (ou NodePort)
- [ ] L'application est accessible depuis le navigateur
- [ ] Les logs ne montrent pas d'erreurs

## 🧹 Nettoyage

```bash
# Supprimer tout
kubectl delete -f k8s/all-in-one.yaml

# Ou supprimer par type
kubectl delete deployment db words web
kubectl delete service db words web

# Vérifier
kubectl get all
# → No resources found
```

## 📚 Comprendre les manifests

### Structure d'un manifest Kubernetes

```yaml
apiVersion: apps/v1        # Version de l'API K8s
kind: Deployment           # Type d'objet
metadata:                  # Métadonnées
  name: words
  labels:
    app: wordsmith
spec:                      # Spécification
  replicas: 2              # Nombre de pods
  selector:                # Comment trouver les pods
    matchLabels:
      component: api
  template:                # Modèle de pod
    metadata:
      labels:
        component: api
    spec:
      containers:          # Conteneurs dans le pod
      - name: words
        image: jpetazzo/wordsmith-words:latest
        ports:
        - containerPort: 8080
```

## 🔗 Ressources utiles

- Documentation officielle : https://kubernetes.io/docs/
- Minikube : https://minikube.sigs.k8s.io/
- kubectl cheat sheet : https://kubernetes.io/docs/reference/kubectl/cheatsheet/

---

**Félicitations ! Vous avez terminé tous les 7 exercices ! 🎉**

