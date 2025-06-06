# Verification script to check if Java fix was successful
# Run this after restarting VS Code

Write-Host "=== Java Environment Verification ===" -ForegroundColor Green

# Check Java version
Write-Host "`nChecking Java version:" -ForegroundColor Yellow
java -version

# Check JAVA_HOME
Write-Host "`nChecking JAVA_HOME:" -ForegroundColor Yellow
echo $env:JAVA_HOME

# Check Flutter Java configuration
Write-Host "`nChecking Flutter Java configuration:" -ForegroundColor Yellow
flutter config

# Navigate to Flutter project
Set-Location "f:\dev2025\agent_exam\flutter_items_app"

# Test Gradle build
Write-Host "`nTesting Gradle build (this should work without errors):" -ForegroundColor Yellow
cd android
.\gradlew tasks --console=plain

Write-Host "`n=== Verification Complete ===" -ForegroundColor Green
Write-Host "If you see no errors above, the Java fix was successful!" -ForegroundColor Cyan
