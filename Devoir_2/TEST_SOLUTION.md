# 🧪 Test de la solution - Images Docker Hub

## 🎯 Objectif
Tester que l'application fonctionne avec les images publiées sur Docker Hub.

---

## 📋 Prérequis

- [ ] GitHub Actions a construit et publié les images
- [ ] Les images sont visibles sur Docker Hub
- [ ] Vous avez noté votre nom d'utilisateur Docker Hub

---

## 🚀 Étape 1 : Modifier docker-compose.hub.yml

### Ouvrir le fichier `docker-compose.hub.yml`

### Remplacer `votre-username` par votre vrai nom d'utilisateur

**AVANT :**
```yaml
image: votre-username/wordsmith-db:latest
image: votre-username/wordsmith-words:latest
image: votre-username/wordsmith-web:latest
```

**APRÈS (exemple) :**
```yaml
image: tudou123/wordsmith-db:latest
image: tudou123/wordsmith-words:latest
image: tudou123/wordsmith-web:latest
```

💡 **Astuce PowerShell pour remplacer automatiquement :**

```powershell
# Remplacer dans le fichier (adapter avec VOTRE username)
$username = "tudou123"  # ← CHANGEZ ICI
(Get-Content docker-compose.hub.yml) -replace 'votre-username', $username | Set-Content docker-compose.hub.yml
```

---

## 🧪 Étape 2 : Lancer l'application

### Commandes à exécuter :

```powershell
# Aller dans le dossier
cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2

# Lancer avec les images Docker Hub
docker compose -f docker-compose.hub.yml up -d

# Ce qui va se passer :
# [+] Pulling 3/3
#  ✔ db Pulled      5.2s
#  ✔ words Pulled   8.4s
#  ✔ web Pulled     2.1s
# 
# [+] Running 4/4
#  ✔ Network created
#  ✔ Container wordsmith-db started
#  ✔ Container wordsmith-words started
#  ✔ Container wordsmith-web started
```

**⏱️ Temps estimé : 1-2 minutes** (téléchargement des images)

---

## ✅ Étape 3 : Vérifier que tout fonctionne

### Test 1 : Vérifier les conteneurs

```powershell
# Voir l'état des conteneurs
docker compose -f docker-compose.hub.yml ps

# Résultat attendu :
# NAME              STATUS
# wordsmith-db      Up
# wordsmith-words   Up
# wordsmith-web     Up
```

### Test 2 : Attendre le démarrage de Java

```powershell
# Java prend 20-25 secondes à démarrer
Start-Sleep -Seconds 25

# Ou voir les logs pour savoir quand c'est prêt
docker compose -f docker-compose.hub.yml logs words

# Cherchez : "Server started."
```

### Test 3 : Tester l'API REST

```powershell
# Tester les 3 endpoints
Invoke-WebRequest http://localhost/words/noun -UseBasicParsing
Invoke-WebRequest http://localhost/words/verb -UseBasicParsing
Invoke-WebRequest http://localhost/words/adjective -UseBasicParsing

# Résultat attendu (exemples) :
# {"word":"cloud"}
# {"word":"smashes"}
# {"word":"a pink"}
```

### Test 4 : Tester l'interface web

1. **Ouvrir votre navigateur**
2. **Aller à :** http://localhost
3. **Cliquer** sur le bouton "Go!"
4. **Résultat attendu :** Une phrase aléatoire s'affiche !

Exemple : *"A pink whale smashes the nordic fjørd"* 🐋

---

## 🔍 Vérifier les images téléchargées

```powershell
# Lister les images
docker images | findstr wordsmith

# Vous devriez voir :
# votre-username/wordsmith-db      latest   xxx   231 MB
# votre-username/wordsmith-words   latest   xxx   62 MB
# votre-username/wordsmith-web     latest   xxx   12 MB
```

**Note :** Les images viennent de Docker Hub, pas de votre PC !

---

## 📊 Comparaison Build local vs Docker Hub

### Build local (docker-compose.yml)

```yaml
# Construit l'image localement
db:
  build: ./db
  image: wordsmith-db
```

**Avantages :**
- ✅ Contrôle total
- ✅ Modifications rapides

**Inconvénients :**
- ❌ Besoin de construire (lent)
- ❌ Chaque personne doit builder

### Docker Hub (docker-compose.hub.yml)

```yaml
# Télécharge depuis Docker Hub
db:
  image: votre-username/wordsmith-db:latest
```

**Avantages :**
- ✅ Pas besoin de builder
- ✅ Téléchargement rapide
- ✅ Tout le monde utilise la même version
- ✅ CI/CD automatique

**Inconvénients :**
- ❌ Dépend de Docker Hub

---

## 🧹 Nettoyage

```powershell
# Arrêter et supprimer les conteneurs
docker compose -f docker-compose.hub.yml down

# Supprimer aussi les volumes
docker compose -f docker-compose.hub.yml down -v

# Supprimer les images téléchargées (optionnel)
docker rmi votre-username/wordsmith-db:latest
docker rmi votre-username/wordsmith-words:latest
docker rmi votre-username/wordsmith-web:latest
```

---

## ✅ Validation finale

Si tous les tests passent :

- ✅ GitHub Actions fonctionne
- ✅ Images publiées sur Docker Hub
- ✅ Images téléchargeables par tout le monde
- ✅ Application fonctionne avec les images du Hub
- ✅ **TP COMPLÉTÉ AVEC SUCCÈS !** 🎉

---

## 📝 Résumé du flux complet

```
1. Vous codez les Dockerfiles
   ↓
2. git add . && git commit && git push
   ↓
3. GitHub Actions se déclenche
   ↓
4. Build des 3 images (parallèle)
   ↓
5. Push vers Docker Hub
   ↓
6. Vous (ou quelqu'un d'autre) téléchargez depuis Docker Hub
   ↓
7. docker compose -f docker-compose.hub.yml up -d
   ↓
8. Application fonctionne ! ✅
```

**C'est exactement comme les vraies entreprises font du DevOps ! 🚀**

---

## 🎓 Ce que vous avez appris

- ✅ GitHub Actions (CI/CD)
- ✅ Secrets GitHub
- ✅ Docker Hub (registry)
- ✅ Multi-tags Docker
- ✅ Workflow automatisé
- ✅ Build parallèle

**Félicitations ! Vous maîtrisez maintenant un workflow DevOps complet ! 🎊**

