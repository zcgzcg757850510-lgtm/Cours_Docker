# 🔐 GUIDE DÉTAILLÉ - Configurer les secrets GitHub

## 🎯 Objectif

Ajouter vos identifiants Docker Hub dans GitHub de manière **sécurisée** pour que GitHub Actions puisse publier vos images.

---

## ⏱️ Temps estimé : 5 minutes

---

## 📋 Prérequis

Avant de commencer, vous devez avoir :

- ✅ Un compte GitHub
- ✅ Un repository GitHub (créé ou existant)
- ✅ Votre **nom d'utilisateur Docker Hub**
- ✅ Votre **token Docker Hub** (commence par `dckr_pat_...`)

---

## 🚀 ÉTAPE PAR ÉTAPE

### **Étape 1 : Aller sur votre repository GitHub** 🌐

1. **Ouvrez votre navigateur web**
2. **Allez sur** : https://github.com/
3. **Connectez-vous** à votre compte GitHub
4. **Cliquez** sur votre repository (exemple : `wordsmith-cicd`)

**URL exemple :** `https://github.com/votre-username/wordsmith-cicd`

---

### **Étape 2 : Ouvrir les paramètres du repository** ⚙️

1. **Vous êtes sur la page de votre repository**
2. **Regardez la barre de navigation** en haut :
   ```
   < > Code    Issues    Pull requests    Actions    Projects    Wiki    Settings
                                                                            ^^^^^^^^
   ```
3. **Cliquez** sur **"Settings"** (tout à droite)

⚠️ **ATTENTION :** Si vous ne voyez pas "Settings", c'est que :
   - Vous n'êtes pas propriétaire du repository
   - Ou vous n'avez pas les permissions d'administration

---

### **Étape 3 : Naviguer vers les Secrets** 🔑

1. **Vous êtes maintenant dans Settings**
2. **Regardez le menu de gauche**
3. **Cherchez** la section **"Secrets and variables"**
4. **Cliquez** sur **"Secrets and variables"** pour l'ouvrir
5. **Cliquez** sur **"Actions"**

**Chemin complet :** Settings → Secrets and variables → Actions

**Vous devriez voir :**
```
┌─────────────────────────────────────────────┐
│ Actions secrets and variables               │
│                                             │
│ Secrets  Environnement variables           │
│ ───────  ────────────────────────          │
│                                             │
│ [New repository secret]                     │
│                                             │
│ No secrets yet                              │
└─────────────────────────────────────────────┘
```

---

### **Étape 4 : Créer le premier secret (DOCKER_USERNAME)** 👤

1. **Cliquez** sur le bouton vert **"New repository secret"**

2. **Vous voyez un formulaire :**
   ```
   ┌─────────────────────────────────────────┐
   │ Actions secrets / New secret            │
   ├─────────────────────────────────────────┤
   │                                         │
   │ Name *                                  │
   │ ┌─────────────────────────────────────┐ │
   │ │ DOCKER_USERNAME                     │ │
   │ └─────────────────────────────────────┘ │
   │                                         │
   │ Secret *                                │
   │ ┌─────────────────────────────────────┐ │
   │ │                                     │ │
   │ └─────────────────────────────────────┘ │
   │                                         │
   │ [Add secret]                            │
   └─────────────────────────────────────────┘
   ```

3. **Dans le champ "Name"**, tapez exactement (MAJUSCULES) :
   ```
   DOCKER_USERNAME
   ```

4. **Dans le champ "Secret"**, tapez votre nom d'utilisateur Docker Hub
   
   **Exemple :** Si votre username Docker Hub est `tudou123`, tapez :
   ```
   tudou123
   ```

   ⚠️ **IMPORTANT :** 
   - Tapez votre **USERNAME** (pas votre email)
   - Respectez les minuscules/majuscules exactement comme sur Docker Hub

5. **Cliquez** sur **"Add secret"** (bouton vert en bas)

**✅ Résultat :** Vous revenez à la liste des secrets et vous voyez :
```
┌─────────────────────────────────────────────┐
│ Repository secrets                          │
│                                             │
│ DOCKER_USERNAME          Updated now        │
└─────────────────────────────────────────────┘
```

---

### **Étape 5 : Créer le deuxième secret (DOCKER_PASSWORD)** 🔑

1. **Cliquez** de nouveau sur **"New repository secret"**

2. **Dans le champ "Name"**, tapez exactement (MAJUSCULES) :
   ```
   DOCKER_PASSWORD
   ```

3. **Dans le champ "Secret"**, collez votre **token Docker Hub**
   
   **Le token ressemble à :**
   ```
   dckr_pat_A1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6
   ```

   ⚠️ **TRÈS IMPORTANT :** 
   - Utilisez le **TOKEN** (commence par `dckr_pat_...`)
   - **PAS votre mot de passe Docker Hub !**
   - Le token a été généré dans Docker Hub → Settings → Security

4. **Cliquez** sur **"Add secret"**

**✅ Résultat :** Vous voyez maintenant **2 secrets** :
```
┌─────────────────────────────────────────────┐
│ Repository secrets                          │
│                                             │
│ DOCKER_PASSWORD          Updated now        │
│ DOCKER_USERNAME          Updated 1 min ago  │
└─────────────────────────────────────────────┘
```

---

## ✅ VÉRIFICATION

Vous devez voir **exactement 2 secrets** avec ces noms (MAJUSCULES) :

| Nom du secret | Contenu | Exemple |
|---------------|---------|---------|
| `DOCKER_USERNAME` | Votre nom d'utilisateur Docker Hub | `tudou123` |
| `DOCKER_PASSWORD` | Votre token Docker Hub | `dckr_pat_abc123...` |

⚠️ **Les noms doivent être EXACTEMENT comme indiqué (en MAJUSCULES)**

---

## 🔍 Comment vérifier que c'est correct ?

1. **Vous devez voir 2 secrets** dans la liste
2. **Les noms** doivent être exactement : `DOCKER_USERNAME` et `DOCKER_PASSWORD`
3. **Vous ne pouvez PAS voir les valeurs** (c'est normal, c'est pour la sécurité)
4. Si vous cliquez sur un secret, vous pouvez le **supprimer** ou le **modifier**

---

## 🔒 Pourquoi des "secrets" ?

Les secrets GitHub sont :

- ✅ **Chiffrés** : Personne ne peut les voir (même pas vous après création)
- ✅ **Sécurisés** : Ne sont jamais affichés dans les logs
- ✅ **Accessibles** : GitHub Actions peut les utiliser pendant le build
- ✅ **Pratiques** : Pas besoin de les mettre dans le code

**C'est comme un coffre-fort numérique ! 🔐**

---

## 📊 Schéma visuel

```
┌─────────────────────────────────────────────────────────┐
│  GitHub Repository                                      │
│  ├─ Code                                                │
│  ├─ Issues                                              │
│  ├─ Actions                                             │
│  └─ Settings ← VOUS ÊTES ICI                           │
│      └─ Secrets and variables                           │
│          └─ Actions                                     │
│              ├─ DOCKER_USERNAME = tudou123              │
│              └─ DOCKER_PASSWORD = dckr_pat_abc123...    │
└─────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│  GitHub Actions Workflow                                │
│  (.github/workflows/build-wordsmith.yml)                │
│                                                         │
│  - name: Login to Docker Hub                            │
│    with:                                                │
│      username: ${{ secrets.DOCKER_USERNAME }}           │
│      password: ${{ secrets.DOCKER_PASSWORD }}           │
└─────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│  Docker Hub                                             │
│  ├─ Connexion réussie ✅                                │
│  └─ Push des images autorisé                            │
└─────────────────────────────────────────────────────────┘
```

---

## ❓ Questions fréquentes

### **Q1 : Je ne vois pas "Settings" dans mon repository**

**R :** Vous n'avez pas les droits d'administration. Solutions :
- Si c'est votre repository : vous devriez le voir
- Si c'est le repository de quelqu'un d'autre : demandez les droits
- Créez votre propre repository

---

### **Q2 : J'ai fait une erreur dans un secret, comment le modifier ?**

**R :** 
1. Allez dans Settings → Secrets and variables → Actions
2. Cliquez sur le nom du secret
3. Cliquez sur "Update secret"
4. Entrez la nouvelle valeur
5. Cliquez sur "Update secret"

---

### **Q3 : J'ai utilisé mon mot de passe au lieu du token**

**R :** ❌ Cela ne fonctionnera PAS !
1. Allez sur Docker Hub
2. Settings → Security → Personal Access Tokens
3. Générez un nouveau token (permissions : Read, Write, Delete)
4. Copiez le token
5. Modifiez le secret `DOCKER_PASSWORD` dans GitHub avec le token

---

### **Q4 : Puis-je voir la valeur d'un secret après l'avoir créé ?**

**R :** ❌ Non, c'est impossible (sécurité). Si vous l'avez oublié :
- Pour DOCKER_USERNAME : c'est visible sur Docker Hub
- Pour DOCKER_PASSWORD : générez un nouveau token

---

### **Q5 : Les secrets sont-ils visibles dans les logs ?**

**R :** ✅ Non ! GitHub masque automatiquement les secrets dans les logs avec `***`

---

### **Q6 : Faut-il mettre les secrets dans le code ?**

**R :** ❌ JAMAIS ! C'est dangereux et inutile. Utilisez toujours les secrets GitHub.

---

## 🧪 Test rapide

Pour vérifier que vos secrets fonctionnent :

1. **Faites un commit et push** (n'importe quel changement)
   ```powershell
   git add .
   git commit -m "Test secrets"
   git push
   ```

2. **Allez sur GitHub → Actions**

3. **Regardez le workflow s'exécuter**

4. **Si vous voyez ✅ pour "Login to Docker Hub"** → Secrets OK !

5. **Si vous voyez ❌** → Vérifiez vos secrets

---

## 🎯 Prochaine étape

Une fois les secrets configurés :

1. **Pousser votre code** sur GitHub :
   ```powershell
   git add .
   git commit -m "Add CI/CD workflow"
   git push origin main
   ```

2. **Aller sur GitHub → Actions** pour voir le build

3. **Attendre ~5 minutes** que les images soient construites

4. **Vérifier sur Docker Hub** que les images sont publiées

---

## ✅ Checklist finale

Avant de continuer, vérifiez :

- [ ] J'ai créé le secret `DOCKER_USERNAME`
- [ ] J'ai créé le secret `DOCKER_PASSWORD`
- [ ] Les noms sont en MAJUSCULES
- [ ] J'ai utilisé mon TOKEN (pas mon mot de passe)
- [ ] Je vois 2 secrets dans la liste

**Si tout est coché → C'est parfait ! Passez à l'étape suivante ! ✅**

---

## 🆘 Aide visuelle - Capture d'écran textuelle

```
┌───────────────────────────────────────────────────────────┐
│ GitHub.com                                                │
├───────────────────────────────────────────────────────────┤
│ votre-username / wordsmith-cicd                           │
│                                                           │
│ < > Code  Issues  Pull requests  Actions  Settings       │
│                                            ^^^^^^^^       │
│ ┌─────────────────────────────────────────────────────┐  │
│ │ Settings                                            │  │
│ │                                                     │  │
│ │ ◀ Secrets and variables                            │  │
│ │    ├─ Actions ← CLIQUEZ ICI                        │  │
│ │    ├─ Codespaces                                   │  │
│ │    └─ Dependabot                                   │  │
│ │                                                     │  │
│ │ Repository secrets                                 │  │
│ │ ┌───────────────────────────────────────────────┐  │  │
│ │ │ [New repository secret]                       │  │  │
│ │ ├───────────────────────────────────────────────┤  │  │
│ │ │ DOCKER_PASSWORD          Updated now          │  │  │
│ │ │ DOCKER_USERNAME          Updated 1 min ago    │  │  │
│ │ └───────────────────────────────────────────────┘  │  │
│ └─────────────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────────────┘
```

---

## 🎉 Félicitations !

Vos secrets sont configurés ! GitHub Actions peut maintenant :
- ✅ Se connecter à Docker Hub
- ✅ Construire vos images
- ✅ Les publier automatiquement

**Prochaine étape : `git push` pour déclencher le workflow ! 🚀**

