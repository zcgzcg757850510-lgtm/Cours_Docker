# ⚡ RÉSUMÉ RAPIDE - Étape 2 : CI/CD

## 🎯 Objectif

Configurer GitHub Actions pour publier automatiquement vos images Docker sur Docker Hub.

---

## 📋 Checklist (10 étapes)

### 🔧 Configuration (une seule fois)

- [ ] **1.** Créer compte Docker Hub → https://hub.docker.com/
- [ ] **2.** Générer token Docker Hub (Settings → Security → Personal Access Tokens)
- [ ] **3.** Créer repository GitHub (ou utiliser existant)
- [ ] **4.** Ajouter secrets GitHub :
  - `DOCKER_USERNAME` = votre username Docker Hub
  - `DOCKER_PASSWORD` = votre token Docker Hub
- [ ] **5.** Lancer le script d'aide : `.\setup-cicd.ps1`

### 🚀 Premier déploiement

- [ ] **6.** Pousser le code sur GitHub :
  ```powershell
  git add .
  git commit -m "Add CI/CD workflow"
  git push origin main
  ```
- [ ] **7.** Vérifier GitHub Actions (onglet "Actions" sur GitHub)
- [ ] **8.** Vérifier Docker Hub (3 images publiées)

### ✅ Test final

- [ ] **9.** Modifier `docker-compose.hub.yml` avec votre username
- [ ] **10.** Tester :
  ```powershell
  docker compose -f docker-compose.hub.yml up -d
  Start-Sleep -Seconds 25
  # Ouvrir http://localhost
  docker compose -f docker-compose.hub.yml down
  ```

---

## 🚀 Commande rapide pour démarrer

```powershell
# Aller dans le dossier
cd C:\Users\tudou\Desktop\Develop\Devoir\Devoir_2

# Lancer le script d'aide
.\setup-cicd.ps1
```

Le script va :
- ✅ Vérifier Docker et Git
- ✅ Vérifier tous les fichiers
- ✅ Configurer votre username Docker Hub
- ✅ Préparer Git
- ✅ Vous donner les prochaines étapes

---

## 📊 Flux complet

```
┌────────────────────────────────────┐
│  1. Vous créez compte Docker Hub   │
│  2. Vous générez un token          │
└──────────────┬─────────────────────┘
               │
               ▼
┌────────────────────────────────────┐
│  3. Vous configurez secrets GitHub │
│     - DOCKER_USERNAME              │
│     - DOCKER_PASSWORD              │
└──────────────┬─────────────────────┘
               │
               ▼
┌────────────────────────────────────┐
│  4. Vous faites : git push         │
└──────────────┬─────────────────────┘
               │
               ▼
┌────────────────────────────────────┐
│  GitHub Actions AUTOMATIQUE :      │
│  ├─ Build image db                 │
│  ├─ Build image words              │
│  ├─ Build image web                │
│  └─ Push vers Docker Hub           │
└──────────────┬─────────────────────┘
               │
               ▼
┌────────────────────────────────────┐
│  5. Images disponibles sur         │
│     Docker Hub (publiques !)       │
└────────────────────────────────────┘
```

---

## 🔑 Informations importantes

### Secrets GitHub (à créer dans Settings → Secrets)

| Nom | Valeur | Exemple |
|-----|--------|---------|
| `DOCKER_USERNAME` | Votre nom d'utilisateur Docker Hub | `tudou123` |
| `DOCKER_PASSWORD` | Votre token Docker Hub | `dckr_pat_abc123...` |

⚠️ **ATTENTION** : Utilisez le **TOKEN**, pas votre mot de passe !

### Tags créés automatiquement

Chaque image aura 3 tags :

| Tag | Description | Exemple |
|-----|-------------|---------|
| `latest` | Dernière version | `tudou123/wordsmith-web:latest` |
| `<commit-sha>` | SHA du commit Git | `tudou123/wordsmith-web:abc1234` |
| `v1.0` | Version sémantique | `tudou123/wordsmith-web:v1.0` |

---

## 📚 Fichiers à consulter

| Fichier | Description |
|---------|-------------|
| `GUIDE_ETAPE_2_CICD.md` | Guide détaillé complet (10 étapes) |
| `setup-cicd.ps1` | Script PowerShell d'aide |
| `ETAPE_2_RESUME.md` | Ce fichier (résumé rapide) |
| `.github/workflows/build-wordsmith.yml` | Workflow GitHub Actions |

---

## ❓ Questions fréquentes

### Le workflow ne se déclenche pas ?

**Vérifiez** que vous avez poussé sur la branche `main` ou `master`.

### Erreur "Cannot perform an interactive login" ?

**Vérifiez** que les secrets sont bien configurés (nom exact).

### Images ne sont pas sur Docker Hub ?

**Vérifiez** que le token a les permissions "Read, Write, Delete".

### Comment voir les logs du workflow ?

GitHub → Onglet "Actions" → Cliquez sur le workflow → Cliquez sur un job.

---

## ⏱️ Temps estimé total

- Configuration : **15 minutes**
- Premier push + build : **5 minutes**
- Test : **5 minutes**

**TOTAL : ~25 minutes**

---

## 🎉 Une fois terminé

À partir de maintenant, **chaque `git push` déclenchera automatiquement** :

1. Build des 3 images
2. Push vers Docker Hub
3. Images disponibles pour tous

**C'est du vrai DevOps ! 🚀**

---

## 🆘 Besoin d'aide ?

Lisez le guide complet : **GUIDE_ETAPE_2_CICD.md**

