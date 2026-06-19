$apps = @{
    "1" = @{ Name = "WinRAR"; Id = "RARLab.WinRAR" }
    "2" = @{ Name = "OBS Studio"; Id = "OBSProject.OBSStudio" }
    "3" = @{ Name = "CPU-Z"; Id = "CPUID.CPU-Z" }
    "4" = @{ Name = "Rockstar Launcher"; Id = "RockstarGames.Launcher" }
    "5" = @{ Name = "SteelSeries GG"; Id = "SteelSeries.GG" }
}

Clear-Host
Write-Host "=== VERIFICATEUR DE VERSIONS OBLIGATOIRE ===" -ForegroundColor Cyan

foreach ($key in ($apps.Keys | Sort-Object)) {
    $app = $apps[$key]
    
    # 1. Récupération version locale
    $localCheck = winget list --id $app.Id --exact 2>$null | Select-String $app.Id
    $localVer = "Non installé"
    if ($localCheck) {
        $localVer = (-split $localCheck)[2]
    }

    # 2. Récupération version officielle en ligne
    $repoCheck = winget search --id $app.Id --exact 2>$null | Select-String $app.Id
    $latestVer = "Inconnu"
    if ($repoCheck) {
        $latestVer = (-split $repoCheck)[2]
    }

    Write-Host "[$key] $($app.Name)" -ForegroundColor Yellow
    Write-Host "    -> Version actuelle : $localVer"
    Write-Host "    -> Version officielle : $latestVer"
}

Write-Host "-------------------------------------------"
$choix = Read-Host "Entrez le numéro de l'appli à installer/mettre à jour (ou 'q' pour quitter)"

if ($choix -eq 'q') { exit }

if ($apps.ContainsKey($choix)) {
    $appId = $apps[$choix].Id
    Write-Host "Exécution de la commande officielle..." -ForegroundColor Green
    winget install --id $appId --exact --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "Erreur : Saisie invalide." -ForegroundColor Red
}

Write-Host "Processus terminé. Fermeture dans 5 secondes."
Start-Sleep -Seconds 5
