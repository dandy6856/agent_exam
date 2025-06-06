# Test script for multiple platforms

Write-Host "=== Flutter Multi-Platform Test Script ===" -ForegroundColor Green
Write-Host ""

# Check Flutter doctor
Write-Host "1. Checking Flutter doctor..." -ForegroundColor Yellow
flutter doctor

Write-Host ""
Write-Host "2. Available devices:" -ForegroundColor Yellow
flutter devices

Write-Host ""
Write-Host "3. Choose platform to test:" -ForegroundColor Yellow
Write-Host "   [1] Web (Chrome)"
Write-Host "   [2] Windows Desktop"
Write-Host "   [3] Web Build only"
Write-Host "   [4] Windows Build only"
Write-Host "   [5] Run both Web + Windows"
Write-Host ""

$choice = Read-Host "Enter your choice (1-5)"

switch ($choice) {
    "1" {
        Write-Host "Starting Web app on Chrome..." -ForegroundColor Green
        Set-Location "f:\dev2025\agent_exam\flutter_items_app"
        flutter run -d chrome
    }
    "2" {
        Write-Host "Starting Windows Desktop app..." -ForegroundColor Green
        Set-Location "f:\dev2025\agent_exam\flutter_items_app"
        flutter run -d windows
    }
    "3" {
        Write-Host "Building Web app..." -ForegroundColor Green
        Set-Location "f:\dev2025\agent_exam\flutter_items_app"
        flutter build web
        Write-Host "Build completed! Output in build/web/" -ForegroundColor Green
    }
    "4" {
        Write-Host "Building Windows app..." -ForegroundColor Green
        Set-Location "f:\dev2025\agent_exam\flutter_items_app"
        flutter build windows
        Write-Host "Build completed! Output in build/windows/" -ForegroundColor Green
    }
    "5" {
        Write-Host "This will require multiple terminals. Please use VS Code tasks instead." -ForegroundColor Yellow
        Write-Host "Use: Tasks -> Run Task -> flutter-run-web or flutter-run-windows" -ForegroundColor Cyan
    }
    default {
        Write-Host "Invalid choice!" -ForegroundColor Red
    }
}
