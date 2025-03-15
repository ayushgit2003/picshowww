# Define Variables
$repoPath = "C:\Users\ayush\Downloads\sdbapp-main\sdbapp-main\picshow"
$branch = "final"  # Target branch for checking new commits
$logFile = "$repoPath\last_commit.log"
$apkFolder = "$repoPath\Apk"  # Directory to store APKs

# Ensure the APK folder exists
if (!(Test-Path $apkFolder)) {
    New-Item -ItemType Directory -Path $apkFolder | Out-Null
}

# Navigate to the Flutter project directory
Set-Location $repoPath

# Fetch the latest changes
git fetch origin $branch

# Get the latest commit hash from the remote branch
$latestCommit = git rev-parse origin/$branch
$shortCommit = git rev-parse --short $latestCommit  # Get short commit hash

# Read the last built commit hash
if (Test-Path $logFile) {
    $lastCommit = Get-Content $logFile
} else {
    $lastCommit = ""
}

# Check if there is a new commit
if ($latestCommit -ne $lastCommit) {
    Write-Output "New commit detected. Starting APK build process..."
    
    # Pull latest changes
    git reset --hard origin/$branch
    git pull origin $branch
    
    # Run Flutter build
    flutter clean
    flutter pub get
    flutter build apk --release

    # Move the built APK to the Apk folder with a timestamp and commit hash
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $apkSource = "$repoPath\build\app\outputs\flutter-apk\app-release.apk"
    $apkDestination = "$apkFolder\app-release-$timestamp-$shortCommit.apk"

    if (Test-Path $apkSource) {
        Move-Item -Path $apkSource -Destination $apkDestination
        Write-Output "APK saved as $apkDestination"
    } else {
        Write-Output "APK build failed or not found!"
    }

    # Update the last commit hash
    $latestCommit | Set-Content $logFile
    Write-Output "APK build completed successfully."
} else {
    Write-Output "No new commits. Skipping build."
}
