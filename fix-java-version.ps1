# Fix Java Version for Flutter Android
Write-Host "=== Fixing Java Version for Flutter Android ===" -ForegroundColor Green

# 1. Set JAVA_HOME for current session
$javaPath = "C:\Program Files\Android\Android Studio\jbr"
$env:JAVA_HOME = $javaPath
Write-Host "✓ Set JAVA_HOME for current session: $javaPath" -ForegroundColor Green

# 2. Set JAVA_HOME permanently for user
[Environment]::SetEnvironmentVariable("JAVA_HOME", $javaPath, "User")
Write-Host "✓ Set JAVA_HOME permanently for user" -ForegroundColor Green

# 3. Check Java version
Write-Host "`nChecking Java version:" -ForegroundColor Yellow
& "$javaPath\bin\java.exe" -version

# 4. Kill any existing Gradle daemons
Write-Host "`nKilling existing Gradle daemons..." -ForegroundColor Yellow
Set-Location "f:\dev2025\agent_exam\flutter_items_app"
& ".\android\gradlew.bat" --stop

# 5. Clean Flutter project
Write-Host "`nCleaning Flutter project..." -ForegroundColor Yellow
flutter clean

# 6. Get dependencies
Write-Host "`nGetting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get

# 7. Try to build Android
Write-Host "`nTrying to build Android..." -ForegroundColor Yellow
flutter build apk --debug

Write-Host "`n=== Done! ===" -ForegroundColor Green
Write-Host "If you still see Java 11 errors, please restart VS Code." -ForegroundColor Cyan
