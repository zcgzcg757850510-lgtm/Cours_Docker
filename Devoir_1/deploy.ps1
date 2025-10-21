# Script PowerShell pour déployer Wordsmith facilement
# Usage: .\deploy.ps1 [option]
# Options: build, start, stop, restart, logs, clean, test, dev

param(
    [Parameter(Position=0)]
    [string]$Action = "start"
)

$ProjectName = "wordsmith"
$ScriptDir = $PSScriptRoot

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Wordsmith Deployment Script" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Fonction pour afficher les logs colorés
function Write-Step {
    param([string]$Message)
    Write-Host "[*] $Message" -ForegroundColor Green
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "[!] $Message" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "[i] $Message" -ForegroundColor Yellow
}

# Vérifier que Docker est installé
function Check-Docker {
    Write-Step "Vérification de Docker..."
    try {
        $dockerVersion = docker --version
        Write-Host "    $dockerVersion" -ForegroundColor Gray
        
        $composeVersion = docker compose version
        Write-Host "    $composeVersion" -ForegroundColor Gray
        return $true
    }
    catch {
        Write-Error-Custom "Docker n'est pas installé ou n'est pas démarré !"
        Write-Info "Veuillez installer Docker Desktop : https://www.docker.com/products/docker-desktop"
        return $false
    }
}

# Construire les images
function Build-Images {
    Write-Step "Construction des images Docker..."
    Set-Location $ScriptDir
    docker compose build
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Step "Images construites avec succès !"
        Write-Host ""
        Write-Info "Tailles des images :"
        docker images | Select-String "wordsmith"
    }
    else {
        Write-Error-Custom "Erreur lors de la construction des images"
        exit 1
    }
}

# Démarrer l'application
function Start-App {
    Write-Step "Démarrage de l'application..."
    Set-Location $ScriptDir
    docker compose up -d
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Step "Application démarrée avec succès !"
        Write-Host ""
        Start-Sleep -Seconds 3
        docker compose ps
        Write-Host ""
        Write-Info "L'application sera bientôt accessible sur : http://localhost"
        Write-Info "Patientez 10-15 secondes pour que tous les services soient prêts..."
    }
    else {
        Write-Error-Custom "Erreur lors du démarrage"
        exit 1
    }
}

# Démarrer en mode développement
function Start-Dev {
    Write-Step "Démarrage en mode développement..."
    Set-Location $ScriptDir
    docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Step "Application démarrée en mode développement !"
        Write-Host ""
        Write-Info "Vous pouvez maintenant modifier les fichiers dans web/static/"
        Write-Info "Les changements seront visibles immédiatement !"
        Write-Host ""
        docker compose ps
    }
}

# Arrêter l'application
function Stop-App {
    Write-Step "Arrêt de l'application..."
    Set-Location $ScriptDir
    docker compose down
    
    if ($LASTEXITCODE -eq 0) {
        Write-Step "Application arrêtée avec succès !"
    }
}

# Redémarrer l'application
function Restart-App {
    Write-Step "Redémarrage de l'application..."
    Stop-App
    Start-Sleep -Seconds 2
    Start-App
}

# Afficher les logs
function Show-Logs {
    Write-Step "Affichage des logs (Ctrl+C pour quitter)..."
    Set-Location $ScriptDir
    docker compose logs -f
}

# Nettoyer tout
function Clean-All {
    Write-Step "Nettoyage complet..."
    Set-Location $ScriptDir
    
    Write-Info "Arrêt des conteneurs..."
    docker compose down -v
    
    Write-Info "Suppression des images..."
    docker rmi wordsmith-web wordsmith-words wordsmith-db -f 2>$null
    
    Write-Info "Nettoyage des volumes orphelins..."
    docker volume prune -f
    
    Write-Info "Nettoyage des réseaux..."
    docker network prune -f
    
    Write-Step "Nettoyage terminé !"
}

# Tester l'application
function Test-App {
    Write-Step "Test de l'application..."
    
    Write-Info "Vérification des conteneurs..."
    docker compose ps
    
    Write-Host ""
    Write-Info "Test de l'API..."
    
    try {
        Write-Host "  - Test /words/noun..." -ForegroundColor Gray
        $noun = Invoke-WebRequest -Uri "http://localhost/words/noun" -UseBasicParsing
        Write-Host "    Réponse: $($noun.Content)" -ForegroundColor Gray
        
        Write-Host "  - Test /words/verb..." -ForegroundColor Gray
        $verb = Invoke-WebRequest -Uri "http://localhost/words/verb" -UseBasicParsing
        Write-Host "    Réponse: $($verb.Content)" -ForegroundColor Gray
        
        Write-Host "  - Test /words/adjective..." -ForegroundColor Gray
        $adj = Invoke-WebRequest -Uri "http://localhost/words/adjective" -UseBasicParsing
        Write-Host "    Réponse: $($adj.Content)" -ForegroundColor Gray
        
        Write-Host ""
        Write-Step "Tous les tests passent ! ✓"
        Write-Info "Ouvrez http://localhost dans votre navigateur"
    }
    catch {
        Write-Error-Custom "L'application ne répond pas encore"
        Write-Info "Attendez quelques secondes et réessayez"
        Write-Info "Ou vérifiez les logs avec: .\deploy.ps1 logs"
    }
}

# Afficher l'aide
function Show-Help {
    Write-Host @"
Usage: .\deploy.ps1 [action]

Actions disponibles:
  build      - Construire les images Docker
  start      - Démarrer l'application (par défaut)
  dev        - Démarrer en mode développement
  stop       - Arrêter l'application
  restart    - Redémarrer l'application
  logs       - Afficher les logs
  test       - Tester l'application
  clean      - Nettoyer tout (conteneurs, images, volumes)
  help       - Afficher cette aide

Exemples:
  .\deploy.ps1                # Démarre l'application
  .\deploy.ps1 build          # Construit les images
  .\deploy.ps1 dev            # Mode développement
  .\deploy.ps1 logs           # Voir les logs
  .\deploy.ps1 test           # Tester l'API
  .\deploy.ps1 clean          # Tout nettoyer

"@ -ForegroundColor Cyan
}

# Menu principal
if (-not (Check-Docker)) {
    exit 1
}

Write-Host ""

switch ($Action.ToLower()) {
    "build" {
        Build-Images
    }
    "start" {
        Start-App
    }
    "dev" {
        Start-Dev
    }
    "stop" {
        Stop-App
    }
    "restart" {
        Restart-App
    }
    "logs" {
        Show-Logs
    }
    "clean" {
        Clean-All
    }
    "test" {
        Test-App
    }
    "help" {
        Show-Help
    }
    default {
        Write-Info "Action '$Action' inconnue. Démarrage de l'application..."
        Start-App
    }
}

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Terminé !" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan


