# ==============================================================================
# CONFIGURATION HIÉRARCHIQUE
# ==============================================================================
$structure = [ordered]@{
    "ELGATO" = [ordered]@{
        "STREAM DECK" = @(
            @{ Name = "Stream Deck"; Id = "Elgato.StreamDeck" },
            @{ Name = "Wave Link"; Id = "Elgato.WaveLink" }
        )
    }
    "OUTILS" = [ordered]@{
        "SYSTEME" = @(
            @{ Name = "CPU-Z"; Id = "CPUID.CPU-Z" }
        )
    }
}

# ==============================================================================
# MOTEUR DE NAVIGATION (Récursif)
# ==============================================================================
function Show-Menu {
    param($parentName, $items)
    
    while($true) {
        Clear-Host
        Write-Host "--- $parentName ---" -ForegroundColor Cyan
        $keys = $items.Keys | ForEach-Object { $_ }
        for($i=0; $i -lt $keys.Count; $i++) { Write-Host "[$($i+1)] $($keys[$i])" }
        Write-Host "[0] Retour"
        
        $choix = Read-Host "`nChoix"
        if ($choix -eq "0") { return }
        if ($choix -match '^\d+$') {
            $idx = [int]$choix - 1
            if ($idx -ge 0 -and $idx -lt $keys.Count) {
                $targetKey = $keys[$idx]
                $target = $items[$targetKey]
                
                # Si c'est une liste d'apps (tableau), on installe
                if ($target -is [array]) {
                    foreach($app in $target) {
                        Write-Host "Installation de $($app.Name)..." -ForegroundColor Green
                        winget install --id $app.Id --exact --silent --accept-source-agreements
                    }
                    Read-Host "Terminé. Entrée pour continuer."
                } else {
                    # Sinon, on descend dans le sous-menu
                    Show-Menu -parentName $targetKey -items $target
                }
            }
        }
    }
}

# Lancement
Show-Menu -parentName "MENU PRINCIPAL" -items $structure
