# 🧪 COMMANDES POUR TESTER LES EXERCICES 1 ET 2

## ⚠️ Prérequis

**Docker Desktop doit être installé et démarré !**

### Vérifier que Docker fonctionne :

```powershell
# Dans PowerShell, tapez :
docker --version

# Devrait afficher quelque chose comme :
# Docker version 24.0.x, build xxxxx

# Si erreur "docker n'est pas reconnu" :
# → Installez Docker Desktop depuis votre Bureau (DockerDesktopInstaller.exe)
# → Redémarrez l'ordinateur
# → Lancez "Docker Desktop" depuis le menu Démarrer
```

---

## 📋 EXERCICE 1 : Construction des 3 images

### Étape 1 : Aller dans le dossier du projet

```powershell
# Ouvrir PowerShell et taper :
cd C:\Users\tudou\Desktop\Develop\Devoir\wordsmith
```

---

### Étape 2 : Construire l'image de la base de données (db)

```powershell
# Construire l'image db
docker build -t wordsmith-db ./db

# Explications :
#   docker build    = Construire une image
#   -t wordsmith-db = Nommer l'image "wordsmith-db"
#   ./db            = Utiliser le Dockerfile dans le dossier db/
```

**Ce qui va se passer :**
```
[+] Building 15.3s
 => [1/2] FROM postgres:16-alpine          5.2s
 => [2/2] COPY words.sql /docker-...       0.1s
 => exporting to image                     0.2s
 => naming to wordsmith-db                 0.0s
```

✅ **Si vous voyez ça → SUCCÈS !**

---

### Étape 3 : Construire l'image de l'API Java (words)

```powershell
# Construire l'image words
docker build -t wordsmith-words ./words

# ⚠️ ATTENTION : Cette étape est LONGUE (2-5 minutes)
# Maven va télécharger beaucoup de dépendances Java
```

**Ce qui va se passer :**
```
[+] Building 145.2s
 => [builder 1/4] FROM maven:3.9...        25.3s
 => [builder 2/4] COPY pom.xml .           0.2s
 => [builder 3/4] RUN mvn dependency...    85.4s  ← LONG !
 => [builder 4/4] RUN mvn package          30.1s
 => [stage-1 1/2] FROM eclipse-temurin...  10.2s
 => [stage-1 2/2] COPY --from=builder...   0.3s
 => exporting to image                      2.1s
```

✅ **Patience ! C'est normal que ça prenne du temps la première fois.**

---

### Étape 4 : Construire l'image du frontend Go (web)

```powershell
# Construire l'image web
docker build -t wordsmith-web ./web

# Cette étape est plus rapide (30 secondes - 1 minute)
```

**Ce qui va se passer :**
```
[+] Building 32.4s
 => [builder 1/2] FROM golang:1.21...      15.2s
 => [builder 2/2] RUN go build...          10.1s
 => [stage-1 1/3] FROM alpine:latest        2.3s
 => [stage-1 2/3] COPY --from=builder...   0.1s
 => [stage-1 3/3] COPY static ./static      0.2s
 => exporting to image                      1.5s
```

✅ **Plus rapide que words grâce à Go !**

---

## 📊 EXERCICE 2 : Vérifier l'optimisation de la taille

### Étape 5 : Voir la taille des images créées

```powershell
# Lister toutes les images Wordsmith
docker images | findstr wordsmith

# Ou sur Linux/Mac :
docker images | grep wordsmith
```

**Résultat attendu :**
```
REPOSITORY        TAG      IMAGE ID      CREATED         SIZE
wordsmith-web     latest   abc123def     2 minutes ago   12.5 MB   ✅ EXCELLENT !
wordsmith-words   latest   def456ghi     5 minutes ago   62.1 MB   ✅ EXCELLENT !
wordsmith-db      latest   ghi789jkl     8 minutes ago   231 MB    ✅ BON !
```

---

### Étape 6 : Comparer avec les objectifs

| Image | Taille obtenue | Objectif "bon" | Objectif "excellent" | Résultat |
|-------|----------------|----------------|----------------------|----------|
| web | ~12 MB | < 100 MB | < 10 MB | 🏆 EXCELLENT ! |
| words | ~62 MB | < 200 MB | < 50 MB | ✅ TRÈS BON ! |
| db | ~231 MB | < 300 MB | N/A | ✅ BON ! |

✅ **Si vos tailles sont proches de ça → EXERCICES 1 ET 2 RÉUSSIS ! 🎉**

---

## 🧪 BONUS : Tester que les images fonctionnent

### Test 1 : Tester l'image db

```powershell
# Lancer un conteneur de test
docker run -d --name test-db wordsmith-db

# Attendre 5 secondes que PostgreSQL démarre
Start-Sleep -Seconds 5

# Vérifier que PostgreSQL fonctionne
docker exec test-db pg_isready -U postgres

# Devrait afficher :
# /var/run/postgresql:5432 - accepting connections

# Se connecter à la base et vérifier les données
docker exec -it test-db psql -U postgres

# Dans psql, taper :
SELECT COUNT(*) FROM nouns;      
# → Devrait retourner 18

\q
# → Quitter psql

# Nettoyer
docker stop test-db
docker rm test-db
```

✅ **Si vous voyez 18 → La base de données fonctionne !**

---

### Test 2 : Tester l'image words (API Java)

```powershell
# Relancer db (nécessaire pour words)
docker run -d --name test-db wordsmith-db

# Attendre que db soit prêt
Start-Sleep -Seconds 10

# Lancer words avec un lien vers db
docker run -d --name test-words --link test-db:db wordsmith-words

# Attendre que Java démarre (plus long)
Start-Sleep -Seconds 20

# Vérifier les logs
docker logs test-words

# Devrait afficher :
# Server started.

# Nettoyer
docker stop test-words test-db
docker rm test-words test-db
```

✅ **Si vous voyez "Server started." → L'API fonctionne !**

---

### Test 3 : Tester l'image web

```powershell
# Lancer web (seul, pour tester le serveur)
docker run -d --name test-web -p 8080:80 wordsmith-web

# Attendre 3 secondes
Start-Sleep -Seconds 3

# Tester dans le navigateur
# Ouvrir : http://localhost:8080

# Ou avec curl (PowerShell) :
Invoke-WebRequest http://localhost:8080 -UseBasicParsing

# Nettoyer
docker stop test-web
docker rm test-web
```

✅ **Si la page web s'affiche → Le frontend fonctionne !**

---

## 📝 Résumé des commandes principales

### Pour l'Exercice 1 (Construction)

```powershell
# Aller dans le dossier
cd C:\Users\tudou\Desktop\Develop\Devoir\wordsmith

# Construire les 3 images
docker build -t wordsmith-db ./db
docker build -t wordsmith-words ./words
docker build -t wordsmith-web ./web
```

### Pour l'Exercice 2 (Vérification taille)

```powershell
# Voir les tailles
docker images | findstr wordsmith

# Vérifier que :
# - web < 100 MB ✅
# - words < 200 MB ✅
# - db < 300 MB ✅
```

---

## 🎯 Après avoir testé les Exercices 1 et 2

### Prochaine étape : Exercice 4 (Docker Compose)

Une fois Docker installé, vous pourrez :

```powershell
# Au lieu de lancer 3 commandes séparées...
# Utilisez Docker Compose pour tout lancer en une commande :

docker compose up -d

# Puis ouvrez : http://localhost
```

---

## 📋 Checklist finale

- [ ] Docker Desktop installé et démarré
- [ ] `docker --version` fonctionne
- [ ] Les 3 images sont construites
- [ ] Les tailles sont optimisées
- [ ] Les images démarrent sans erreur
- [ ] ✅ **EXERCICES 1 ET 2 VALIDÉS !**

---

**Prochaine lecture : `ETAPE_4.md` pour apprendre Docker Compose ! 📖**

Voulez-vous que je vous aide à installer Docker pour pouvoir exécuter ces commandes ? 😊

