# 👋 Bienvenue dans Wordsmith !

**Projet d'apprentissage Docker & Kubernetes pour débutants**

---

## 🎯 Qu'est-ce que ce projet ?

Wordsmith est une application web qui génère des **phrases aléatoires amusantes** comme :

> *"A pink whale smashes the nordic fjørd"* 🐋

Mais plus important, c'est un **projet pédagogique** pour apprendre :
- ✅ Docker (images, conteneurs, volumes, réseaux)
- ✅ Docker Compose (orchestration)
- ✅ Kubernetes (production)
- ✅ Multi-stage builds (optimisation)
- ✅ Bonnes pratiques DevOps

---

## 📚 Par où commencer ?

### Option 1 : Je veux juste voir l'app fonctionner ! 🚀

```bash
# 1. Ouvrir PowerShell dans ce dossier
cd C:\Users\tudou\Desktop\Develop\Devoir\wordsmith

# 2. Lancer l'application
.\deploy.ps1 start

# 3. Attendre 25 secondes

# 4. Ouvrir dans le navigateur
# http://localhost

# 5. Cliquer sur "Go!" pour générer une phrase

# 6. Arrêter quand vous avez fini
.\deploy.ps1 stop
```

### Option 2 : Je veux apprendre étape par étape ! 📖

**COMMENCEZ ICI :** `INDEX.md`

Ce fichier contient :
- 🗺️ Le parcours d'apprentissage complet
- 📊 Les 7 étapes numérotées
- 💡 Explications des concepts
- 🛠️ Commandes essentielles
- ❓ Glossaire pour débutants

**Puis suivez les étapes dans l'ordre :**

1. **`db/ETAPE_1.md`** → Base de données PostgreSQL (15 min)
2. **`words/ETAPE_2.md`** → API REST Java (30 min)
3. **`web/ETAPE_3.md`** → Serveur Web Go (25 min)
4. **`ETAPE_4.md`** → Docker Compose (30 min)
5. **`ETAPE_5.md`** → Mode développement (15 min)
6. **`ETAPE_6.md`** → Multi-instances (20 min)
7. **`k8s/ETAPE_7.md`** → Kubernetes (45 min)

**Temps total estimé :** 3 heures

---

## 📁 Structure du projet

```
wordsmith/
│
├── 📄 BIENVENUE.md          ← VOUS ÊTES ICI !
├── 📄 INDEX.md              ← Guide complet (COMMENCEZ ICI)
├── 📄 QUICK_START.md        ← Démarrage rapide
│
├── 📁 db/                   ← ÉTAPE 1 : PostgreSQL
│   ├── Dockerfile           ← Annoté pour débutants
│   ├── ETAPE_1.md           ← Guide détaillé
│   └── words.sql            ← Données initiales
│
├── 📁 words/                ← ÉTAPE 2 : API Java
│   ├── Dockerfile           ← Annoté (multi-stage build)
│   ├── ETAPE_2.md           ← Guide détaillé
│   └── src/main/java/       ← Code source
│
├── 📁 web/                  ← ÉTAPE 3 : Frontend Go
│   ├── Dockerfile           ← Annoté (multi-stage build)
│   ├── ETAPE_3.md           ← Guide détaillé
│   ├── dispatcher.go        ← Code Go
│   └── static/              ← HTML, CSS, JS
│
├── 📄 docker-compose.yml    ← ÉTAPE 4 : Orchestration
├── 📄 ETAPE_4.md            ← Guide Docker Compose
│
├── 📄 docker-compose.dev.yml ← ÉTAPE 5 : Mode dev
├── 📄 ETAPE_5.md            ← Guide mode dev
│
├── 📄 ETAPE_6.md            ← ÉTAPE 6 : Multi-instances
│
└── 📁 k8s/                  ← ÉTAPE 7 : Kubernetes
    ├── ETAPE_7.md           ← Guide Kubernetes
    ├── all-in-one.yaml      ← Déploiement complet
    └── *.yaml               ← Manifests séparés
```

---

## 🎓 Vous êtes débutant ?

### Pas de panique ! Tout est expliqué ! 💚

1. **Tous les Dockerfiles sont annotés** ligne par ligne
2. **Chaque étape a son guide** (ETAPE_X.md)
3. **Les concepts sont expliqués** avec des schémas
4. **Des exemples de commandes** sont fournis
5. **Un glossaire** est disponible dans INDEX.md

### Prérequis minimum

- [ ] Docker Desktop installé sur Windows
- [ ] PowerShell disponible
- [ ] Un éditeur de texte (VS Code recommandé)
- [ ] Un navigateur web
- [ ] De la curiosité ! 😊

---

## 💡 Concepts clés que vous allez apprendre

### Docker

| Concept | Analogie | Exemple |
|---------|----------|---------|
| **Image** | Recette de cuisine | `wordsmith-web` |
| **Conteneur** | Plat cuisiné | Container en cours d'exécution |
| **Dockerfile** | Liste d'instructions | `FROM, COPY, RUN, CMD` |
| **Volume** | Tiroir de rangement | Les données persistent |
| **Network** | Téléphone interne | Les conteneurs se parlent |

### Architecture de Wordsmith

```
┌─────────────┐
│ Navigateur  │  ← Vous utilisez l'application
└──────┬──────┘
       │ http://localhost
       ▼
┌─────────────┐
│  web (Go)   │  ← Serveur web (port 80)
│  Frontend   │
└──────┬──────┘
       │ http://words:8080
       ▼
┌─────────────┐
│ words (Java)│  ← API REST (port 8080)
│     API     │
└──────┬──────┘
       │ postgresql://db:5432
       ▼
┌─────────────┐
│db (Postgres)│  ← Base de données (port 5432)
│  Database   │
└─────────────┘
```

---

## 🚀 Commandes rapides

### Démarrer l'application

```bash
# Méthode 1 : Script PowerShell (Windows)
.\deploy.ps1 start

# Méthode 2 : Docker Compose (tous OS)
docker compose up -d
```

### Voir les logs

```bash
# PowerShell
.\deploy.ps1 logs

# Docker Compose
docker compose logs -f
```

### Arrêter l'application

```bash
# PowerShell
.\deploy.ps1 stop

# Docker Compose
docker compose down
```

---

## ✅ Checklist de démarrage

Avant de commencer, vérifiez que :

- [ ] Docker Desktop est installé
- [ ] Docker Desktop est démarré (icône dans la barre des tâches)
- [ ] Vous êtes dans le dossier `wordsmith/`
- [ ] Le port 80 est libre (pas d'autre app web)
- [ ] Vous avez lu ce fichier 😊

**Tout est bon ? → Allez dans `INDEX.md` ! 🎉**

---

## ❓ Questions fréquentes

### Docker ne démarre pas
→ Redémarrez Docker Desktop

### Port 80 déjà utilisé
→ Modifiez `docker-compose.yml` : `ports: - "8080:80"`  
→ Accédez à http://localhost:8080

### L'application ne répond pas
→ Attendez 25 secondes (Java démarre lentement)  
→ Vérifiez les logs : `docker compose logs`

### Je suis perdu
→ Revenez à `INDEX.md`  
→ Suivez les étapes dans l'ordre

---

## 🎁 Bonus

### Ce projet vous apprend aussi :

- ✅ **Optimisation** : Réduire la taille des images de 90%
- ✅ **Performance** : Builds rapides avec layer caching
- ✅ **Sécurité** : Bonnes pratiques (non-root, .dockerignore)
- ✅ **Production** : Déploiement Kubernetes
- ✅ **DevOps** : Automatisation avec scripts

### À la fin, vous saurez :

- ✅ Créer des images Docker optimisées
- ✅ Utiliser multi-stage builds
- ✅ Orchestrer des services avec Compose
- ✅ Déployer sur Kubernetes
- ✅ Gérer des environnements multiples

---

## 🎯 Prêt à commencer ?

### Parcours recommandé :

1. **Lire** : `BIENVENUE.md` (vous êtes ici) ✅
2. **Suivant** : `INDEX.md` (vue d'ensemble)
3. **Ensuite** : `db/ETAPE_1.md` (première étape)
4. **Continue** : Suivez les 7 étapes
5. **Terminez** : Déployez sur Kubernetes !

---

## 📞 Ressources utiles

- **Documentation Docker** : https://docs.docker.com/
- **Documentation Kubernetes** : https://kubernetes.io/docs/
- **Docker Hub** : https://hub.docker.com/
- **VS Code** : https://code.visualstudio.com/

---

<div align="center">

## 🎉 Bon apprentissage !

**N'oubliez pas : Chaque expert a commencé en tant que débutant** 💪

Prenez votre temps, lisez les commentaires, et amusez-vous ! 🚀

---

[📖 Voir le guide complet →](INDEX.md) | [🚀 Démarrage rapide →](QUICK_START.md)

</div>

