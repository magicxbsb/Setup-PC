$apps = @(
    @{ Name = "WinRAR"; Id = "RARLab.WinRAR" },
    @{ Name = "OBS Studio"; Id = "OBSProject.OBSStudio" },
    @{ Name = "CPU-Z"; Id = "CPUID.CPU-Z" },
    @{ Name = "Rockstar Launcher"; Id = "RockstarGames.Launcher" },
    @{ Name = "SteelSeries GG"; Id = "SteelSeries.GG" }
)

Clear-Host
Write-Host "=== SYSTEME DE MISE A JOUR SEQUENTIEL ===" -ForegroundColor Cyan

foreach ($app in $apps) {
    Write-Host "`n-------------------------------------------"
    Write-Host "Analyse de $($app.Name)..." -ForegroundColor Yellow
    
    # Récupération des versions
    $localCheck = winget list --id $app.Id --exact --accept-source-agreements 2>$null | Select-String $app.Id
    $localVer = if ($localCheck) { (-split $localCheck)[2] } else { "Non installé" }

    $repoCheck = winget search --id $app.Id --exact --accept-source-agreements 2>$null | Select-String $app.Id
    $latestVer = if ($repoCheck) { (-split $repoCheck)[2] } else { "Inconnu" }

    # Affichage
    Write-Host "Version Actuelle   : $localVer"
    Write-Host "Version Officielle : $latestVer"

    # Boucle de décision
    $valide = $false
    while (-not $valide) {
        $choix = Read-Host "Mettre a jour / Installer ? (O/N)"
        if ($choix -match '^[oO]$') {
            Write-Host "Action : Installation de $($app.Name)..." -ForegroundColor Green
            winget install --id $app.Id --exact --accept-source-agreements --accept-package-agreements
            $valide = $true
        } elseif ($choix -match '^[nN]$') {
            Write-Host "Action : Ignoré." -ForegroundColor DarkGray
            $valide = $true
        } else {
            Write-Host "Erreur : Saisie invalide. Tapez O ou N." -ForegroundColor Red
        }
    }
}

Write-Host "`n==========================================="
Write-Host "Processus global termine. Fermeture dans 5 secondes."
Start-Sleep -Seconds 5
