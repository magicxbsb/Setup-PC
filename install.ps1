$apps = @(
    "Mozilla.Firefox",
    "VideoLAN.VLC",
    "7zip.7zip",
    "Notepad++.Notepad++"
)

foreach ($app in $apps) {
    Write-Host "Traitement de $app..."
    winget install --id $app --exact --silent --accept-source-agreements --accept-package-agreements
}
