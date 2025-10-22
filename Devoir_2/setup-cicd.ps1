# ══════════════════════════════════════════════════════════════════════════════
# SCRIPT POWERSHELL - AIDE À LA CONFIGURATION CI/CD
# ══════════════════════════════════════════════════════════════════════════════
# Ce script vous aide à configurer le projet pour GitHub Actions
# ══════════════════════════════════════════════════════════════════════════════

Write-Host "🚀 Assistant de configuration CI/CD - Projet Wordsmith" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# ──────────────────────────────────────────────────────────────────────────────
# ÉTAPE 1 : Vérifier Docker
# ──────────────────────────────────────────────────────────────────────────────
Write-Host "📋 Étape 1 : Vérification de Docker..." -ForegroundColor Yellow

try {
    $dockerVersion = docker --version
    Write-Host "   ✅ Docker installé : $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Docker n'est pas installé ou pas démarré !" -ForegroundColor Red
    Write-Host "   → Veuillez lancer Docker Desktop" -ForegroundColor Red
    exit 1
}

Write-Host ""

# ──────────────────────────────────────────────────────────────────────────────
# ÉTAPE 2 : Vérifier Git
# ──────────────────────────────────────────────────────────────────────────────
Write-Host "📋 Étape 2 : Vérification de Git..." -ForegroundColor Yellow

try {
    $gitVersion = git --version
    Write-Host "   ✅ Git installé : $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Git n'est pas installé !" -ForegroundColor Red
    Write-Host "   → Téléchargez Git depuis : https://git-scm.com/" -ForegroundColor Red
    exit 1
}

Write-Host ""

# ──────────────────────────────────────────────────────────────────────────────
# ÉTAPE 3 : Vérifier les fichiers nécessaires
# ──────────────────────────────────────────────────────────────────────────────
Write-Host "📋 Étape 3 : Vérification des fichiers..." -ForegroundColor Yellow

$requiredFiles = @(
    "docker-compose.yml",
    "docker-compose.hub.yml",
    ".github/workflows/build-wordsmith.yml",
    "db/Dockerfile",
    "words/Dockerfile",
    "web/Dockerfile"
)

$allFilesExist = $true
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "   ✅ $file" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $file MANQUANT !" -ForegroundColor Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    Write-Host ""
    Write-Host "❌ Certains fichiers sont manquants !" -ForegroundColor Red
    exit 1
}

Write-Host ""

# ──────────────────────────────────────────────────────────────────────────────
# ÉTAPE 4 : Configuration du username Docker Hub
# ──────────────────────────────────────────────────────────────────────────────
Write-Host "📋 Étape 4 : Configuration du username Docker Hub..." -ForegroundColor Yellow
Write-Host ""

Write-Host "   ⚠️  Avant de continuer, assurez-vous d'avoir :" -ForegroundColor Yellow
Write-Host "   1. Créé un compte Docker Hub (https://hub.docker.com/)" -ForegroundColor White
Write-Host "   2. Noté votre nom d'utilisateur Docker Hub" -ForegroundColor White
Write-Host ""

$dockerUsername = Read-Host "   Entrez votre nom d'utilisateur Docker Hub"

if ([string]::IsNullOrWhiteSpace($dockerUsername)) {
    Write-Host ""
    Write-Host "❌ Nom d'utilisateur vide ! Opération annulée." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "   📝 Mise à jour de docker-compose.hub.yml..." -ForegroundColor Yellow

try {
    (Get-Content docker-compose.hub.yml) -replace 'votre-username', $dockerUsername | Set-Content docker-compose.hub.yml
    Write-Host "   ✅ docker-compose.hub.yml mis à jour avec le username : $dockerUsername" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Erreur lors de la mise à jour du fichier !" -ForegroundColor Red
    exit 1
}

Write-Host ""

# ──────────────────────────────────────────────────────────────────────────────
# ÉTAPE 5 : Initialiser Git si nécessaire
# ──────────────────────────────────────────────────────────────────────────────
Write-Host "📋 Étape 5 : Configuration Git..." -ForegroundColor Yellow

$gitStatus = git status 2>&1

if ($gitStatus -match "not a git repository") {
    Write-Host "   📝 Initialisation du repository Git..." -ForegroundColor Yellow
    git init
    Write-Host "   ✅ Git initialisé" -ForegroundColor Green
} else {
    Write-Host "   ✅ Repository Git déjà initialisé" -ForegroundColor Green
}

Write-Host ""

# ──────────────────────────────────────────────────────────────────────────────
# ÉTAPE 6 : Ajouter les fichiers
# ──────────────────────────────────────────────────────────────────────────────
Write-Host "📋 Étape 6 : Ajout des fichiers au commit..." -ForegroundColor Yellow

git add .

$filesAdded = git status --short | Measure-Object | Select-Object -ExpandProperty Count

Write-Host "   ✅ $filesAdded fichier(s) ajouté(s)" -ForegroundColor Green
Write-Host ""

# ──────────────────────────────────────────────────────────────────────────────
# RÉSUMÉ
# ──────────────────────────────────────────────────────────────────────────────
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "✅ Configuration terminée !" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

Write-Host "📝 Prochaines étapes MANUELLES :" -ForegroundColor Yellow
Write-Host ""
Write-Host "1️⃣  Créer un token Docker Hub :" -ForegroundColor White
Write-Host "   → Allez sur : https://hub.docker.com/" -ForegroundColor Cyan
Write-Host "   → Account Settings → Security → Personal Access Tokens" -ForegroundColor Cyan
Write-Host "   → New Access Token → Permissions : Read, Write, Delete" -ForegroundColor Cyan
Write-Host "   → Copiez le token (commence par dckr_pat_...)" -ForegroundColor Cyan
Write-Host ""

Write-Host "2️⃣  Configurer les secrets GitHub :" -ForegroundColor White
Write-Host "   → Allez sur votre repository GitHub" -ForegroundColor Cyan
Write-Host "   → Settings → Secrets and variables → Actions" -ForegroundColor Cyan
Write-Host "   → Créez 2 secrets :" -ForegroundColor Cyan
Write-Host "      - DOCKER_USERNAME : $dockerUsername" -ForegroundColor Yellow
Write-Host "      - DOCKER_PASSWORD : (votre token Docker Hub)" -ForegroundColor Yellow
Write-Host ""

Write-Host "3️⃣  Configurer le repository GitHub :" -ForegroundColor White
Write-Host "   Si vous n'avez pas encore de repository GitHub, créez-en un." -ForegroundColor Cyan
Write-Host "   Puis tapez ces commandes :" -ForegroundColor Cyan
Write-Host ""
Write-Host "   git remote add origin https://github.com/VOTRE_USERNAME/VOTRE_REPO.git" -ForegroundColor Yellow
Write-Host "   # OU si origin existe déjà :" -ForegroundColor Gray
Write-Host "   git remote set-url origin https://github.com/VOTRE_USERNAME/VOTRE_REPO.git" -ForegroundColor Yellow
Write-Host ""

Write-Host "4️⃣  Faire le premier commit et push :" -ForegroundColor White
Write-Host ""
Write-Host "   git commit -m `"Initial commit: Dockerfiles, Compose, and CI/CD workflow`"" -ForegroundColor Yellow
Write-Host "   git branch -M main" -ForegroundColor Yellow
Write-Host "   git push -u origin main" -ForegroundColor Yellow
Write-Host ""

Write-Host "5️⃣  Vérifier GitHub Actions :" -ForegroundColor White
Write-Host "   → Allez sur GitHub → Onglet Actions" -ForegroundColor Cyan
Write-Host "   → Vous verrez le workflow 'Build Wordsmith Images' en cours" -ForegroundColor Cyan
Write-Host "   → Attendez qu'il soit vert ✅ (environ 5 minutes)" -ForegroundColor Cyan
Write-Host ""

Write-Host "6️⃣  Tester avec les images Docker Hub :" -ForegroundColor White
Write-Host ""
Write-Host "   docker compose -f docker-compose.hub.yml up -d" -ForegroundColor Yellow
Write-Host "   Start-Sleep -Seconds 25" -ForegroundColor Yellow
Write-Host "   # Puis ouvrir : http://localhost" -ForegroundColor Gray
Write-Host ""

Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "📖 Pour plus de détails, lisez : GUIDE_ETAPE_2_CICD.md" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

Write-Host "Bonne chance ! 🚀" -ForegroundColor Green

