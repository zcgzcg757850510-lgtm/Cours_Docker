# ⚙️ Configuration GitHub pour le workflow CI/CD

## 🎯 Objectif
Configurer GitHub Actions pour builder et publier automatiquement les images Docker sur Docker Hub.

---

## 📋 Étapes de configuration

### 1️⃣ Créer un compte Docker Hub (si pas déjà fait)

1. Aller sur https://hub.docker.com/
2. Cliquer sur "Sign Up"
3. Créer un compte gratuit
4. **Noter votre nom d'utilisateur** (exemple : `tudou123`)

---

### 2️⃣ Créer un token d'accès Docker Hub

1. Se connecter à Docker Hub
2. Cliquer sur votre avatar (en haut à droite)
3. Aller dans **Account Settings**
4. Aller dans **Security** → **Personal Access Tokens**
5. Cliquer sur **New Access Token**
6. Nom du token : `github-actions-wordsmith`
7. Permissions : **Read, Write, Delete**
8. Cliquer sur **Generate**
9. **⚠️ COPIER LE TOKEN** (il ne sera affiché qu'une fois !)

Exemple de token : `dckr_pat_abc123xyz789...`

---

### 3️⃣ Ajouter les secrets dans GitHub

1. Aller sur votre repository GitHub
2. Cliquer sur **Settings** (onglet du repository)
3. Dans le menu de gauche : **Secrets and variables** → **Actions**
4. Cliquer sur **New repository secret**

**Secret 1 :**
- Name : `DOCKER_USERNAME`
- Secret : Votre nom d'utilisateur Docker Hub (exemple : `tudou123`)
- Cliquer sur **Add secret**

**Secret 2 :**
- Name : `DOCKER_PASSWORD`
- Secret : Le token Docker Hub que vous avez copié
- Cliquer sur **Add secret**

✅ **Vous devriez maintenant voir 2 secrets :**
- DOCKER_USERNAME
- DOCKER_PASSWORD

---

### 4️⃣ Vérifier le workflow

Le fichier `.github/workflows/build-wordsmith.yml` est déjà créé !

**Ce qu'il fait :**
- ✅ Se déclenche lors d'un Pull Request avec label "build"
- ✅ Se déclenche lors d'un push sur main/master
- ✅ Construit les 3 images EN PARALLÈLE (db, words, web)
- ✅ Se connecte à Docker Hub avec vos secrets
- ✅ Pushe chaque image avec 3 tags :
  - `latest` (dernière version)
  - `SHA du commit` (traçabilité)
  - `v1.0` (version sémantique)

---

### 5️⃣ Tester le workflow

#### Option A : Via Pull Request

```bash
# 1. Créer une branche
git checkout -b test-workflow

# 2. Faire un commit
git add .
git commit -m "Test workflow"

# 3. Pusher
git push origin test-workflow

# 4. Créer une Pull Request sur GitHub

# 5. Ajouter le label "build" à la PR

# 6. Le workflow se lance automatiquement !
```

#### Option B : Via Push direct

```bash
# 1. Commit sur main
git add .
git commit -m "Add Dockerfiles and workflow"

# 2. Push
git push origin main

# 3. Le workflow se lance automatiquement !
```

---

### 6️⃣ Vérifier l'exécution du workflow

1. Aller sur GitHub → Onglet **Actions**
2. Vous verrez le workflow "Build Wordsmith Images" en cours
3. Cliquer dessus pour voir les détails
4. Voir les 3 jobs s'exécuter en parallèle :
   - `build-db`
   - `build-words`
   - `build-web`

**Temps d'exécution attendu :** 3-5 minutes

---

### 7️⃣ Vérifier les images sur Docker Hub

1. Aller sur https://hub.docker.com/
2. Aller dans **Repositories**
3. Vous devriez voir 3 nouvelles images :
   - `votre-username/wordsmith-db`
   - `votre-username/wordsmith-words`
   - `votre-username/wordsmith-web`

4. Cliquer sur une image pour voir les tags :
   - `latest`
   - `SHA du commit`
   - `v1.0`

---

## 🧪 Tester avec les images de Docker Hub

Une fois les images publiées :

```bash
# 1. Modifier docker-compose.hub.yml
# Remplacer "votre-username" par votre vrai username Docker Hub

# 2. Lancer l'application avec les images du Hub
docker compose -f docker-compose.hub.yml up -d

# 3. Vérifier que tout fonctionne
# Ouvrir : http://localhost

# 4. Les images sont téléchargées depuis Docker Hub !
# (comme quand vous faites "docker pull nginx")
```

---

## 📊 Schéma du workflow

```
┌─────────────────────────────────────────────────────────────┐
│  Développeur fait un commit                                 │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│  GitHub détecte le Push/PR                                  │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────────────────┐
│  GitHub Actions démarre le workflow                         │
│  ┌───────────┐  ┌────────────┐  ┌──────────┐              │
│  │ Build DB  │  │ Build Words│  │ Build Web│              │
│  │ (Job 1)   │  │  (Job 2)   │  │ (Job 3)  │              │
│  └─────┬─────┘  └──────┬─────┘  └────┬─────┘              │
│        │               │              │                     │
│        └───────────────┴──────────────┘                     │
│                        │                                    │
└────────────────────────┼────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  Images poussées vers Docker Hub                            │
│  - votre-username/wordsmith-db:latest,sha,v1.0             │
│  - votre-username/wordsmith-words:latest,sha,v1.0          │
│  - votre-username/wordsmith-web:latest,sha,v1.0            │
└─────────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  Tout le monde peut télécharger vos images !                │
│  docker pull votre-username/wordsmith-web:latest           │
└─────────────────────────────────────────────────────────────┘
```

---

## ✅ Checklist de configuration

- [ ] Compte Docker Hub créé
- [ ] Token Docker Hub généré
- [ ] Secret `DOCKER_USERNAME` ajouté dans GitHub
- [ ] Secret `DOCKER_PASSWORD` ajouté dans GitHub
- [ ] Workflow `.github/workflows/build-wordsmith.yml` présent
- [ ] Code committé et pushé sur GitHub
- [ ] Workflow déclenché et exécuté avec succès
- [ ] Images visibles sur Docker Hub
- [ ] `docker-compose.hub.yml` modifié avec votre username
- [ ] Application testée avec les images Docker Hub

---

## 🐛 Troubleshooting

### Workflow échoue avec "Error: Cannot perform an interactive login"

**Solution :** Vérifiez que les secrets sont bien configurés
- DOCKER_USERNAME doit être votre nom d'utilisateur (pas email)
- DOCKER_PASSWORD doit être le TOKEN (pas votre mot de passe)

### Images ne sont pas poussées

**Solution :** Vérifiez les permissions du token
- Le token doit avoir les permissions "Read, Write, Delete"

### Workflow ne se déclenche pas

**Solution :** 
- Pour PR : Ajoutez le label "build"
- Pour Push : Vérifiez que vous êtes sur main/master

---

## 🎉 Félicitations !

Une fois configuré, à chaque commit :
- ✅ Les images sont buildées automatiquement
- ✅ Les images sont testées
- ✅ Les images sont publiées sur Docker Hub
- ✅ Tout le monde peut les utiliser !

**C'est du vrai CI/CD professionnel ! 🚀**

