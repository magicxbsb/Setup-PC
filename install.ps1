# ==============================================================================
#  GESTIONNAIRE DE LOGICIELS — v2.0
#  Structure du menu : Groupe > Sous-groupe (optionnel) > Applications
#
#  Format d'une entrée :
#    @{ Name = "Nom affiché" ; Id = "winget.Id" }
#
#  Format d'un sous-groupe (clé "Sub") :
#    @{ Sub = "NOM DU SOUS-GROUPE" ; Apps = @( @{ Name=... ; Id=... }, ... ) }
#
#  Tu peux mélanger les deux dans le même groupe.
# ==============================================================================
$menu = [ordered]@{

    "ELGATO" = @(
        @{ Sub = "STREAM DECK" ; Apps = @(
            @{ Name = "Stream Deck"                     ; Id = "Elgato.StreamDeck"    },
            @{ Name = "Wave Link"                       ; Id = "Elgato.WaveLink"      },
            @{ Name = "Studio"                          ; Id = "Elgato.Studio"        },
            @{ Name = "Control Center"                  ; Id = "Elgato.ControlCenter" },
            @{ Name = "Marketplace Connect for OBS  ^" ; Id = "" ; Url = "https://www.elgato.com/fr/fr/s/downloads" },
            @{ Name = "Buttons  ^"                     ; Id = "" ; Url = "https://www.elgato.com/fr/fr/s/downloads" },
            @{ Name = "Default Profile Galleon 100  ^" ; Id = "" ; Url = "https://www.elgato.com/fr/fr/s/downloads" }
        )},
        @{ Sub = "CAPTURE" ; Apps = @(
            @{ Name = "4K Capture Utility"     ; Id = "Elgato.4KCaptureUtility"        },
            @{ Name = "Camera Hub"             ; Id = "Elgato.CameraHub"               },
            @{ Name = "Video Capture  ^"       ; Id = "" ; Url = "https://www.elgato.com/fr/fr/s/downloads" },
            @{ Name = "Game Capture 4K60 Pro"  ; Id = "Elgato.GameCapture.4K60ProMK2"  },
            @{ Name = "Game Capture HD"        ; Id = "Elgato.GameCapture.HD"          },
            @{ Name = "Game Capture HD60 S"    ; Id = "Elgato.GameCapture.HD60S"       }
        )},
        @{ Sub = "CAMERA" ; Apps = @(
            @{ Name = "EpocCam (drivers)" ; Id = "Elgato.EpocCam" }
        )}
    )

    "OUTILS SYSTEME" = @(
        @{ Name = "CPU-Z"          ; Id = "CPUID.CPU-Z"              },
        @{ Name = "Notepad++"      ; Id = "Notepad++.Notepad++"      },
        @{ Name = "Process Lasso"  ; Id = "Bitsum.ProcessLasso"       },
        @{ Name = "TreeSize Free"  ; Id = "JAMSoftware.TreeSize.Free" }
    )

    "AUDIO / VIDEO" = @(
        @{ Name = "OBS Studio"  ; Id = "OBSProject.OBSStudio"         },
        @{ Name = "VirtualDJ"   ; Id = "AtomixProductions.VirtualDJ"   },
        @{ Name = "VLC"         ; Id = "VideoLAN.VLC"                  },
        @{ Name = "Handbrake"   ; Id = "HandBrake.HandBrake"           }
    )

    "DEVELOPPEMENT" = @(
        @{ Name = "VS Code"     ; Id = "Microsoft.VisualStudioCode" },
        @{ Name = "Git"         ; Id = "Git.Git"                    },
        @{ Name = "Windows Terminal" ; Id = "Microsoft.WindowsTerminal" }
    )
}

# ==============================================================================
#  MOTEUR — Ne pas modifier sauf si tu maîtrises PowerShell
# ==============================================================================

# ── Couleurs centralisées ──────────────────────────────────────────────────────
$C = @{
    Title    = 'Magenta'
    Header   = 'Cyan'
    Sub      = 'DarkCyan'
    Num      = 'Yellow'
    OK       = 'Green'
    Warn     = 'DarkYellow'
    Err      = 'Red'
    Dim      = 'DarkGray'
    Default  = 'Gray'
}

# ── Récupération de toutes les versions installées en un seul appel ───────────
function Get-AllInstalledVersions {
    $map = @{}
    try {
        $raw = winget list --accept-source-agreements 2>$null
        foreach ($line in $raw) {
            # winget list : colonnes séparées par des espaces multiples
            if ($line -match '^\s*(.+?)\s{2,}(\S+)\s{2,}(\S+)') {
                $id  = $Matches[2].Trim()
                $ver = $Matches[3].Trim()
                if ($id -and $ver) { $map[$id] = $ver }
            }
        }
    } catch { <# silencieux si winget indisponible #> }
    return $map
}

# ── Aplatit un groupe en liste d'apps (ignore les sous-groupes) ───────────────
function Get-FlatApps {
    param($GroupItems)
    $list = @()
    foreach ($item in $GroupItems) {
        if ($item.ContainsKey('Sub')) { $list += $item.Apps }
        else                          { $list += $item      }
    }
    return $list
}

# ── Affiche un badge version ──────────────────────────────────────────────────
function Write-VersionBadge {
    param($Id, $Versions)
    if ($Versions.ContainsKey($Id)) {
        Write-Host " [" -NoNewline -ForegroundColor $C.Dim
        Write-Host $Versions[$Id] -NoNewline -ForegroundColor $C.OK
        Write-Host "]" -NoNewline -ForegroundColor $C.Dim
    } else {
        Write-Host " [non installé]" -NoNewline -ForegroundColor $C.Dim
    }
}

# ── URL de fallback par éditeur ───────────────────────────────────────────────
$FallbackUrls = @{
    "Elgato" = "https://www.elgato.com/fr/fr/s/downloads"
    # Ajoute d'autres éditeurs ici si besoin :
    # "Logitech" = "https://support.logi.com/hc/fr/categories/360001751833"
}

# ── Devine l'URL de fallback depuis l'ID winget (ex: "Elgato.StreamDeck" → "Elgato") ──
function Get-FallbackUrl {
    param($Id, $AppUrl)
    if ($AppUrl) { return $AppUrl }                         # URL manuelle prioritaire
    $publisher = $Id -split '\.' | Select-Object -First 1  # "Elgato.StreamDeck" → "Elgato"
    if ($FallbackUrls.ContainsKey($publisher)) { return $FallbackUrls[$publisher] }
    return $null
}

# ── Installe une app et retourne $true si succès ──────────────────────────────
function Install-App {
    param($App)
    Write-Host ""

    # Entrée de type lien uniquement (pas d'ID winget)
    if (-not $App.Id -and $App.Url) {
        Write-Host "  ► Ouverture de la page de téléchargement pour $($App.Name)..." `
            -ForegroundColor $C.Warn
        Start-Process $App.Url
        Write-Host "  ↗ Navigateur ouvert." -ForegroundColor $C.Warn
        return $true
    }

    Write-Host "  ► Installation de $($App.Name)..." -ForegroundColor $C.OK
    winget install --id $App.Id --exact --silent `
        --accept-source-agreements --accept-package-agreements

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✔ $($App.Name) installé avec succès." -ForegroundColor $C.OK
        return $true

    } elseif ($LASTEXITCODE -eq -1978335189) {
        Write-Host "  ✔ $($App.Name) est déjà à jour." -ForegroundColor $C.Warn
        return $true

    } elseif ($LASTEXITCODE -eq -1978335212) {
        # Package introuvable dans winget → fallback navigateur
        $url = Get-FallbackUrl -Id $App.Id -AppUrl $App.Url
        Write-Host "  ✖ '$($App.Id)' introuvable dans winget." -ForegroundColor $C.Err
        if ($url) {
            Write-Host "  ↗ Ouverture de la page de téléchargement..." -ForegroundColor $C.Warn
            Start-Process $url
        } else {
            Write-Host "    → Lance : winget search `"$($App.Name)`"" -ForegroundColor $C.Dim
        }
        return $false

    } elseif ($LASTEXITCODE -eq -1978335193) {
        Write-Host "  ✖ Erreur réseau. Vérifie ta connexion internet." -ForegroundColor $C.Err
        return $false

    } elseif ($LASTEXITCODE -eq -1978335210) {
        Write-Host "  ✖ Installation annulée." -ForegroundColor $C.Warn
        return $false

    } else {
        Write-Host "  ✖ Échec (code $LASTEXITCODE)." -ForegroundColor $C.Err
        return $false
    }
}

# ── Écran d'une catégorie ──────────────────────────────────────────────────────
function Show-Category {
    param($CatName, $GroupItems)

    while ($true) {
        # Recharge les versions à chaque retour sur l'écran
        Write-Host ""
        Write-Host "  Chargement des versions..." -ForegroundColor $C.Dim
        $versions = Get-AllInstalledVersions

        # Construit la liste plate numérotée
        $flatApps = @()
        Clear-Host
        Write-Host ""
        Write-Host "  ╔══════════════════════════════════════════╗" -ForegroundColor $C.Header
        Write-Host "  ║  $($CatName.PadRight(42))║" -ForegroundColor $C.Header
        Write-Host "  ╚══════════════════════════════════════════╝" -ForegroundColor $C.Header
        Write-Host ""

        $idx = 1
        foreach ($item in $GroupItems) {

            # ── Sous-groupe ──
            if ($item.ContainsKey('Sub')) {
                Write-Host "  ── $($item.Sub) " -NoNewline -ForegroundColor $C.Sub
                Write-Host ("─" * [Math]::Max(2, 38 - $item.Sub.Length)) -ForegroundColor $C.Dim
                foreach ($app in $item.Apps) {
                    Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
                    Write-Host $idx -NoNewline -ForegroundColor $C.Num
                    Write-Host "] " -NoNewline -ForegroundColor $C.Dim
                    Write-Host $app.Name -NoNewline -ForegroundColor $C.Default
                    Write-VersionBadge -Id $app.Id -Versions $versions
                    Write-Host ""
                    $flatApps += $app
                    $idx++
                }
                Write-Host ""

            # ── App directe ──
            } else {
                Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
                Write-Host $idx -NoNewline -ForegroundColor $C.Num
                Write-Host "] " -NoNewline -ForegroundColor $C.Dim
                Write-Host $item.Name -NoNewline -ForegroundColor $C.Default
                Write-VersionBadge -Id $item.Id -Versions $versions
                Write-Host ""
                $flatApps += $item
                $idx++
            }
        }

        $total = $flatApps.Count
        Write-Host ""
        Write-Host "  ── Actions " -NoNewline -ForegroundColor $C.Sub
        Write-Host "──────────────────────────────" -ForegroundColor $C.Dim
        Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
        Write-Host "1-$total" -NoNewline -ForegroundColor $C.Num
        Write-Host "]  Installer l'application correspondante" -ForegroundColor $C.Dim
        Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
        Write-Host "a" -NoNewline -ForegroundColor $C.Num
        Write-Host "]    Tout installer ($total apps)" -ForegroundColor $C.Dim
        Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
        Write-Host "0" -NoNewline -ForegroundColor $C.Num
        Write-Host "]    Retour au menu principal" -ForegroundColor $C.Dim
        Write-Host ""

        $choice = Read-Host "  Votre choix"

        # Retour
        if ($choice -eq '0') { break }

        # Tout installer
        if ($choice -eq 'a') {
            Write-Host ""
            Write-Host "  ► Installation de toutes les apps ($total)..." -ForegroundColor $C.OK
            $ok = 0 ; $fail = 0
            foreach ($app in $flatApps) {
                $result = Install-App -App $app
                if ($result) { $ok++ } else { $fail++ }
            }
            Write-Host ""
            Write-Host "  ✔ $ok succès" -ForegroundColor $C.OK -NoNewline
            if ($fail -gt 0) { Write-Host "  ✖ $fail échec(s)" -ForegroundColor $C.Err -NoNewline }
            Write-Host ""
            Read-Host "`n  Appuyez sur Entrée pour continuer"
            continue
        }

        # Numéro individuel
        if ($choice -match '^\d+$') {
            $n = [int]$choice
            if ($n -ge 1 -and $n -le $total) {
                Install-App -App $flatApps[$n - 1] | Out-Null
                Read-Host "`n  Appuyez sur Entrée pour continuer"
            } else {
                Write-Host "  ✖ Numéro invalide. Entrez un nombre entre 1 et $total." `
                    -ForegroundColor $C.Err
                Start-Sleep -Seconds 1.5
            }
            continue
        }

        # Entrée non reconnue
        Write-Host "  ✖ Commande non reconnue : '$choice'" -ForegroundColor $C.Err
        Start-Sleep -Seconds 1.5
    }
}

# ══════════════════════════════════════════════════════════════════════════════
#  BOUCLE PRINCIPALE
# ══════════════════════════════════════════════════════════════════════════════
while ($true) {
    Clear-Host
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════╗" -ForegroundColor $C.Title
    Write-Host "  ║     GESTIONNAIRE DE LOGICIELS  v2.0      ║" -ForegroundColor $C.Title
    Write-Host "  ╚══════════════════════════════════════════╝" -ForegroundColor $C.Title
    Write-Host ""

    $keys = $menu.Keys  # [ordered] → ordre garanti
    $i = 1
    foreach ($key in $keys) {
        $appCount = (Get-FlatApps -GroupItems $menu[$key]).Count
        Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
        Write-Host $i -NoNewline -ForegroundColor $C.Num
        Write-Host "] " -NoNewline -ForegroundColor $C.Dim
        Write-Host $key -NoNewline -ForegroundColor $C.Default
        Write-Host " ($appCount apps)" -ForegroundColor $C.Dim
        $i++
    }

    Write-Host ""
    Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
    Write-Host "q" -NoNewline -ForegroundColor $C.Num
    Write-Host "]  Quitter" -ForegroundColor $C.Dim
    Write-Host ""

    $rep = Read-Host "  Sélectionner une catégorie"

    if ($rep -eq 'q') {
        Write-Host ""
        Write-Host "  Au revoir !" -ForegroundColor $C.OK
        Write-Host ""
        break
    }

    if ($rep -match '^\d+$') {
        $n = [int]$rep
        if ($n -ge 1 -and $n -le $keys.Count) {
            $selectedKey = @($keys)[$n - 1]
            Show-Category -CatName $selectedKey -GroupItems $menu[$selectedKey]
        } else {
            Write-Host "  ✖ Numéro invalide. Choisissez entre 1 et $($keys.Count)." `
                -ForegroundColor $C.Err
            Start-Sleep -Seconds 1.5
        }
        continue
    }

    Write-Host "  ✖ Commande non reconnue : '$rep'" -ForegroundColor $C.Err
    Start-Sleep -Seconds 1.5
}
