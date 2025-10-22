# 📚 Projet Wordsmith - CI/CD avec GitHub Actions et Docker Hub

## 🎯 Objectifs du TP

Ce projet vous apprend à :
1. ✅ Créer des Dockerfiles optimisés
2. ✅ Utiliser Docker Compose
3. ✅ Configurer un workflow CI/CD avec GitHub Actions
4. ✅ Publier des images sur Docker Hub
5. ✅ Utiliser des images depuis un registry

---

## 📁 Structure du projet

```
Devoir_2/
│
├── 📄 README_TP.md              ← VOUS ÊTES ICI (Guide principal)
├── 📄 CONFIGURATION_GITHUB.md   ← Guide de configuration GitHub
├── 📄 TEST_SOLUTION.md          ← Guide de test final
├── 📄 GUIDE_UTILISATION.md      ← Commandes Docker
│
├── 🐳 Dockerfiles (3)
│   ├── db/Dockerfile            ← PostgreSQL (annoté)
│   ├── words/Dockerfile         ← API Java (multi-stage build)
│   └── web/Dockerfile           ← Frontend Go (multi-stage build)
│
├── 🎼 Docker Compose (3)
│   ├── docker-compose.yml       ← Build local (annoté)
│   ├── docker-compose.dev.yml   ← Mode développement
│   └── docker-compose.hub.yml   ← Images Docker Hub
│
├── ⚙️ GitHub Actions
│   └── .github/workflows/
│       └── build-wordsmith.yml  ← Workflow CI/CD
│
└── 🚫 .dockerignore             ← Optimisation build

```

---

## 🗺️ Parcours du TP

### Phase 1 : Préparation locale (FAIT ✅)

- ✅ Dockerfiles créés et annotés
- ✅ docker-compose.yml configuré
- ✅ .dockerignore créé

### Phase 2 : Configuration GitHub (À FAIRE)

**📖 Lire : `CONFIGURATION_GITHUB.md`**

1. Créer un compte Docker Hub
2. Générer un token d'accès
3. Ajouter les secrets GitHub :
   - `DOCKER_USERNAME`
   - `DOCKER_PASSWORD`
4. Vérifier que le workflow est bien dans `.github/workflows/`

### Phase 3 : Test et validation (À FAIRE)

**📖 Lire : `TEST_SOLUTION.md`**

1. Pousser le code sur GitHub
2. Le workflow GitHub Actions se lance
3. Les images sont publiées sur Docker Hub
4. Tester avec `docker-compose.hub.yml`
5. Valider que tout fonctionne

---

## 🎓 Compétences développées

### Docker (Exercices 1-3)
- ✅ Écriture de Dockerfiles
- ✅ Multi-stage builds
- ✅ Optimisation (Alpine, .dockerignore)
- ✅ Réduction de 90% de la taille des images

### Docker Compose (Exercice 4-5)
- ✅ Orchestration multi-conteneurs
- ✅ Réseaux Docker
- ✅ Volumes persistants
- ✅ Mode développement

### CI/CD (Nouveau !)
- ✅ GitHub Actions
- ✅ Workflows automatisés
- ✅ Secrets management
- ✅ Docker Hub registry
- ✅ Multi-tags
- ✅ Build parallèle

---

## 📊 Résultats attendus

### Tailles d'images optimisées

| Image | Sans optimisation | Avec optimisation | Gain |
|-------|-------------------|-------------------|------|
| web | ~300 MB | ~12 MB | 96% 🏆 |
| words | ~400 MB | ~62 MB | 85% 🏆 |
| db | ~230 MB | ~231 MB | - ✅ |

### Tags Docker Hub

Chaque image aura 3 tags :
- `latest` - Dernière version
- `<git-sha>` - Traçabilité du commit
- `v1.0` - Version sémantique

---

## 🔧 Commandes essentielles

### Développement local

```bash
# Construire et tester localement
docker compose build
docker compose up -d
```

### Avec Docker Hub

```bash
# Utiliser les images publiées
docker compose -f docker-compose.hub.yml up -d
```

### CI/CD

```bash
# Déclencher le workflow
git add .
git commit -m "Update Dockerfiles"
git push origin main
# → GitHub Actions se lance automatiquement !
```

---

## 📚 Fichiers de documentation

| Fichier | Contenu |
|---------|---------|
| `README_TP.md` | Vue d'ensemble du TP (ce fichier) |
| `CONFIGURATION_GITHUB.md` | Configuration GitHub + Docker Hub |
| `TEST_SOLUTION.md` | Tests et validation |
| `GUIDE_UTILISATION.md` | Commandes Docker de base |

---

## ✅ Checklist complète du TP

### Partie locale
- [ ] 3 Dockerfiles créés et annotés
- [ ] docker-compose.yml créé
- [ ] .dockerignore créé
- [ ] Images construisent sans erreur
- [ ] Tailles optimisées
- [ ] Application fonctionne localement

### Partie GitHub
- [ ] Repository créé sur GitHub
- [ ] Code poussé sur GitHub
- [ ] Workflow GitHub Actions créé
- [ ] Secrets configurés (DOCKER_USERNAME, DOCKER_PASSWORD)

### Partie Docker Hub
- [ ] Compte Docker Hub créé
- [ ] Token généré
- [ ] Workflow exécuté avec succès
- [ ] 3 images publiées sur Docker Hub
- [ ] Chaque image a 3 tags

### Test final
- [ ] docker-compose.hub.yml modifié avec votre username
- [ ] Application lancée avec les images Docker Hub
- [ ] Interface web accessible
- [ ] Phrases aléatoires s'affichent
- [ ] **TP VALIDÉ !** 🎉

---

## 🎉 Félicitations !

Vous avez complété un projet DevOps complet avec :
- 🐳 Docker
- 🎼 Docker Compose
- 🔄 CI/CD (GitHub Actions)
- 📦 Registry (Docker Hub)

**Vous êtes prêt pour le monde professionnel ! 🚀**

