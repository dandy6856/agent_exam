# Complete Java Version Fix for VS Code and Gradle
Write-Host "=== Complete Java Version Fix ===" -ForegroundColor Green

$javaPath = "C:\Program Files\Android\Android Studio\jbr"
$projectPath = "f:\dev2025\agent_exam\flutter_items_app"

# 1. Set environment variables for current session
Write-Host "Setting JAVA_HOME for current session..." -ForegroundColor Yellow
$env:JAVA_HOME = $javaPath
$env:PATH = "$javaPath\bin;$env:PATH"

# 2. Set permanent environment variable
Write-Host "Setting JAVA_HOME permanently..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("JAVA_HOME", $javaPath, "User")

# 3. Check Java version
Write-Host "Checking Java version:" -ForegroundColor Cyan
& "$javaPath\bin\java.exe" -version

# 4. Update Flutter JDK configuration
Write-Host "`nConfiguring Flutter JDK..." -ForegroundColor Yellow
flutter config --jdk-dir="$javaPath"

# 5. Stop all Gradle daemons
Write-Host "`nStopping Gradle daemons..." -ForegroundColor Yellow
Set-Location "$projectPath\android"
& ".\gradlew.bat" --stop

# 6. Clear Gradle caches
Write-Host "Clearing Gradle caches..." -ForegroundColor Yellow
$gradleCacheDir = "$env:USERPROFILE\.gradle"
if (Test-Path $gradleCacheDir) {
    Remove-Item "$gradleCacheDir\caches" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$gradleCacheDir\daemon" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Cleared Gradle cache" -ForegroundColor Green
}

# 7. Clean Flutter
Write-Host "`nCleaning Flutter project..." -ForegroundColor Yellow
Set-Location $projectPath
flutter clean

# 8. Test Gradle with correct Java
Write-Host "Testing Gradle with Java 21..." -ForegroundColor Yellow
Set-Location "$projectPath\android"
& ".\gradlew.bat" tasks --stacktrace

Write-Host "=== Instructions ===" -ForegroundColor Cyan
Write-Host "1. Close VS Code completely" -ForegroundColor White
Write-Host "2. Restart VS Code" -ForegroundColor White
Write-Host "3. Reload the window (Ctrl+Shift+P -> 'Developer: Reload Window')" -ForegroundColor White
Write-Host "4. The Gradle errors should be resolved" -ForegroundColor White

Write-Host "`nIf VS Code still shows errors, run this in the terminal:" -ForegroundColor Yellow
Write-Host "`$env:JAVA_HOME='$javaPath'" -ForegroundColor Green
