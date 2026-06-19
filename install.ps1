# ==============================================================================
# CONFIGURATION : Ajoute tes logiciels ici
# Pour trouver l'ID exact : tape 'winget search "NomDuLogiciel"' dans ta console
# ==============================================================================
$menu = @{
    "STREAM DECK" = @(
        @{ Name = "Elgato Stream Deck"; Id = "Elgato.StreamDeck" },
        @{ Name = "Elgato Wave Link"; Id = "Elgato.WaveLink" }
    )
    "OUTILS SYSTEME" = @(
        @{ Name = "CPU-Z"; Id = "CPUID.CPU-Z" },
        @{ Name = "Notepad++"; Id = "Notepad++.Notepad++" },
        @{ Name = "Process Lasso"; Id = "Bitsum.ProcessLasso" }
    )
    "AUDIO / VIDEO" = @(
        @{ Name = "OBS Studio"; Id = "OBSProject.OBSStudio" },
        @{ Name = "VirtualDJ"; Id = "AtomixProductions.VirtualDJ" }
    )
}

# ==============================================================================
# MOTEUR DU SCRIPT (Ne pas modifier sauf si tu maîtrises PowerShell)
# ==============================================================================
function Get-Version {
    param($Id)
    $check = winget list --id $Id --exact --accept-source-agreements 2>$null | Select-String $Id
    if ($check) { return (-split $check)[2] }
    return "Non installé"
}

function Show-Category {
    param($catName, $appList)
    while($true) {
        Clear-Host
        Write-Host "--- CATEGORIE: $catName ---" -ForegroundColor Cyan
        for($i=0; $i -lt $appList.Count; $i++) {
            $ver = Get-Version -Id $appList[$i].Id
            Write-Host "[$($i+1)] $($appList[$i].Name) (Actuel: $ver)"
        }
        Write-Host "[0] Retour au menu principal"
        
        $choix = Read-Host "`nEntrez le numéro pour installer"
        if ($choix -eq "0") { break }
        if ($choix -match '^\d+$') {
            $idx = [int]$choix - 1
            if ($idx -ge 0 -and $idx -lt $appList.Count) {
                $target = $appList[$idx]
                Write-Host "Installation de $($target.Name)..." -ForegroundColor Green
                winget install --id $target.Id --exact --silent --accept-source-agreements --accept-package-agreements
                Read-Host "Appuyez sur Entrée pour continuer"
            }
        }
    }
}

while ($true) {
    Clear-Host
    Write-Host "=== GESTIONNAIRE DE LOGICIELS (OFFICIEL) ===" -ForegroundColor Magenta
    $keys = $menu.Keys | Sort-Object
    for ($i=0; $i -lt $keys.Count; $i++) { Write-Host "[$($i+1)] $($keys[$i])" }
    Write-Host "[q] Quitter"
    
    $rep = Read-Host "`nSelectionner une categorie"
    if ($rep -eq 'q') { break }
    if ($rep -match '^\d+$' -and [int]$rep -le $keys.Count) {
        Show-Category -catName $keys[[int]$rep - 1] -appList $menu[$keys[[int]$rep - 1]]
    }
}
