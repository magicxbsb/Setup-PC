# ==============================================================================
#  GESTIONNAIRE DE LOGICIELS — v3.0
#  Structure du menu : Groupe > Sous-groupe (optionnel) > Applications
#
#  Format d'une entrée :
#    @{ Name = "Nom affiché" ; Id = "winget.Id" }
#
#  Format avec source forcée (winget ou msstore) :
#    @{ Name = "Nom" ; Id = "winget.Id" ; Source = "msstore" }
#
#  Format lien web (pas dans winget) :
#    @{ Name = "Nom ^" ; Id = "" ; Url = "https://..." }
#
#  Format sous-groupe :
#    @{ Sub = "NOM" ; Apps = @( ... ) }
# ==============================================================================
$menu = [ordered]@{

    "ELGATO" = @(
        @{ Sub = "STREAM DECK" ; Apps = @(
            @{ Name = "Stream Deck"                    ; Id = "Elgato.StreamDeck"    },
            @{ Name = "Wave Link"                      ; Id = "Elgato.WaveLink"      },
            @{ Name = "Studio"                         ; Id = "Elgato.Studio"        },
            @{ Name = "Control Center"                 ; Id = "Elgato.ControlCenter" },
            @{ Name = "Marketplace Connect for OBS  ^" ; Id = "" ; Url = "https://www.elgato.com/fr/fr/s/downloads" },
            @{ Name = "Buttons  ^"                     ; Id = "" ; Url = "https://www.elgato.com/fr/fr/s/downloads" },
            @{ Name = "Default Profile Galleon 100  ^" ; Id = "" ; Url = "https://www.elgato.com/fr/fr/s/downloads" }
        )},
        @{ Sub = "CAPTURE" ; Apps = @(
            @{ Name = "4K Capture Utility"    ; Id = "Elgato.4KCaptureUtility"       },
            @{ Name = "Camera Hub"            ; Id = "Elgato.CameraHub"              },
            @{ Name = "Game Capture 4K60 Pro" ; Id = "Elgato.GameCapture.4K60ProMK2" },
            @{ Name = "Game Capture HD"       ; Id = "Elgato.GameCapture.HD"         },
            @{ Name = "Game Capture HD60 S"   ; Id = "Elgato.GameCapture.HD60S"      },
            @{ Name = "Video Capture  ^"      ; Id = "" ; Url = "https://www.elgato.com/fr/fr/s/downloads" }
        )},
        @{ Sub = "CAMERA" ; Apps = @(
            @{ Name = "EpocCam (drivers)" ; Id = "Elgato.EpocCam" }
        )}
    )

    "STREAM" = @(
        @{ Sub = "LOGICIELS STREAM" ; Apps = @(
            @{ Name = "OBS Studio"        ; Id = "OBSProject.OBSStudio"   },
            @{ Name = "Streamlabs Desktop"; Id = "Streamlabs.Streamlabs"  },
            @{ Name = "TikTok Live Studio ^" ; Id = "" ; Url = "https://www.tiktok.com/studio/download"   },
            @{ Name = "PRISM Live Studio  ^" ; Id = "" ; Url = "https://prismlive.com/en_us/desktop.html" }
        )},
        @{ Sub = "PLUGINS & EXTENSIONS" ; Apps = @(
            @{ Name = "StreamElements SE LIVE  ^" ; Id = "" ; Url = "https://streamelements.com/selive"  },
            @{ Name = "Social Stream Ninja     ^" ; Id = "" ; Url = "https://socialstream.ninja/landing" },
            @{ Name = "Streamlabs Plugin OBS   ^" ; Id = "" ; Url = "https://streamlabs.com/fr-fr/obs-plugin" }
        )},
        @{ Sub = "MATERIEL & AUDIO" ; Apps = @(
            @{ Name = "NVIDIA Broadcast  ^"             ; Id = "" ; Url = "https://www.nvidia.com/fr-fr/geforce/broadcasting/broadcast-app/" },
            @{ Name = "StreamElements Ground Control ^" ; Id = "" ; Url = "https://streamelements.com/groundcontrol" }
        )}
    )

    "ESSENTIELS" = @(
        @{ Sub = "MONITORING" ; Apps = @(
            @{ Name = "HWiNFO"               ; Id = "REALiX.HWiNFO" },
            @{ Name = "MSI Afterburner"      ; Id = "Guru3D.Afterburner" },
            @{ Name = "OCCT"                 ; Id = "OCBASE.OCCT" },
            @{ Name = "MSI Afterburner Beta" ; Id = "Guru3D.Afterburner.Beta" },
            @{ Name = "OCCT Beta  ^"         ; Id = "" ; Url = "https://www.ocbase.com/download" }
        )},
        @{ Sub = "UTILITAIRES" ; Apps = @(
            @{ Name = "SignalRGB  ^"  ; Id ="" ; Url = "https://signalrgb.com/" },
            @{ Name = "Encrypto"      ; Id = "MacPaw.Encrypto" }
        )}
    )

    "PERIPHERIQUES" = @(
        @{ Sub = "LIAN LI" ; Apps = @(
            @{ Name = "L-Connect 3" ; Id = "" ; Url = "https://lian-li.com/l-connect3/" }
        )},
        @{ Sub = "CASQUE" ; Apps = @(
            @{ Name = "SteelSeries GG" ; Id = "SteelSeries.GG" }
        )},
        @{ Sub = "SOURIS" ; Apps = @(
            @{ Name = "ATK Hub" ; Id = "" ; Url = "https://atk.gg/" }
        )},
        @{ Sub = "CLAVIER" ; Apps = @(
            @{ Name = "Halo65 Firmware" ; Id = "" ; Url = "https://kzzi.com/" }
        )},
        @{ Sub = "ECRAN" ; Apps = @(
            @{ Name = "AOC G-Menu"       ; Id = "" ; Url = "https://aoc.com/uk/gaming/g-menu" },
            @{ Name = "ASUS DisplayWidget" ; Id = "" ; Url = "https://www.asus.com/supportonly/displaywidget/" }
        )}
    )

    "PLAYSTATION" = @(
        @{ Name = "PS Remote Play"          ; Id = "PlayStation.PSRemotePlay" },
        @{ Name = "Accessories Installer"   ; Id = "PlayStation.PlayStationAccessories" }
    )

    "OUTILS SYSTEME" = @(
        @{ Name = "CPU-Z"          ; Id = "CPUID.CPU-Z"                },
        @{ Name = "Process Lasso"  ; Id = "Bitsum.ProcessLasso"        },
        @{ Name = "TreeSize Free"  ; Id = "JAMSoftware.TreeSize.Free"  }
    )

    "AUDIO / VIDEO" = @(
        @{ Name = "VirtualDJ"  ; Id = "AtomixProductions.VirtualDJ"  },
        @{ Name = "VLC"        ; Id = "VideoLAN.VLC"                 },
        @{ Name = "Handbrake"  ; Id = "HandBrake.HandBrake"          }
    )

    "DEVELOPPEMENT" = @(
        @{ Name = "VS Code"          ; Id = "Microsoft.VisualStudioCode"  },
        @{ Name = "Notepad++"        ; Id = "Notepad++.Notepad++"         },
        @{ Name = "Git"              ; Id = "Git.Git"                     },
        @{ Name = "Windows Terminal" ; Id = "Microsoft.WindowsTerminal"   }
    )
}

# ==============================================================================
#  MOTEUR — Ne pas modifier sauf si tu maîtrises PowerShell
# ==============================================================================

$C = @{
    Title   = 'Magenta'
    Header  = 'Cyan'
    Sub     = 'DarkCyan'
    Num     = 'Yellow'
    OK      = 'Green'
    Warn    = 'DarkYellow'
    Err     = 'Red'
    Dim     = 'DarkGray'
    Default = 'Gray'
    New     = 'Green'
    Old     = 'DarkYellow'
}

$FallbackUrls = @{
    "Elgato" = "https://www.elgato.com/fr/fr/s/downloads"
    "PlayStation" = "https://www.playstation.com/fr-fr/remote-play/"
    "OBSProject"  = "https://obsproject.com/fr/download"
    "Streamlabs"  = "https://streamlabs.com/streamlabs-live-streaming-software"
    # "Logitech" = "https://support.logi.com/hc/fr/categories/360001751833"
}

# ── Versions installées (un seul appel winget list) ───────────────────────────
function Get-AllInstalledVersions {
    $map = @{}
    try {
        $raw = winget list --accept-source-agreements 2>$null
        foreach ($line in $raw) {
            if ($line -match '^\s*(.+?)\s{2,}(\S+)\s{2,}(\S+)') {
                $id  = $Matches[2].Trim()
                $ver = $Matches[3].Trim()
                if ($id -and $ver) { $map[$id] = $ver }
            }
        }
    } catch {}
    return $map
}

# ── Version disponible sur une source donnée (winget show) ───────────────────
function Get-AvailableVersion {
    param($Id, $Source)
    try {
        $raw = winget show --id $Id --exact --source $Source `
               --accept-source-agreements 2>$null
        # Cherche la ligne "Version: x.x.x"
        $line = $raw | Select-String '^\s*Version\s*:\s*(.+)$'
        if ($line) {
            return $line.Matches[0].Groups[1].Value.Trim()
        }
    } catch {}
    return $null
}

# ── Aplatit groupe → liste d'apps ─────────────────────────────────────────────
function Get-FlatApps {
    param($GroupItems)
    $list = @()
    foreach ($item in $GroupItems) {
        if ($item.ContainsKey('Sub')) { $list += $item.Apps }
        else                          { $list += $item }
    }
    return $list
}

# ── Badge version installée ───────────────────────────────────────────────────
function Write-VersionBadge {
    param($Id, $Versions)
    if ($Id -and $Versions.ContainsKey($Id)) {
        Write-Host " [" -NoNewline -ForegroundColor $C.Dim
        Write-Host $Versions[$Id] -NoNewline -ForegroundColor $C.OK
        Write-Host "]" -NoNewline -ForegroundColor $C.Dim
    } elseif ($Id) {
        Write-Host " [non installé]" -NoNewline -ForegroundColor $C.Dim
    } else {
        Write-Host " [lien web]" -NoNewline -ForegroundColor $C.Dim
    }
}

# ── Fallback URL ──────────────────────────────────────────────────────────────
function Get-FallbackUrl {
    param($Id, $AppUrl)
    if ($AppUrl) { return $AppUrl }
    $pub = $Id -split '\.' | Select-Object -First 1
    if ($FallbackUrls.ContainsKey($pub)) { return $FallbackUrls[$pub] }
    return $null
}

# ── Compare winget vs msstore et propose le choix ────────────────────────────
function Show-SourceComparison {
    param($App, $InstalledVersions)

    # App lien web uniquement → pas de comparaison
    if (-not $App.Id) {
        Write-Host ""
        Write-Host "  ► Ouverture du navigateur pour $($App.Name)..." -ForegroundColor $C.Warn
        Start-Process $App.Url
        Write-Host "  ↗ Navigateur ouvert." -ForegroundColor $C.Warn
        return
    }

    Write-Host ""
    Write-Host "  Recherche des versions disponibles..." -ForegroundColor $C.Dim

    $verWinget  = Get-AvailableVersion -Id $App.Id -Source "winget"
    $verMsstore = Get-AvailableVersion -Id $App.Id -Source "msstore"
    $verInstall = if ($InstalledVersions.ContainsKey($App.Id)) { $InstalledVersions[$App.Id] } else { $null }

    # ── Tableau comparatif ──
    Clear-Host
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════╗" -ForegroundColor $C.Header
    Write-Host "  ║  $($App.Name.PadRight(42))║" -ForegroundColor $C.Header
    Write-Host "  ╚══════════════════════════════════════════╝" -ForegroundColor $C.Header
    Write-Host ""

    # Ligne installée
    if ($verInstall) {
        Write-Host "  Installée actuellement : " -NoNewline -ForegroundColor $C.Dim
        Write-Host $verInstall -ForegroundColor $C.OK
        Write-Host ""
    }

    Write-Host "  ┌─────────────┬──────────────────┬──────────────────────┐" -ForegroundColor $C.Dim
    Write-Host "  │ " -NoNewline -ForegroundColor $C.Dim
    Write-Host "Source      " -NoNewline -ForegroundColor $C.Default
    Write-Host " │ " -NoNewline -ForegroundColor $C.Dim
    Write-Host "Version dispo   " -NoNewline -ForegroundColor $C.Default
    Write-Host " │ " -NoNewline -ForegroundColor $C.Dim
    Write-Host "Statut              " -NoNewline -ForegroundColor $C.Default
    Write-Host " │" -ForegroundColor $C.Dim
    Write-Host "  ├─────────────┼──────────────────┼──────────────────────┤" -ForegroundColor $C.Dim

    # Détermine quelle version est la plus récente
    $newerSource = $null
    if ($verWinget -and $verMsstore -and ($verWinget -ne $verMsstore)) {
        try {
            $vW = [System.Version]($verWinget  -replace '[^\d.]','')
            $vM = [System.Version]($verMsstore -replace '[^\d.]','')
            $newerSource = if ($vW -gt $vM) { "winget" } else { "msstore" }
        } catch { $newerSource = $null }
    }

    # Ligne winget
    Write-Host "  │ " -NoNewline -ForegroundColor $C.Dim
    Write-Host "[1] winget   " -NoNewline -ForegroundColor $C.Num
    Write-Host " │ " -NoNewline -ForegroundColor $C.Dim
    if ($verWinget) {
        $col = if ($newerSource -eq "winget") { $C.New } else { $C.Default }
        Write-Host $verWinget.PadRight(16) -NoNewline -ForegroundColor $col
    } else {
        Write-Host "non dispo       " -NoNewline -ForegroundColor $C.Dim
    }
    Write-Host " │ " -NoNewline -ForegroundColor $C.Dim
    if (-not $verWinget) {
        Write-Host "indisponible         " -NoNewline -ForegroundColor $C.Dim
    } elseif ($newerSource -eq "winget") {
        Write-Host "★ plus recent        " -NoNewline -ForegroundColor $C.New
    } elseif ($newerSource -eq "msstore") {
        Write-Host "version ancienne     " -NoNewline -ForegroundColor $C.Old
    } elseif ($verInstall -and $verInstall -eq $verWinget) {
        Write-Host "deja installe        " -NoNewline -ForegroundColor $C.OK
    } else {
        Write-Host "identique            " -NoNewline -ForegroundColor $C.Default
    }
    Write-Host " │" -ForegroundColor $C.Dim

    # Ligne msstore
    Write-Host "  │ " -NoNewline -ForegroundColor $C.Dim
    Write-Host "[2] msstore  " -NoNewline -ForegroundColor $C.Num
    Write-Host " │ " -NoNewline -ForegroundColor $C.Dim
    if ($verMsstore) {
        $col = if ($newerSource -eq "msstore") { $C.New } else { $C.Default }
        Write-Host $verMsstore.PadRight(16) -NoNewline -ForegroundColor $col
    } else {
        Write-Host "non dispo       " -NoNewline -ForegroundColor $C.Dim
    }
    Write-Host " │ " -NoNewline -ForegroundColor $C.Dim
    if (-not $verMsstore) {
        Write-Host "indisponible         " -NoNewline -ForegroundColor $C.Dim
    } elseif ($newerSource -eq "msstore") {
        Write-Host "★ plus recent        " -NoNewline -ForegroundColor $C.New
    } elseif ($newerSource -eq "winget") {
        Write-Host "version ancienne     " -NoNewline -ForegroundColor $C.Old
    } elseif ($verInstall -and $verInstall -eq $verMsstore) {
        Write-Host "deja installe        " -NoNewline -ForegroundColor $C.OK
    } else {
        Write-Host "identique            " -NoNewline -ForegroundColor $C.Default
    }
    Write-Host " │" -ForegroundColor $C.Dim
    Write-Host "  └─────────────┴──────────────────┴──────────────────────┘" -ForegroundColor $C.Dim

    Write-Host ""
    Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
    Write-Host "1" -NoNewline -ForegroundColor $C.Num
    Write-Host "] winget   [" -NoNewline -ForegroundColor $C.Dim
    Write-Host "2" -NoNewline -ForegroundColor $C.Num
    Write-Host "] msstore   [" -NoNewline -ForegroundColor $C.Dim
    Write-Host "0" -NoNewline -ForegroundColor $C.Dim
    Write-Host "] Annuler" -ForegroundColor $C.Dim
    Write-Host ""

    $srcChoice = Read-Host "  Votre choix"

    $sourceMap = @{ "1" = "winget" ; "2" = "msstore" }
    if (-not $sourceMap.ContainsKey($srcChoice)) {
        Write-Host "  Annulé." -ForegroundColor $C.Dim
        return
    }

    $chosenSource = $sourceMap[$srcChoice]
    $chosenVer    = if ($chosenSource -eq "winget") { $verWinget } else { $verMsstore }

    if (-not $chosenVer) {
        Write-Host "  ✖ Non disponible sur $chosenSource." -ForegroundColor $C.Err
        return
    }

    Write-Host ""
    Write-Host "  ► Installation de $($App.Name) via $chosenSource..." -ForegroundColor $C.OK
    winget install --id $App.Id --exact --silent --source $chosenSource `
        --accept-source-agreements --accept-package-agreements

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✔ Installé avec succès ($chosenSource)." -ForegroundColor $C.OK
    } elseif ($LASTEXITCODE -eq -1978335189) {
        Write-Host "  ✔ Déjà à jour ($chosenSource)." -ForegroundColor $C.Warn
    } elseif ($LASTEXITCODE -eq -1978335212) {
        $url = Get-FallbackUrl -Id $App.Id -AppUrl $App.Url
        Write-Host "  ✖ Introuvable sur $chosenSource." -ForegroundColor $C.Err
        if ($url) {
            Write-Host "  ↗ Ouverture de la page de téléchargement..." -ForegroundColor $C.Warn
            Start-Process $url
        }
    } elseif ($LASTEXITCODE -eq -1978335193) {
        Write-Host "  ✖ Erreur réseau." -ForegroundColor $C.Err
    } elseif ($LASTEXITCODE -eq -1978335210) {
        Write-Host "  ✖ Installation annulée." -ForegroundColor $C.Warn
    } else {
        Write-Host "  ✖ Échec (code $LASTEXITCODE)." -ForegroundColor $C.Err
    }
}

# ── Installe silencieusement (utilisé par "tout installer") ───────────────────
function Install-AppAuto {
    param($App, $Source)

    if (-not $App.Id) {
        if ($App.Url) { Start-Process $App.Url }
        return $true
    }

    $src = if ($Source) { $Source } elseif ($App.Source) { $App.Source } else { "winget" }

    winget install --id $App.Id --exact --silent --source $src `
        --accept-source-agreements --accept-package-agreements 2>$null

    return ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq -1978335189)
}

# ── Écran d'une catégorie ──────────────────────────────────────────────────────
function Show-Category {
    param($CatName, $GroupItems)

    while ($true) {
        Write-Host ""
        Write-Host "  Chargement des versions..." -ForegroundColor $C.Dim
        $versions = Get-AllInstalledVersions

        $flatApps = @()
        Clear-Host
        Write-Host ""
        Write-Host "  ╔══════════════════════════════════════════╗" -ForegroundColor $C.Header
        Write-Host "  ║  $($CatName.PadRight(42))║" -ForegroundColor $C.Header
        Write-Host "  ╚══════════════════════════════════════════╝" -ForegroundColor $C.Header
        Write-Host ""

        $idx = 1
        foreach ($item in $GroupItems) {
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
        Write-Host "]  Comparer les sources et installer" -ForegroundColor $C.Dim
        Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
        Write-Host "a" -NoNewline -ForegroundColor $C.Num
        Write-Host "]    Tout installer via winget (auto)" -ForegroundColor $C.Dim
        Write-Host "  [" -NoNewline -ForegroundColor $C.Dim
        Write-Host "0" -NoNewline -ForegroundColor $C.Num
        Write-Host "]    Retour au menu principal" -ForegroundColor $C.Dim
        Write-Host ""

        $choice = Read-Host "  Votre choix"

        if ($choice -eq '0') { break }

        if ($choice -eq 'a') {
            Write-Host ""
            Write-Host "  ► Installation de toutes les apps ($total) via winget..." -ForegroundColor $C.OK
            $ok = 0 ; $fail = 0
            foreach ($app in $flatApps) {
                Write-Host "  · $($app.Name)..." -NoNewline -ForegroundColor $C.Dim
                $result = Install-AppAuto -App $app -Source "winget"
                if ($result) {
                    Write-Host " ✔" -ForegroundColor $C.OK
                    $ok++
                } else {
                    Write-Host " ✖" -ForegroundColor $C.Err
                    $fail++
                }
            }
            Write-Host ""
            Write-Host "  ✔ $ok succès" -NoNewline -ForegroundColor $C.OK
            if ($fail -gt 0) { Write-Host "   ✖ $fail échec(s)" -NoNewline -ForegroundColor $C.Err }
            Write-Host ""
            Read-Host "`n  Appuyez sur Entrée pour continuer"
            continue
        }

        if ($choice -match '^\d+$') {
            $n = [int]$choice
            if ($n -ge 1 -and $n -le $total) {
                Show-SourceComparison -App $flatApps[$n - 1] -InstalledVersions $versions
                Read-Host "`n  Appuyez sur Entrée pour continuer"
            } else {
                Write-Host "  ✖ Numéro invalide. Entrez un nombre entre 1 et $total." -ForegroundColor $C.Err
                Start-Sleep -Seconds 1.5
            }
            continue
        }

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
    Write-Host "  ║     GESTIONNAIRE DE LOGICIELS  v3.0      ║" -ForegroundColor $C.Title
    Write-Host "  ╚══════════════════════════════════════════╝" -ForegroundColor $C.Title
    Write-Host ""

    $keys = $menu.Keys
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
            Write-Host "  ✖ Numéro invalide. Choisissez entre 1 et $($keys.Count)." -ForegroundColor $C.Err
            Start-Sleep -Seconds 1.5
        }
        continue
    }

    Write-Host "  ✖ Commande non reconnue : '$rep'" -ForegroundColor $C.Err
    Start-Sleep -Seconds 1.5
}

