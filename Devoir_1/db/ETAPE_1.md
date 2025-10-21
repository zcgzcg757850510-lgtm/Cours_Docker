# 📁 ÉTAPE 1 : Base de données (PostgreSQL)

## 🎯 Objectif
Créer une image Docker contenant une base de données PostgreSQL avec les données initiales de Wordsmith.

## 📋 Fichiers dans ce dossier

### 1. `Dockerfile`
**Rôle :** Définit comment construire l'image Docker de la base de données
**Ce qu'il fait :**
- Utilise PostgreSQL 16 sur Alpine Linux
- Copie le fichier `words.sql` pour initialiser la DB
- Configure l'accès sans mot de passe (développement)

### 2. `words.sql`
**Rôle :** Contient les données initiales de la base de données
**Ce qu'il contient :**
- Création de 3 tables : `nouns`, `verbs`, `adjectives`
- Insertion de mots amusants pour générer des phrases

## 🚀 Comment construire l'image

```bash
# Depuis le dossier db/
docker build -t wordsmith-db .

# Ou depuis la racine avec docker-compose
docker compose build db
```

## 📊 Taille de l'image attendue
- **Objectif :** < 300 MB
- **Résultat attendu :** ~230 MB ✅

## 🧪 Comment tester

```bash
# Lancer le conteneur
docker run -d --name test-db wordsmith-db

# Vérifier que PostgreSQL fonctionne
docker exec test-db pg_isready -U postgres

# Se connecter à la base de données
docker exec -it test-db psql -U postgres

# Dans psql, vérifier les données :
SELECT COUNT(*) FROM nouns;      -- Devrait retourner 18
SELECT COUNT(*) FROM verbs;      -- Devrait retourner 12
SELECT COUNT(*) FROM adjectives; -- Devrait retourner 16
\q

# Nettoyer
docker stop test-db
docker rm test-db
```

## 💡 Points clés pour débutants

### Qu'est-ce qu'une image Docker ?
Une image = un "modèle" contenant :
- Un système d'exploitation (Alpine Linux)
- Un logiciel (PostgreSQL)
- Vos fichiers (words.sql)

### Qu'est-ce qu'un conteneur ?
Un conteneur = une "instance en cours d'exécution" d'une image
- Comme un programme en cours d'exécution sur votre PC

### Pourquoi Alpine ?
- Alpine Linux = Distribution ultra-légère (~5 MB)
- Parfait pour Docker (réduit la taille des images)

## ✅ Checklist

- [ ] Le fichier `Dockerfile` existe
- [ ] Le fichier `words.sql` existe
- [ ] L'image se construit sans erreur
- [ ] La taille de l'image est < 300 MB
- [ ] PostgreSQL démarre correctement
- [ ] Les 3 tables contiennent des données

## 🔗 Prochaine étape

→ Aller dans `../words/` pour l'étape 2 (API REST Java)

