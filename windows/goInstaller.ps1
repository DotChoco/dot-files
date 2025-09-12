
# Config
$os = "windows"
$arch = "amd64"
$kind = "installer"   # "installer" type instead of "msi"
$baseUrl = "https://go.dev/dl"

# Fetch list of all Go versions in JSON
$versions = Invoke-RestMethod -Uri "https://go.dev/dl/?mode=json&include=all"

# Create a simple numbered list of all versions
$versionList = $versions | ForEach-Object { $_.version } | Sort-Object -Descending
Write-Host "Available Go versions:`n"
for ($i = 0; $i -lt $versionList.Count; $i++) {
    Write-Host "$($i+1): $($versionList[$i])"
}

# Ask user which version to download
$selection = Read-Host "`nEnter the number of the version you want to download"
if (-not ($selection -as [int]) -or $selection -lt 1 -or $selection -gt $versionList.Count) {
    Write-Error "Invalid selection."
    exit 1
}

# Select the version based on user input
$chosenVersion = $versionList[$selection - 1]
Write-Host "`nYou selected: $chosenVersion"

# Find the JSON object for the chosen version
$versionObj = $versions | Where-Object { $_.version -eq $chosenVersion }

# Find the file that matches OS, architecture, and kind
$file = $versionObj.files | Where-Object { $_.os -eq $os -and $_.arch -eq $arch -and $_.kind -eq $kind }

if (-not $file) {
    Write-Error "No file found for $os-$arch ($kind) for version $chosenVersion"
    exit 1
}

# Construct full download URL
$filename = $file.filename
$url = "$baseUrl/$filename"

# Output path (adjust as needed)
$outFile = "D:\Testing\dot-files\$filename"

Write-Host "Downloading from: $url"
Write-Host "Saving to:        $outFile"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $outFile

# Verify SHA256 hash
$hash = (Get-FileHash -Path $outFile -Algorithm SHA256).Hash.ToLower()
if ($hash -ne $file.sha256) {
    Write-Error "Hash mismatch! Download may be corrupted."
} else {
    Write-Host "Download verified successfully ✔"
}

