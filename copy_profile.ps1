param (
    [string]$source,
    [string]$target
)

# Validate parameters
if (-not $source) {
    Write-Error "Source server ID name is required."
    exit
}
if (-not $target) {
    Write-Error "Target server ID name is required."
    exit
}

# Get the local app data path
$localAppData = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData)

# Construct the base path for the SaveGames directory
$baseSaveGamesPath = Join-Path $localAppData "Pal\Saved\SaveGames"

# Define the backup folder path
$backupFolderPath = Join-Path $baseSaveGamesPath "Backups"

# Ensure the backup folder exists
if (-not (Test-Path $backupFolderPath)) {
    New-Item -Path $backupFolderPath -ItemType Directory
}

# Get all subdirectories in the SaveGames directory
$subDirectories = Get-ChildItem -Path $baseSaveGamesPath -Directory

foreach ($subDir in $subDirectories) {
    # Extract the subdirectory name
    $subDirName = $subDir.Name

    # Construct the full paths for source and target directories
    $sourcePath = Join-Path $subDir.FullName $source
    $targetPath = Join-Path $subDir.FullName $target

    # Check if the source directory exists and create a backup
    if (Test-Path $sourcePath) {
        $sourceBackupFileName = "$subDirName-$source-" + (Get-Date -Format "yyyyMMddHHmmss") + ".zip"
        $sourceBackupFilePath = Join-Path $backupFolderPath $sourceBackupFileName
        $null = Compress-Archive -Path $sourcePath -DestinationPath $sourceBackupFilePath
    }

    # Check if the target directory exists and create a backup
    if (Test-Path $targetPath) {
        $targetBackupFileName = "$subDirName-$target-" + (Get-Date -Format "yyyyMMddHHmmss") + ".zip"
        $targetBackupFilePath = Join-Path $backupFolderPath $targetBackupFileName
        $null = Compress-Archive -Path $targetPath -DestinationPath $targetBackupFilePath

        # Delete the target directory
        Remove-Item -Path $targetPath -Recurse -Force
    }

    # Copy the source directory to the target location
    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination $targetPath -Recurse
    }
}

Write-Host "Operation completed."
