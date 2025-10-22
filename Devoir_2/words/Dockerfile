# ══════════════════════════════════════════════════════════════════════════════
# ÉTAPE 2 : DOCKERFILE POUR L'API REST JAVA (SERVICE WORDS)
# ══════════════════════════════════════════════════════════════════════════════
# Ce fichier crée une image Docker pour l'API REST qui interroge la base de données
# et retourne des mots aléatoires en JSON
# Technique utilisée : MULTI-STAGE BUILD (optimisation)
# ══════════════════════════════════════════════════════════════════════════════

# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ ÉTAPE 1/2 : CONSTRUCTION (Builder Stage)                                    │
# └──────────────────────────────────────────────────────────────────────────────┘
# Cette étape compile le code Java, puis sera supprimée de l'image finale
# pour réduire sa taille (on garde seulement le JAR compilé)

# FROM ... AS builder : Crée une étape temporaire nommée "builder"
# maven:3.9-eclipse-temurin-17-alpine contient :
#   - Maven 3.9 (outil de compilation Java)
#   - JDK 17 Eclipse Temurin (compilateur Java)
#   - Alpine Linux (léger)
FROM maven:3.9-eclipse-temurin-17-alpine AS builder

# WORKDIR : Définit le répertoire de travail dans le conteneur
# Toutes les commandes suivantes s'exécuteront dans /app
WORKDIR /app

# ──────────────────────────────────────────────────────────────────────────────
# OPTIMISATION : Téléchargement des dépendances en premier (Layer Caching)
# ──────────────────────────────────────────────────────────────────────────────
# Astuce Docker : Si pom.xml ne change pas, Docker réutilise le cache
# → Les dépendances ne sont téléchargées qu'une seule fois
# → Rebuild ultra-rapide quand on modifie seulement le code !

# COPY : Copie pom.xml (fichier de configuration Maven) depuis votre PC vers /app
COPY pom.xml .

# RUN : Exécute une commande dans le conteneur pendant la construction
# mvn dependency:go-offline = Télécharge toutes les dépendances Java
# -q = Mode silencieux (moins de logs)
RUN mvn dependency:go-offline -q

# ──────────────────────────────────────────────────────────────────────────────
# Copie du code source et compilation
# ──────────────────────────────────────────────────────────────────────────────

# COPY src ./src : Copie le dossier contenant le code Java
# src/ de votre PC → /app/src dans le conteneur
COPY src ./src

# RUN mvn package : Compile le code Java et crée un fichier JAR
# Maven crée : /app/target/words.jar (application compilée)
# -q = Mode silencieux
RUN mvn package -q

# ┌──────────────────────────────────────────────────────────────────────────────┐
# │ ÉTAPE 2/2 : IMAGE FINALE (Production Stage)                                 │
# └──────────────────────────────────────────────────────────────────────────────┘
# Cette étape crée l'image finale, SANS les outils de compilation
# → Image beaucoup plus petite (~60 MB au lieu de ~400 MB)

# FROM eclipse-temurin:17-jre-alpine : Nouvelle image de base
# JRE (Java Runtime Environment) = Seulement pour EXÉCUTER Java
#   (pas besoin du JDK qui est plus lourd)
# Alpine = Distribution Linux légère
FROM eclipse-temurin:17-jre-alpine

# Définir le répertoire de travail
WORKDIR /app

# ──────────────────────────────────────────────────────────────────────────────
# Copie des fichiers compilés depuis l'étape "builder"
# ──────────────────────────────────────────────────────────────────────────────

# COPY --from=builder : Copie depuis l'étape précédente (builder)
# /app/target/words.jar du builder → /app/words.jar dans l'image finale
COPY --from=builder /app/target/words.jar .

# Copie les dépendances (bibliothèques Java nécessaires)
COPY --from=builder /app/target/dependency ./dependency

# ──────────────────────────────────────────────────────────────────────────────
# Configuration du service
# ──────────────────────────────────────────────────────────────────────────────

# EXPOSE : Documente que l'application écoute sur le port 8080
# L'API REST sera accessible sur ce port
EXPOSE 8080

# CMD : Commande exécutée quand le conteneur démarre
# ["java", "-Xmx8m", "-Xms8m", "-jar", "words.jar"] signifie :
#   java           = Lance Java
#   -Xmx8m         = Mémoire maximum : 8 MB
#   -Xms8m         = Mémoire initiale : 8 MB
#   -jar words.jar = Exécute le fichier JAR
CMD ["java", "-Xmx8m", "-Xms8m", "-jar", "words.jar"]

# ══════════════════════════════════════════════════════════════════════════════
# RÉSUMÉ DE CE QUE FAIT CE DOCKERFILE (MULTI-STAGE BUILD) :
# ══════════════════════════════════════════════════════════════════════════════
# ÉTAPE 1 (Builder) :
#   1. Prend une image avec Maven et JDK (gros, ~400 MB)
#   2. Télécharge les dépendances Java
#   3. Compile le code source en fichier JAR
#
# ÉTAPE 2 (Final) :
#   1. Prend une image avec seulement JRE (petit, ~60 MB)
#   2. Copie UNIQUEMENT le JAR compilé (pas le code source ni Maven)
#   3. Résultat : Image finale ultra-légère ! 🚀
#
# Avantage : Image finale 6x plus petite qu'une image simple !
# ══════════════════════════════════════════════════════════════════════════════

