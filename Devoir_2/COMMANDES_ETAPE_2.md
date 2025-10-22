# 📋 TABLEAU DES COMMANDES - Étape 2 : CI/CD

## 🎯 Toutes les commandes dont vous aurez besoin

---

## 📦 **PARTIE A : Préparation locale**

### **Commandes PowerShell à exécuter**

| Étape | Commande | Description | Résultat attendu |
|-------|----------|-------------|------------------|
| **Aller dans le dossier** | `cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2` | Se positionner dans le projet | Vous êtes dans le bon dossier |
| **Lancer le script d'aide** | `.\setup-cicd.ps1` | Automatise la configuration | Script vérifie tout et configure |
| **Vérifier Docker** | `docker --version` | Voir si Docker est installé | Version de Docker affichée |
| **Vérifier Git** | `git --version` | Voir si Git est installé | Version de Git affichée |

---

## 🔧 **PARTIE B : Configuration Docker Hub** (via navigateur web)

| Étape | Action | URL / Localisation |
|-------|--------|-------------------|
| **1. Créer compte** | S'inscrire sur Docker Hub | https://hub.docker.com/ |
| **2. Aller dans Settings** | Cliquer sur avatar → Account Settings | En haut à droite |
| **3. Générer token** | Security → Personal Access Tokens → New | Permissions : Read, Write, Delete |
| **4. Copier token** | Copier le token (commence par `dckr_pat_...`) | ⚠️ Ne sera affiché qu'une fois |

---

## 🔐 **PARTIE C : Configuration GitHub** (via navigateur web)

| Étape | Action | Localisation |
|-------|--------|-------------|
| **1. Créer repository** | New repository (si pas déjà fait) | https://github.com/new |
| **2. Aller dans Settings** | Settings du repository | Onglet en haut |
| **3. Ouvrir Secrets** | Secrets and variables → Actions | Menu de gauche |
| **4. Ajouter secret 1** | New secret : `DOCKER_USERNAME` | Votre username Docker Hub |
| **5. Ajouter secret 2** | New secret : `DOCKER_PASSWORD` | Votre token Docker Hub |

---

## 🚀 **PARTIE D : Git - Premier push**

### **Si Git n'est PAS encore initialisé**

| Étape | Commande | Description |
|-------|----------|-------------|
| 1 | `cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2` | Aller dans le dossier |
| 2 | `git init` | Initialiser Git |
| 3 | `git add .` | Ajouter tous les fichiers |
| 4 | `git commit -m "Initial commit: CI/CD workflow"` | Premier commit |
| 5 | `git remote add origin https://github.com/VOTRE_USER/VOTRE_REPO.git` | Lier à GitHub |
| 6 | `git branch -M main` | Renommer en branche main |
| 7 | `git push -u origin main` | Pousser vers GitHub |

### **Si Git est DÉJÀ initialisé**

| Étape | Commande | Description |
|-------|----------|-------------|
| 1 | `cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2` | Aller dans le dossier |
| 2 | `git add .` | Ajouter tous les fichiers |
| 3 | `git commit -m "Add CI/CD workflow"` | Commit |
| 4 | `git remote set-url origin https://github.com/VOTRE_USER/VOTRE_REPO.git` | Modifier origin (si besoin) |
| 5 | `git push origin main` | Pousser vers GitHub |

---

## 👀 **PARTIE E : Vérification GitHub Actions** (via navigateur web)

| Étape | Action | Où aller |
|-------|--------|----------|
| **1. Ouvrir Actions** | Aller sur votre repository GitHub → Onglet "Actions" | Barre de navigation |
| **2. Voir le workflow** | Cliquer sur "Build Wordsmith Images" | Liste des workflows |
| **3. Attendre** | Attendre que les 3 jobs soient verts ✅ | 3-5 minutes |
| **4. Voir les détails** | Cliquer sur un job pour voir les logs | Optionnel |

---

## 🐳 **PARTIE F : Vérification Docker Hub** (via navigateur web)

| Étape | Action | Où aller |
|-------|--------|----------|
| **1. Ouvrir Docker Hub** | Se connecter à Docker Hub | https://hub.docker.com/ |
| **2. Voir repositories** | Cliquer sur "Repositories" | Menu du haut |
| **3. Vérifier images** | Vous devriez voir 3 images | wordsmith-db, wordsmith-words, wordsmith-web |
| **4. Voir les tags** | Cliquer sur une image | 3 tags : latest, SHA, v1.0 |

---

## ✅ **PARTIE G : Test final avec images Docker Hub**

### **Commandes PowerShell**

| Étape | Commande | Description | Résultat attendu |
|-------|----------|-------------|------------------|
| **1** | `cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2` | Aller dans le dossier | - |
| **2** | Modifier `docker-compose.hub.yml` manuellement | Remplacer `votre-username` par votre vrai username | - |
| **3** | `docker compose -f docker-compose.hub.yml up -d` | Lancer avec images Docker Hub | Images téléchargées et conteneurs démarrés |
| **4** | `docker compose -f docker-compose.hub.yml ps` | Vérifier les conteneurs | 3 conteneurs "Up" |
| **5** | `Start-Sleep -Seconds 25` | Attendre Java | Pause 25 secondes |
| **6** | `Invoke-WebRequest http://localhost/words/noun -UseBasicParsing` | Tester API | Retourne un mot JSON |
| **7** | Ouvrir navigateur → `http://localhost` | Tester interface web | Page s'affiche |
| **8** | `docker compose -f docker-compose.hub.yml down` | Arrêter | Conteneurs supprimés |

### **Ou remplacer automatiquement le username**

```powershell
# REMPLACEZ "tudou123" par VOTRE username Docker Hub
$username = "tudou123"
(Get-Content docker-compose.hub.yml) -replace 'votre-username', $username | Set-Content docker-compose.hub.yml
```

---

## 🔄 **PARTIE H : Workflow continu** (après configuration initiale)

Une fois tout configuré, voici les commandes pour les prochaines modifications :

| Action | Commandes | Résultat |
|--------|-----------|----------|
| **Modifier code** | Éditez vos fichiers | - |
| **Commit & Push** | `git add .` <br> `git commit -m "Description"` <br> `git push` | GitHub Actions se lance automatiquement |
| **Vérifier** | Aller sur GitHub → Actions | Voir le build en cours |
| **Tester** | `docker compose -f docker-compose.hub.yml up -d` | Utilise les nouvelles images |

---

## 🆘 **PARTIE I : Dépannage**

### **Commandes de diagnostic**

| Problème | Commande | Solution |
|----------|----------|----------|
| Vérifier état Docker | `docker ps` | Si erreur, démarrer Docker Desktop |
| Voir images locales | `docker images \| findstr wordsmith` | Liste vos images |
| Voir logs conteneur | `docker compose -f docker-compose.hub.yml logs words` | Déboguer Java |
| Nettoyer tout | `docker system prune -a` | ⚠️ Supprime tout |
| Vérifier Git | `git status` | Voir l'état du repository |
| Voir remote Git | `git remote -v` | Vérifier l'URL GitHub |

### **Résoudre problèmes Git**

| Problème | Commande |
|----------|----------|
| Changer URL GitHub | `git remote set-url origin https://github.com/USER/REPO.git` |
| Voir branches | `git branch -a` |
| Forcer push (⚠️ dangereux) | `git push -f origin main` |

---

## 📊 **PARTIE J : Récapitulatif des fichiers importants**

| Fichier | Description | Vous devez le modifier ? |
|---------|-------------|-------------------------|
| `.github/workflows/build-wordsmith.yml` | Workflow GitHub Actions | ❌ Non (déjà configuré) |
| `docker-compose.yml` | Pour build local | ❌ Non |
| `docker-compose.hub.yml` | Pour images Docker Hub | ✅ Oui (username) |
| `db/Dockerfile` | Image PostgreSQL | ❌ Non |
| `words/Dockerfile` | Image Java | ❌ Non |
| `web/Dockerfile` | Image Go | ❌ Non |

---

## ⏱️ **Ordre d'exécution recommandé**

```
1. .\setup-cicd.ps1
   ↓
2. Créer compte + token Docker Hub (navigateur)
   ↓
3. Configurer secrets GitHub (navigateur)
   ↓
4. git add . && git commit && git push
   ↓
5. Vérifier GitHub Actions (navigateur)
   ↓
6. Vérifier Docker Hub (navigateur)
   ↓
7. docker compose -f docker-compose.hub.yml up -d
   ↓
8. Ouvrir http://localhost
   ↓
9. ✅ TERMINÉ !
```

---

## 🎯 **Commandes essentielles à retenir**

| Quoi | Commande |
|------|----------|
| 🚀 **Démarrer le script d'aide** | `.\setup-cicd.ps1` |
| 📤 **Pousser vers GitHub** | `git add . && git commit -m "msg" && git push` |
| 🐳 **Tester avec Docker Hub** | `docker compose -f docker-compose.hub.yml up -d` |
| 🛑 **Arrêter** | `docker compose -f docker-compose.hub.yml down` |
| 👀 **Voir logs** | `docker compose logs -f` |

---

## 📚 **Guides disponibles**

| Fichier | Contenu |
|---------|---------|
| `ETAPE_2_RESUME.md` | Résumé rapide (checklist) |
| `GUIDE_ETAPE_2_CICD.md` | Guide détaillé complet |
| `COMMANDES_ETAPE_2.md` | Ce fichier (toutes les commandes) |

---

**Bonne chance ! 🚀**

