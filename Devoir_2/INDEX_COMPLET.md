# 📚 INDEX COMPLET - Projet Wordsmith CI/CD

## 🗺️ Guide de navigation

Tous les fichiers du projet, organisés par thème.

---

## 🎯 VOUS ÊTES PERDU ? Commencez ici !

| Situation | Fichier à ouvrir |
|-----------|-----------------|
| 🆕 **Je découvre le projet** | `COMMENCER_ICI.md` |
| ⚙️ **Je veux configurer le CI/CD** | `COMMENCER_ETAPE_2.md` |
| 🚀 **Je veux juste tester localement** | `GUIDE_UTILISATION.md` |
| 📋 **Je veux les commandes** | `COMMANDES_ETAPE_2.md` |

---

## 📁 FICHIERS PAR CATÉGORIE

### 🎯 **Démarrage / Guides principaux**

| Fichier | Description | Priorité |
|---------|-------------|----------|
| `COMMENCER_ICI.md` | 🌟 Point d'entrée principal du projet | ⭐⭐⭐ |
| `COMMENCER_ETAPE_2.md` | 🌟 Point d'entrée pour l'étape 2 (CI/CD) | ⭐⭐⭐ |
| `README_TP.md` | Vue d'ensemble complète du TP | ⭐⭐ |
| `INDEX_COMPLET.md` | Ce fichier (navigation) | ⭐ |

---

### 📖 **Guides détaillés**

| Fichier | Contenu | Quand l'utiliser |
|---------|---------|------------------|
| `GUIDE_ETAPE_2_CICD.md` | Guide complet en 10 étapes pour CI/CD | Configuration GitHub + Docker Hub |
| `CONFIGURATION_GITHUB.md` | Guide de configuration GitHub Actions | Alternative au guide ci-dessus |
| `TEST_SOLUTION.md` | Guide pour tester avec images Docker Hub | Après que les images soient publiées |
| `GUIDE_UTILISATION.md` | Commandes Docker de base | Test local |
| `SYNTHESE_COMPLETE.md` | Synthèse de tout le projet | Vue d'ensemble |

---

### 📋 **Références rapides**

| Fichier | Contenu | Usage |
|---------|---------|-------|
| `ETAPE_2_RESUME.md` | Résumé rapide + checklist | Aide-mémoire |
| `COMMANDES_ETAPE_2.md` | 📋 Tous les tableaux de commandes | Référence à garder ouvert |

---

### 🤖 **Scripts automatiques**

| Fichier | Description | Commande |
|---------|-------------|----------|
| `setup-cicd.ps1` | Script PowerShell d'aide à la configuration | `.\setup-cicd.ps1` |

---

### 🐳 **Fichiers Docker**

#### **Dockerfiles (images)**

| Fichier | Service | Technologie | Taille |
|---------|---------|-------------|--------|
| `db/Dockerfile` | Base de données | PostgreSQL Alpine | ~231 MB |
| `words/Dockerfile` | API REST | Java (multi-stage) | ~62 MB |
| `web/Dockerfile` | Frontend | Go (multi-stage) | ~12 MB |

#### **Docker Compose (orchestration)**

| Fichier | Usage | Commande |
|---------|-------|----------|
| `docker-compose.yml` | 🏠 Build local (développement) | `docker compose up -d` |
| `docker-compose.dev.yml` | 🔧 Mode développement (hot reload) | `docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d` |
| `docker-compose.hub.yml` | 🌍 Images Docker Hub (production) | `docker compose -f docker-compose.hub.yml up -d` |

#### **Autres fichiers Docker**

| Fichier | Description |
|---------|-------------|
| `.dockerignore` | Fichiers à exclure du build Docker |

---

### ⚙️ **GitHub Actions (CI/CD)**

| Fichier | Description |
|---------|-------------|
| `.github/workflows/build-wordsmith.yml` | Workflow CI/CD automatique |

**Ce que fait ce workflow :**
- Se déclenche lors d'un `git push`
- Build les 3 images en parallèle
- Publie sur Docker Hub avec 3 tags

---

### 📊 **Code source**

#### **Base de données**

| Fichier | Description |
|---------|-------------|
| `db/words.sql` | Script SQL avec les mots (noms, verbes, adjectifs) |

#### **API REST Java**

| Fichier | Description |
|---------|-------------|
| `words/pom.xml` | Configuration Maven (dépendances Java) |
| `words/src/main/java/Main.java` | Code Java de l'API REST |

#### **Frontend Go**

| Fichier | Description |
|---------|-------------|
| `web/dispatcher.go` | Serveur web Go |
| `web/static/index.html` | Page HTML principale |
| `web/static/app.js` | JavaScript AngularJS |
| `web/static/style.css` | Styles CSS |
| `web/static/images/` | Images et logos |
| `web/static/fonts/` | Polices de caractères |

---

### 📚 **Documentation originale**

| Fichier | Description |
|---------|-------------|
| `README.md` | README minimal (pointe vers README.fr.md) |
| `README.fr.md` | README en français (version originale) |
| `README.en.md` | README en anglais |
| `LICENSE` | Licence Apache 2.0 |

---

## 🎯 **Parcours recommandés**

### **Parcours 1 : Test local uniquement**

```
1. COMMENCER_ICI.md (lire)
   ↓
2. GUIDE_UTILISATION.md (suivre)
   ↓
3. docker compose up -d
   ↓
4. http://localhost
   ↓
5. ✅ Terminé !
```

**Fichiers utilisés :** 2  
**Temps :** 15 minutes

---

### **Parcours 2 : CI/CD complet (recommandé)**

```
1. COMMENCER_ETAPE_2.md (lire)
   ↓
2. .\setup-cicd.ps1 (exécuter)
   ↓
3. GUIDE_ETAPE_2_CICD.md (suivre les 10 étapes)
   ↓
4. git push
   ↓
5. Vérifier GitHub Actions
   ↓
6. docker compose -f docker-compose.hub.yml up -d
   ↓
7. ✅ Terminé !
```

**Fichiers utilisés :** 3-4  
**Temps :** 30 minutes

---

### **Parcours 3 : Rapide (j'ai déjà de l'expérience)**

```
1. ETAPE_2_RESUME.md (checklist)
   ↓
2. COMMANDES_ETAPE_2.md (référence)
   ↓
3. Exécuter les commandes
   ↓
4. ✅ Terminé !
```

**Fichiers utilisés :** 2  
**Temps :** 20 minutes

---

## 📊 **Statistiques du projet**

### **Fichiers créés pour vous aider**

| Catégorie | Nombre de fichiers |
|-----------|-------------------|
| 📖 Guides détaillés | 5 |
| 📋 Résumés/Références | 2 |
| 🎯 Points d'entrée | 2 |
| 🤖 Scripts automatiques | 1 |
| **TOTAL documentation** | **10 fichiers** |

### **Fichiers techniques**

| Catégorie | Nombre de fichiers |
|-----------|-------------------|
| 🐳 Dockerfiles | 3 |
| 🎼 Docker Compose | 3 |
| ⚙️ GitHub Actions | 1 |
| 💻 Code source | ~15 |

---

## 🗂️ **Organisation des dossiers**

```
Devoir_2/
│
├── 📄 Documentation (nouveaux guides)
│   ├── COMMENCER_ICI.md
│   ├── COMMENCER_ETAPE_2.md
│   ├── INDEX_COMPLET.md
│   ├── GUIDE_ETAPE_2_CICD.md
│   ├── ETAPE_2_RESUME.md
│   ├── COMMANDES_ETAPE_2.md
│   ├── README_TP.md
│   ├── CONFIGURATION_GITHUB.md
│   ├── TEST_SOLUTION.md
│   ├── GUIDE_UTILISATION.md
│   └── SYNTHESE_COMPLETE.md
│
├── 🤖 Scripts
│   └── setup-cicd.ps1
│
├── 🐳 Docker
│   ├── docker-compose.yml
│   ├── docker-compose.dev.yml
│   ├── docker-compose.hub.yml
│   └── .dockerignore
│
├── 📂 db/ (Base de données)
│   ├── Dockerfile
│   └── words.sql
│
├── 📂 words/ (API Java)
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/main/java/Main.java
│
├── 📂 web/ (Frontend Go)
│   ├── Dockerfile
│   ├── dispatcher.go
│   └── static/ (HTML, CSS, JS, images)
│
└── 📂 .github/workflows/ (CI/CD)
    └── build-wordsmith.yml
```

---

## 🎓 **Concepts expliqués dans ce projet**

| Concept | Où l'apprendre | Niveau |
|---------|----------------|--------|
| Docker basics | `GUIDE_UTILISATION.md` | Débutant |
| Multi-stage builds | Dockerfiles (commentés) | Intermédiaire |
| Docker Compose | `docker-compose.yml` (commenté) | Intermédiaire |
| CI/CD | `GUIDE_ETAPE_2_CICD.md` | Intermédiaire |
| GitHub Actions | `.github/workflows/build-wordsmith.yml` | Intermédiaire |
| Docker Hub | `TEST_SOLUTION.md` | Débutant |
| Secrets management | `CONFIGURATION_GITHUB.md` | Intermédiaire |

---

## ⚡ **Commandes les plus importantes**

| Action | Commande |
|--------|----------|
| 🚀 Lancer le script d'aide | `.\setup-cicd.ps1` |
| 🏠 Tester localement | `docker compose up -d` |
| 🌍 Tester avec Docker Hub | `docker compose -f docker-compose.hub.yml up -d` |
| 🛑 Arrêter | `docker compose down` |
| 📤 Pousser vers GitHub | `git add . && git commit -m "msg" && git push` |

---

## 🎯 **Objectifs d'apprentissage**

À la fin de ce projet, vous saurez :

- ✅ Créer des **Dockerfiles optimisés** (réduction de 90%)
- ✅ Utiliser **multi-stage builds**
- ✅ Orchestrer plusieurs services avec **Docker Compose**
- ✅ Mettre en place un **workflow CI/CD** avec GitHub Actions
- ✅ Publier des images sur **Docker Hub**
- ✅ Gérer des **secrets** de manière sécurisée
- ✅ Comprendre l'**architecture microservices**

---

## 🆘 **Aide rapide**

| Question | Réponse |
|----------|---------|
| Par où commencer ? | `COMMENCER_ICI.md` ou `COMMENCER_ETAPE_2.md` |
| Je veux juste tester localement | `docker compose up -d` |
| Je veux configurer CI/CD | `.\setup-cicd.ps1` |
| J'ai une erreur | `COMMANDES_ETAPE_2.md` → Section Dépannage |
| Je veux comprendre en détail | `GUIDE_ETAPE_2_CICD.md` |
| Je veux juste les commandes | `COMMANDES_ETAPE_2.md` |

---

## 🎉 **Bon courage !**

**Vous avez tout ce qu'il faut pour réussir ! 🚀**

Choisissez votre parcours et lancez-vous !

