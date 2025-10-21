# 📁 ÉTAPE 2 : API REST Java (Service Words)

## 🎯 Objectif
Créer une API REST en Java qui interroge la base de données et retourne des mots aléatoires.

## 📋 Fichiers dans ce dossier

### 1. `Dockerfile` ⭐ MULTI-STAGE BUILD
**Rôle :** Construit l'image Docker de l'API de manière optimisée
**Technique spéciale :** Multi-stage build (2 étapes)
- **Étape 1 (Builder) :** Compile le code Java avec Maven
- **Étape 2 (Final) :** Image légère avec seulement le JAR compilé

### 2. `src/main/java/Main.java`
**Rôle :** Code source de l'API REST
**Ce qu'il fait :**
- Expose 3 endpoints HTTP :
  - `/noun` : Retourne un nom aléatoire
  - `/verb` : Retourne un verbe aléatoire
  - `/adjective` : Retourne un adjectif aléatoire
- Se connecte à PostgreSQL pour récupérer les mots

### 3. `pom.xml`
**Rôle :** Fichier de configuration Maven
**Ce qu'il contient :**
- Dépendances Java (Guava, PostgreSQL JDBC)
- Configuration du build

## 🚀 Comment construire l'image

```bash
# Depuis le dossier words/
docker build -t wordsmith-words .

# Ou depuis la racine avec docker-compose
docker compose build words
```

## 📊 Taille de l'image

### Sans multi-stage build : ~400 MB 😞
- Maven + JDK + code source + JAR = TRÈS LOURD

### Avec multi-stage build : ~60 MB ✅
- Seulement JRE + JAR = LÉGER !

**Gain : 85% de réduction ! 🎉**

## 🧪 Comment tester

```bash
# Lancer le conteneur (nécessite que db soit lancé)
docker run -d --name test-words --link test-db:db wordsmith-words

# Attendre 10 secondes (Java prend du temps à démarrer)
sleep 10

# Tester l'API
curl http://localhost:8080/noun
# {"word":"cloud"}

curl http://localhost:8080/verb
# {"word":"smashes"}

curl http://localhost:8080/adjective
# {"word":"a pink"}

# Nettoyer
docker stop test-words
docker rm test-words
```

## 💡 Points clés pour débutants

### Qu'est-ce qu'un Multi-Stage Build ?

**Sans multi-stage :**
```
Image finale = Tout (Maven + JDK + Code + JAR)
Taille : 400 MB 😞
```

**Avec multi-stage :**
```
Étape 1 (Builder): Maven + JDK + Code → JAR
                   ↓ (on garde seulement le JAR)
Étape 2 (Final):   JRE + JAR
Taille : 60 MB ✅
```

### Pourquoi JRE et pas JDK ?

- **JDK** (Java Development Kit) : Pour COMPILER du code Java
  - Contient : compilateur + runtime + outils
  - Taille : ~350 MB

- **JRE** (Java Runtime Environment) : Pour EXÉCUTER du code Java
  - Contient : seulement le runtime
  - Taille : ~50 MB

En production, on n'a pas besoin de compiler → JRE suffit !

### Comment fonctionne le cache Docker ?

```dockerfile
COPY pom.xml .              ← Si pom.xml ne change pas
RUN mvn dependency:...      ← Docker utilise le cache (rapide!)

COPY src ./src              ← Si on modifie le code
RUN mvn package             ← Seulement ça se refait
```

**Résultat :** Rebuild en < 10 secondes au lieu de 2 minutes !

## 🔍 Comprendre les commandes Maven

```bash
mvn dependency:go-offline
# → Télécharge toutes les bibliothèques Java nécessaires

mvn package
# → Compile le code + crée le fichier JAR
# → Résultat : target/words.jar
```

## ✅ Checklist

- [ ] Le fichier `Dockerfile` existe
- [ ] Multi-stage build configuré (2 FROM)
- [ ] L'image se construit sans erreur
- [ ] La taille de l'image est < 200 MB (objectif: ~60 MB)
- [ ] Le fichier `words.jar` est créé
- [ ] Le serveur démarre et affiche "Server started."
- [ ] Les 3 endpoints retournent du JSON

## 📖 Endpoints de l'API

| Endpoint | Méthode | Retour | Exemple |
|----------|---------|--------|---------|
| `/noun` | GET | JSON avec un nom | `{"word":"cloud"}` |
| `/verb` | GET | JSON avec un verbe | `{"word":"smashes"}` |
| `/adjective` | GET | JSON avec un adjectif | `{"word":"a pink"}` |

## 🔗 Prochaine étape

→ Aller dans `../web/` pour l'étape 3 (Frontend Go)

