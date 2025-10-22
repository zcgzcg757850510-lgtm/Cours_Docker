# ══════════════════════════════════════════════════════════════════════════════
# ÉTAPE 3 : DOCKERFILE POUR LE SERVEUR WEB GO (FRONTEND)
# ══════════════════════════════════════════════════════════════════════════════
# Ce fichier crée une image Docker pour le serveur web qui :
#   - Sert l'interface utilisateur (HTML/CSS/JS)
#   - Fait le lien entre le navigateur et l'API REST
# Technique utilisée : MULTI-STAGE BUILD (optimisation)
# ══════════════════════════════════════════════════════════════════════════════

# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ ÉTAPE 1/2 : COMPILATION DU CODE GO (Builder Stage)                          │
# └──────────────────────────────────────────────────────────────────────────────┘
# Cette étape compile le code Go en un exécutable binaire

# FROM golang:1.21-alpine AS builder : Image avec le compilateur Go
# golang:1.21-alpine contient :
#   - Go version 1.21 (langage de programmation)
#   - Alpine Linux (léger)
# AS builder : Nomme cette étape "builder" pour y faire référence plus tard
FROM golang:1.21-alpine AS builder

# WORKDIR /app : Définit /app comme répertoire de travail
# Toutes les commandes suivantes s'exécutent dans /app
WORKDIR /app

# ──────────────────────────────────────────────────────────────────────────────
# Copie du code source Go
# ──────────────────────────────────────────────────────────────────────────────

# COPY dispatcher.go . : Copie le fichier source Go
# dispatcher.go = Code source du serveur web (1 seul fichier en Go !)
# . = Destination (/app/ dans le conteneur)
COPY dispatcher.go .

# ──────────────────────────────────────────────────────────────────────────────
# Compilation du programme Go
# ──────────────────────────────────────────────────────────────────────────────

# RUN go build dispatcher.go : Compile le code Go
# Résultat : Crée un fichier exécutable nommé "dispatcher"
# 
# Avantage de Go :
#   → Compilation en un SEUL fichier binaire
#   → Pas besoin de runtime (comme Java ou Python)
#   → Exécutable ultra-rapide !
RUN go build dispatcher.go

# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ ÉTAPE 2/2 : IMAGE FINALE ULTRA-LÉGÈRE (Production Stage)                    │
# └──────────────────────────────────────────────────────────────────────────────┘
# Cette étape crée l'image finale avec SEULEMENT :
#   - L'exécutable compilé
#   - Les fichiers statiques (HTML/CSS/JS)
# → Pas besoin du compilateur Go dans l'image finale !

# FROM alpine:latest : Image de base ultra-minimaliste
# alpine:latest = Distribution Linux de seulement ~5 MB
# C'est la plus petite distribution Linux disponible !
FROM alpine:latest

# Définir le répertoire de travail
WORKDIR /app

# ──────────────────────────────────────────────────────────────────────────────
# Copie de l'exécutable depuis l'étape builder
# ──────────────────────────────────────────────────────────────────────────────

# COPY --from=builder : Copie depuis l'étape "builder"
# /app/dispatcher (du builder) → /app/dispatcher (image finale)
# Note : On copie UNIQUEMENT l'exécutable compilé, pas le code source Go !
COPY --from=builder /app/dispatcher .

# ──────────────────────────────────────────────────────────────────────────────
# Copie des fichiers statiques (interface utilisateur)
# ──────────────────────────────────────────────────────────────────────────────

# COPY static ./static : Copie le dossier contenant :
#   - index.html      : Page web principale
#   - style.css       : Feuille de style
#   - app.js          : Code JavaScript/Angular
#   - angular.min.js  : Framework Angular
#   - images/         : Images (logos, etc.)
#   - fonts/          : Polices de caractères
COPY static ./static

# ──────────────────────────────────────────────────────────────────────────────
# Configuration du serveur web
# ──────────────────────────────────────────────────────────────────────────────

# EXPOSE 80 : Indique que le serveur écoute sur le port 80
# Port 80 = Port HTTP par défaut
# C'est pourquoi on peut accéder à http://localhost sans spécifier :80
EXPOSE 80

# ──────────────────────────────────────────────────────────────────────────────
# Commande de démarrage
# ──────────────────────────────────────────────────────────────────────────────

# CMD ["./dispatcher"] : Lance l'exécutable quand le conteneur démarre
# ./dispatcher = Exécute le serveur web Go
# 
# Ce serveur va :
#   1. Servir les fichiers du dossier static/ sur http://localhost:80
#   2. Rediriger les requêtes /words/* vers l'API REST (service words)
CMD ["./dispatcher"]

# ══════════════════════════════════════════════════════════════════════════════
# RÉSUMÉ DE CE QUE FAIT CE DOCKERFILE (MULTI-STAGE BUILD) :
# ══════════════════════════════════════════════════════════════════════════════
# ÉTAPE 1 (Builder) :
#   1. Prend une image avec Go compiler (~300 MB)
#   2. Compile dispatcher.go en un exécutable binaire
#
# ÉTAPE 2 (Final) :
#   1. Prend Alpine Linux (seulement ~5 MB !)
#   2. Copie UNIQUEMENT :
#      - L'exécutable compilé (~10 MB)
#      - Les fichiers static/ (~2 MB)
#   3. Résultat : Image finale de ~12 MB ! 🚀
#
# Avantage : Image finale 25x plus petite qu'avec le compilateur !
# ══════════════════════════════════════════════════════════════════════════════

