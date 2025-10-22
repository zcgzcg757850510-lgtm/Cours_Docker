# 🚀 GUIDE COMPLET - Étape 2 : Configuration CI/CD

## ✅ Ce qui est déjà fait

- ✅ Workflow GitHub Actions créé (`.github/workflows/build-wordsmith.yml`)
- ✅ Dockerfiles optimisés
- ✅ docker-compose.yml configuré

---

## 📋 Ce qu'il vous reste à faire (10 étapes)

### **ÉTAPE 1 : Créer un compte Docker Hub** ⏱️ 3 minutes

1. **Ouvrez votre navigateur**
2. **Allez sur** : https://hub.docker.com/
3. **Cliquez** sur "Sign Up" (ou "S'inscrire")
4. **Remplissez** le formulaire :
   - Username (nom d'utilisateur) : **NOTEZ-LE** ✏️ (exemple : `tudou123`)
   - Email
   - Mot de passe
5. **Vérifiez** votre email
6. **Connectez-vous** à Docker Hub

✅ **Résultat :** Vous avez un compte Docker Hub

---

### **ÉTAPE 2 : Générer un token d'accès Docker Hub** ⏱️ 2 minutes

Un token est comme un mot de passe spécial pour GitHub Actions.

1. **Connectez-vous** à Docker Hub
2. **Cliquez** sur votre avatar (en haut à droite)
3. **Allez** dans "Account Settings" (Paramètres du compte)
4. **Dans le menu de gauche**, cliquez sur "Security"
5. **Cliquez** sur "Personal Access Tokens"
6. **Cliquez** sur "New Access Token" (Nouveau token)
7. **Remplissez** :
   - Description : `github-actions-wordsmith`
   - Permissions : Cochez **"Read, Write, Delete"**
8. **Cliquez** sur "Generate" (Générer)
9. **⚠️ COPIEZ LE TOKEN IMMÉDIATEMENT** (il ne sera affiché qu'une fois !)

Le token ressemble à : `dckr_pat_abc123xyz789...`

✅ **Résultat :** Vous avez un token Docker Hub copié quelque part (Notepad, etc.)

---

### **ÉTAPE 3 : Vérifier votre repository GitHub** ⏱️ 2 minutes

**Option A : Vous avez déjà un repository GitHub pour ce projet**

1. Notez l'URL de votre repository
2. Passez à l'étape 4

**Option B : Vous devez créer un repository GitHub**

1. **Allez** sur : https://github.com/
2. **Cliquez** sur le bouton "+" (en haut à droite) → "New repository"
3. **Remplissez** :
   - Repository name : `wordsmith-cicd` (ou autre nom)
   - Visibility : Public ou Private
   - **NE COCHEZ PAS** "Initialize with README"
4. **Cliquez** sur "Create repository"
5. **Notez** l'URL (exemple : `https://github.com/tudou/wordsmith-cicd.git`)

✅ **Résultat :** Vous avez un repository GitHub

---

### **ÉTAPE 4 : Configurer les secrets GitHub** ⏱️ 3 minutes

Les secrets permettent à GitHub Actions d'accéder à Docker Hub en toute sécurité.

1. **Allez** sur votre repository GitHub
2. **Cliquez** sur l'onglet "Settings" (Paramètres)
3. **Dans le menu de gauche**, cliquez sur "Secrets and variables" → "Actions"
4. **Cliquez** sur "New repository secret" (Nouveau secret)

**Secret 1 : Nom d'utilisateur Docker Hub**

- Name : `DOCKER_USERNAME`
- Secret : Votre nom d'utilisateur Docker Hub (exemple : `tudou123`)
- **Cliquez** sur "Add secret"

5. **Cliquez** de nouveau sur "New repository secret"

**Secret 2 : Token Docker Hub**

- Name : `DOCKER_PASSWORD`
- Secret : Le token que vous avez copié à l'étape 2 (commence par `dckr_pat_...`)
- **Cliquez** sur "Add secret"

**Vérification :**

Vous devriez maintenant voir **2 secrets** dans la liste :
- ✅ DOCKER_USERNAME
- ✅ DOCKER_PASSWORD

✅ **Résultat :** GitHub Actions peut maintenant se connecter à Docker Hub

---

### **ÉTAPE 5 : Initialiser Git dans le projet** ⏱️ 2 minutes

**Ouvrez PowerShell** et tapez :

```powershell
# Aller dans le dossier du projet
cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2

# Vérifier si Git est déjà initialisé
git status
```

**Si vous voyez une erreur "not a git repository" :**

```powershell
# Initialiser Git
git init

# Ajouter tous les fichiers
git add .

# Premier commit
git commit -m "Initial commit: Dockerfiles, Compose, and GitHub Actions workflow"
```

**Si Git est déjà initialisé :**

```powershell
# Ajouter tous les fichiers
git add .

# Commit
git commit -m "Add GitHub Actions workflow for CI/CD"
```

✅ **Résultat :** Votre projet est prêt à être poussé sur GitHub

---

### **ÉTAPE 6 : Lier le projet à GitHub et pousser** ⏱️ 3 minutes

```powershell
# Ajouter le repository GitHub comme origin (REMPLACEZ L'URL PAR LA VÔTRE)
git remote add origin https://github.com/VOTRE_USERNAME/VOTRE_REPO.git

# Ou si "origin" existe déjà, le modifier :
git remote set-url origin https://github.com/VOTRE_USERNAME/VOTRE_REPO.git

# Pousser vers GitHub (branche main)
git branch -M main
git push -u origin main
```

**Si vous avez une erreur d'authentification :**

GitHub nécessite un Personal Access Token (PAT) :

1. Allez sur GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Générez un nouveau token avec la permission "repo"
3. Utilisez ce token comme mot de passe lors du push

**Ou utilisez GitHub Desktop / GitHub CLI pour simplifier.**

✅ **Résultat :** Votre code est sur GitHub et **le workflow GitHub Actions se lance automatiquement !**

---

### **ÉTAPE 7 : Vérifier l'exécution du workflow** ⏱️ 5 minutes

1. **Allez** sur votre repository GitHub
2. **Cliquez** sur l'onglet "Actions"
3. Vous devriez voir le workflow "Build Wordsmith Images" en cours (🟡 jaune) ou terminé (✅ vert)
4. **Cliquez** sur le workflow pour voir les détails
5. Vous verrez **3 jobs** qui s'exécutent **en parallèle** :
   - ✅ Build and Push DB Image (~3 min)
   - ✅ Build and Push Words Image (~4 min)
   - ✅ Build and Push Web Image (~2 min)

**Attendez que tout soit vert ✅**

**En cas d'erreur ❌ :**
- Vérifiez que les secrets sont bien configurés
- Vérifiez que le token Docker Hub a les bonnes permissions
- Regardez les logs pour comprendre l'erreur

✅ **Résultat :** Les 3 images sont construites et publiées sur Docker Hub !

---

### **ÉTAPE 8 : Vérifier les images sur Docker Hub** ⏱️ 2 minutes

1. **Allez** sur : https://hub.docker.com/
2. **Connectez-vous**
3. **Cliquez** sur "Repositories"
4. Vous devriez voir **3 nouvelles images** :
   - ✅ `votre-username/wordsmith-db`
   - ✅ `votre-username/wordsmith-words`
   - ✅ `votre-username/wordsmith-web`

5. **Cliquez** sur une image pour voir les détails
6. Vous verrez **3 tags** pour chaque image :
   - `latest`
   - `abc123...` (SHA du commit Git)
   - `v1.0`

✅ **Résultat :** Vos images sont publiques et accessibles à tous !

---

### **ÉTAPE 9 : Modifier docker-compose.hub.yml** ⏱️ 1 minute

Ce fichier permet de lancer l'application avec les images de Docker Hub.

**Méthode manuelle :**

1. Ouvrez `docker-compose.hub.yml`
2. Remplacez **TOUTES** les occurrences de `votre-username` par votre vrai username Docker Hub

**Méthode automatique (PowerShell) :**

```powershell
cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2

# REMPLACEZ "tudou123" par VOTRE username Docker Hub
$username = "tudou123"
(Get-Content docker-compose.hub.yml) -replace 'votre-username', $username | Set-Content docker-compose.hub.yml
```

✅ **Résultat :** Le fichier est prêt à télécharger vos images depuis Docker Hub

---

### **ÉTAPE 10 : Tester avec les images Docker Hub** ⏱️ 3 minutes

Maintenant, testez que tout fonctionne avec les images publiées !

```powershell
# Aller dans le dossier
cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2

# Lancer avec les images Docker Hub
docker compose -f docker-compose.hub.yml up -d

# Ce qui va se passer :
# Docker va TÉLÉCHARGER vos images depuis Docker Hub
# (comme quand vous faites "docker pull nginx")

# Attendre que Java démarre
Start-Sleep -Seconds 25

# Tester l'API
Invoke-WebRequest http://localhost/words/noun -UseBasicParsing
Invoke-WebRequest http://localhost/words/verb -UseBasicParsing
Invoke-WebRequest http://localhost/words/adjective -UseBasicParsing
```

**Ouvrir dans le navigateur** : http://localhost

✅ **Résultat :** L'application fonctionne avec vos images Docker Hub !

**Arrêter :**

```powershell
docker compose -f docker-compose.hub.yml down
```

---

## 🎉 FÉLICITATIONS !

Vous avez complété un **workflow DevOps professionnel** avec :

- ✅ **Docker** : Images optimisées
- ✅ **Docker Compose** : Orchestration multi-conteneurs
- ✅ **GitHub Actions** : CI/CD automatisé
- ✅ **Docker Hub** : Registry public

**À partir de maintenant :**

Chaque fois que vous faites `git push` :
1. GitHub Actions construit automatiquement les images
2. Les publie sur Docker Hub
3. N'importe qui peut les utiliser !

---

## 📊 Récapitulatif des commandes

| Action | Commande |
|--------|----------|
| Tester localement | `docker compose up -d` |
| Tester avec Docker Hub | `docker compose -f docker-compose.hub.yml up -d` |
| Arrêter | `docker compose down` |
| Voir les logs | `docker compose logs -f` |
| Pousser sur GitHub | `git add . && git commit -m "message" && git push` |

---

## 🐛 Problèmes courants

### Workflow échoue avec "Error: Cannot perform an interactive login"

**Solution :** Vérifiez les secrets GitHub
- DOCKER_USERNAME doit être votre nom d'utilisateur (pas email)
- DOCKER_PASSWORD doit être le TOKEN (pas votre mot de passe)

### "Permission denied" lors du push

**Solution :** Configurez un Personal Access Token GitHub
- GitHub Settings → Developer settings → Personal access tokens
- Générez un token avec permission "repo"

### Images ne sont pas poussées

**Solution :** Vérifiez les permissions du token Docker Hub
- Le token doit avoir "Read, Write, Delete"

---

## 📚 Ressources

- [Documentation Docker Hub](https://docs.docker.com/docker-hub/)
- [Documentation GitHub Actions](https://docs.github.com/en/actions)
- [Documentation Docker Compose](https://docs.docker.com/compose/)

---

**Bon courage ! 🚀**

