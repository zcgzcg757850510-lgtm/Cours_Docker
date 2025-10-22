# 🚀 COMMENCER L'ÉTAPE 2 - Par ici !

## 👋 Bienvenue dans l'étape 2 : CI/CD

Vous allez configurer un **pipeline DevOps automatisé** avec GitHub Actions et Docker Hub.

---

## 📁 Nouveaux fichiers créés pour vous aider

J'ai créé **4 guides** pour vous accompagner :

| Fichier | Description | Quand l'utiliser |
|---------|-------------|------------------|
| 🎯 **ETAPE_2_RESUME.md** | Résumé rapide + checklist | Pour avoir une vue d'ensemble |
| 📚 **GUIDE_ETAPE_2_CICD.md** | Guide détaillé complet (10 étapes) | Pour suivre pas à pas |
| 📋 **COMMANDES_ETAPE_2.md** | Toutes les commandes dans des tableaux | Pour référence rapide |
| 🤖 **setup-cicd.ps1** | Script PowerShell automatique | Pour automatiser la config |

---

## ⚡ DÉMARRAGE RAPIDE

### **Étape 1 : Lancer le script d'aide** (2 minutes)

Ouvrez PowerShell et tapez :

```powershell
cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2
.\setup-cicd.ps1
```

**Le script va :**
- ✅ Vérifier que Docker et Git sont installés
- ✅ Vérifier que tous les fichiers sont présents
- ✅ Vous demander votre username Docker Hub
- ✅ Configurer `docker-compose.hub.yml` automatiquement
- ✅ Préparer Git
- ✅ Vous donner les prochaines étapes

---

### **Étape 2 : Suivre les instructions du script**

Le script vous dira exactement quoi faire ensuite :

1. ✅ Créer compte Docker Hub
2. ✅ Générer token Docker Hub
3. ✅ Configurer secrets GitHub
4. ✅ Pousser le code
5. ✅ Vérifier que ça marche

---

## 📖 Si vous préférez un guide détaillé

**Ouvrez : `GUIDE_ETAPE_2_CICD.md`**

Ce guide contient **10 étapes détaillées** avec :
- Captures d'écran textuelles
- Explications pour chaque action
- Solutions aux problèmes courants

---

## 📋 Si vous préférez juste les commandes

**Ouvrez : `COMMANDES_ETAPE_2.md`**

Ce fichier contient **tous les tableaux de commandes** :
- Commandes PowerShell
- Actions navigateur web
- Commandes Git
- Dépannage

---

## ✅ Checklist rapide

Avant de commencer, assurez-vous d'avoir :

- [ ] Docker Desktop installé et **démarré** ✅
- [ ] Git installé
- [ ] Connexion Internet
- [ ] Compte GitHub (gratuit)
- [ ] 30 minutes devant vous

---

## 🎯 Ce que vous allez accomplir

À la fin de cette étape, vous aurez :

```
✅ Un compte Docker Hub
✅ Un workflow CI/CD fonctionnel
✅ 3 images Docker publiées automatiquement
✅ N'importe qui peut utiliser vos images !
```

**Chaque fois que vous ferez `git push` :**
- GitHub Actions construira automatiquement vos images
- Les publiera sur Docker Hub
- Tout le monde pourra les télécharger !

---

## 🚀 Par où commencer ?

### **Option 1 : Rapide (recommandé)**

```powershell
.\setup-cicd.ps1
```

Puis suivez les instructions à l'écran.

### **Option 2 : Guide détaillé**

Ouvrez `GUIDE_ETAPE_2_CICD.md` et suivez les 10 étapes.

### **Option 3 : Résumé visuel**

Ouvrez `ETAPE_2_RESUME.md` pour la checklist.

---

## ⏱️ Temps estimé

- **Configuration** : 15 minutes
- **Premier build** : 5 minutes (automatique)
- **Test** : 5 minutes

**TOTAL : ~25 minutes**

---

## 🆘 Besoin d'aide ?

| Problème | Solution |
|----------|----------|
| Je ne sais pas par où commencer | Lancez `.\setup-cicd.ps1` |
| J'ai une erreur Git | Consultez `COMMANDES_ETAPE_2.md` → Partie I (Dépannage) |
| Le workflow GitHub Actions échoue | Lisez `GUIDE_ETAPE_2_CICD.md` → Section Troubleshooting |
| Je veux juste les commandes | Ouvrez `COMMANDES_ETAPE_2.md` |

---

## 📊 Schéma visuel du processus

```
VOUS
 │
 ├─ Étape 1 : Créer compte Docker Hub
 │   └─→ https://hub.docker.com/
 │
 ├─ Étape 2 : Générer token
 │   └─→ Settings → Security → Token
 │
 ├─ Étape 3 : Configurer GitHub
 │   └─→ Repository → Settings → Secrets
 │
 ├─ Étape 4 : git push
 │
 └─→ MAGIE OPÈRE ! ✨
      │
      ├─ GitHub Actions build
      │   ├─ Image db
      │   ├─ Image words
      │   └─ Image web
      │
      └─ Push vers Docker Hub
          └─→ Images disponibles pour tous ! 🌍
```

---

## 🎓 Ce que vous apprendrez

- ✅ **CI/CD** (Continuous Integration / Continuous Deployment)
- ✅ **GitHub Actions** (automatisation)
- ✅ **Docker Hub** (registry public)
- ✅ **Secrets management** (sécurité)
- ✅ **Workflow DevOps** (comme les pros)

---

## 🎉 Prêt ?

### **Commencez maintenant !**

```powershell
cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2
.\setup-cicd.ps1
```

**Bonne chance ! 🚀**

---

## 📚 Fichiers disponibles

| Fichier | Usage |
|---------|-------|
| `COMMENCER_ETAPE_2.md` | ⭐ Ce fichier (point d'entrée) |
| `setup-cicd.ps1` | Script automatique |
| `ETAPE_2_RESUME.md` | Résumé + checklist |
| `GUIDE_ETAPE_2_CICD.md` | Guide détaillé complet |
| `COMMANDES_ETAPE_2.md` | Référence des commandes |

**Tout est prêt pour vous ! Il ne reste plus qu'à commencer ! 🎯**

