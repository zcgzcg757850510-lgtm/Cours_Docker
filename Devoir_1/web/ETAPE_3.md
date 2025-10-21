# 📁 ÉTAPE 3 : Serveur Web Go (Frontend)

## 🎯 Objectif
Créer le serveur web frontend qui sert l'interface utilisateur et fait le lien avec l'API.

## 📋 Fichiers dans ce dossier

### 1. `Dockerfile` ⭐ MULTI-STAGE BUILD
**Rôle :** Construit l'image Docker du serveur web
**Technique :** Multi-stage build (2 étapes)
- **Étape 1 (Builder) :** Compile le code Go
- **Étape 2 (Final) :** Image ultra-légère avec Alpine

### 2. `dispatcher.go`
**Rôle :** Code source du serveur web en Go
**Ce qu'il fait :**
- Sert les fichiers statiques (HTML, CSS, JS, images)
- Redirige `/words/*` vers l'API REST
- Load balancing entre plusieurs instances de l'API

### 3. `static/`
**Rôle :** Contient l'interface utilisateur
**Fichiers importants :**
- `index.html` : Page principale
- `app.js` : Logique JavaScript (Angular)
- `style.css` : Styles CSS
- `images/` : Logos et images
- `fonts/` : Polices

## 🚀 Comment construire l'image

```bash
# Depuis le dossier web/
docker build -t wordsmith-web .

# Ou depuis la racine
docker compose build web
```

## 📊 Taille de l'image

### Sans multi-stage build : ~300 MB 😞
- Go compiler + code source + exécutable = LOURD

### Avec multi-stage build : ~12 MB ✅
- Seulement Alpine + exécutable + static = ULTRA LÉGER !

**Gain : 96% de réduction ! 🎉**

## 🧪 Comment tester

```bash
# Lancer le conteneur
docker run -d --name test-web -p 8080:80 wordsmith-web

# Tester dans le navigateur
# Ouvrir : http://localhost:8080

# Ou avec curl
curl http://localhost:8080
# → Retourne le HTML de la page

# Nettoyer
docker stop test-web
docker rm test-web
```

## 💡 Points clés pour débutants

### Pourquoi Go est parfait pour Docker ?

**Langages interprétés (Python, Node.js) :**
```
Image finale = Runtime + Code source + Dépendances
Exemple Python : ~200 MB
```

**Langages avec VM (Java) :**
```
Image finale = JVM + JAR + Dépendances
Exemple Java : ~60 MB
```

**Go (compilé en binaire statique) :**
```
Image finale = Binaire seul
Exemple Go : ~10 MB ✅
```

### C'est quoi un binaire statique ?

- **Binaire :** Fichier exécutable directement par le CPU
- **Statique :** Toutes les dépendances sont INCLUSES dans le fichier
- **Avantage :** Un seul fichier suffit, pas besoin de runtime !

```bash
# Le fichier dispatcher contient TOUT :
dispatcher  # ← Exécutable de ~10 MB qui fonctionne tout seul
```

### Architecture du serveur web

```
┌─────────────────────────────────────────┐
│    Navigateur Web (http://localhost)    │
└──────────────┬──────────────────────────┘
               │
               ▼
┌──────────────────────────────────────────┐
│     Serveur Go (dispatcher)               │
│     Port 80                               │
├───────────────────────────────────────────┤
│  Route /           → Fichiers static/     │
│  Route /words/*    → API REST (words:8080)│
└──────────────────────────────────────────┘
```

## 🔍 Comprendre dispatcher.go

```go
// Servir les fichiers statiques
http.Handle("/", http.FileServer(http.Dir("static")))
// Quand on accède à http://localhost/
// → Retourne static/index.html

// Rediriger vers l'API
http.Handle("/words/", http.StripPrefix("/words", fwd))
// Quand on accède à http://localhost/words/noun
// → Redirige vers http://words:8080/noun
```

## ✅ Checklist

- [ ] Le fichier `Dockerfile` existe
- [ ] Multi-stage build configuré (2 FROM)
- [ ] L'image se construit sans erreur
- [ ] La taille de l'image est < 100 MB (objectif: ~12 MB)
- [ ] Le serveur démarre et affiche "Listening on port 80"
- [ ] La page web s'affiche dans le navigateur
- [ ] Le dossier `static/` contient tous les fichiers

## 🌐 Fichiers du dossier static/

| Fichier | Rôle |
|---------|------|
| `index.html` | Page HTML principale |
| `app.js` | Application Angular (génère les phrases) |
| `angular.min.js` | Framework JavaScript Angular |
| `style.css` | Styles CSS (couleurs, mise en page) |
| `favicon.ico` | Icône du site dans l'onglet |
| `images/` | Logos et images décoratives |
| `fonts/` | Polices personnalisées |

## 🎨 Comment fonctionne l'interface ?

1. L'utilisateur ouvre http://localhost
2. Le navigateur charge `index.html` + `app.js`
3. L'utilisateur clique sur "Go!"
4. JavaScript fait 3 requêtes :
   - `/words/noun` → récupère un nom
   - `/words/verb` → récupère un verbe
   - `/words/adjective` → récupère un adjectif
5. JavaScript assemble les mots en phrase
6. La phrase s'affiche à l'écran !

## 🔗 Prochaine étape

→ Retourner à la racine du projet pour l'étape 4 (Docker Compose)

