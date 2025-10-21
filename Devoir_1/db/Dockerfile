# ══════════════════════════════════════════════════════════════════════════════
# ÉTAPE 1 : DOCKERFILE POUR LA BASE DE DONNÉES POSTGRESQL
# ══════════════════════════════════════════════════════════════════════════════
# Ce fichier crée une image Docker contenant PostgreSQL avec les données initiales
# pour l'application Wordsmith (mots pour générer des phrases aléatoires)
# ══════════════════════════════════════════════════════════════════════════════

# FROM : Spécifie l'image de base à utiliser
# postgres:16-alpine = PostgreSQL version 16 sur Alpine Linux (très léger, ~230 MB)
# Alpine = Distribution Linux minimale pour réduire la taille de l'image
FROM postgres:16-alpine

# ──────────────────────────────────────────────────────────────────────────────
# Configuration de l'initialisation de la base de données
# ──────────────────────────────────────────────────────────────────────────────

# COPY : Copie un fichier depuis votre ordinateur vers l'image Docker
# words.sql = Fichier contenant les commandes SQL pour créer les tables et insérer les données
# /docker-entrypoint-initdb.d/ = Dossier spécial de PostgreSQL
#   → Tous les fichiers .sql dans ce dossier sont exécutés automatiquement au premier démarrage
COPY words.sql /docker-entrypoint-initdb.d/

# ──────────────────────────────────────────────────────────────────────────────
# Configuration de la sécurité (MODE DÉVELOPPEMENT UNIQUEMENT !)
# ──────────────────────────────────────────────────────────────────────────────

# ENV : Définit une variable d'environnement dans le conteneur
# POSTGRES_HOST_AUTH_METHOD=trust signifie :
#   → Accepter TOUTES les connexions SANS mot de passe
#   ⚠️  ATTENTION : À utiliser UNIQUEMENT pour le développement/apprentissage
#   ⚠️  En production, utilisez TOUJOURS un mot de passe !
ENV POSTGRES_HOST_AUTH_METHOD=trust

# ──────────────────────────────────────────────────────────────────────────────
# Exposition du port réseau
# ──────────────────────────────────────────────────────────────────────────────

# EXPOSE : Indique que le conteneur écoute sur ce port
# 5432 = Port par défaut de PostgreSQL
# Note : Cette instruction est DOCUMENTAIRE, elle ne publie pas réellement le port
#        (c'est docker-compose.yml qui gère la publication des ports)
EXPOSE 5432

# ══════════════════════════════════════════════════════════════════════════════
# RÉSUMÉ DE CE QUE FAIT CE DOCKERFILE :
# ══════════════════════════════════════════════════════════════════════════════
# 1. Prend une image PostgreSQL 16 légère (Alpine)
# 2. Copie le fichier words.sql qui sera exécuté au démarrage
# 3. Configure PostgreSQL pour accepter les connexions sans mot de passe (dev only)
# 4. Expose le port 5432 pour permettre les connexions
# ══════════════════════════════════════════════════════════════════════════════
# Résultat : Une base de données prête à l'emploi avec les mots pour Wordsmith !
# ══════════════════════════════════════════════════════════════════════════════

