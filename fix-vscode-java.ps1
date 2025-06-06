# VS Code Java Configuration Fix
Write-Host "=== Fixing VS Code Java Configuration ===" -ForegroundColor Green

# Create VS Code workspace settings for Java
$settingsPath = "f:\dev2025\agent_exam\.vscode\settings.json"
$javaPath = "C:\\Program Files\\Android\\Android Studio\\jbr"

Write-Host "Updating VS Code settings..." -ForegroundColor Yellow

# Read current settings
if (Test-Path $settingsPath) {
    $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
} else {
    $settings = @{}
}

# Add Java configuration
$settings | Add-Member -NotePropertyName "java.jdt.ls.java.home" -NotePropertyValue $javaPath -Force
$settings | Add-Member -NotePropertyName "java.configuration.runtimes" -NotePropertyValue @(
    @{
        "name" = "JavaSE-17"
        "path" = $javaPath
    },
    @{
        "name" = "JavaSE-21"
        "path" = $javaPath
    }
) -Force

# Add terminal environment
if (-not $settings."terminal.integrated.env.windows") {
    $settings | Add-Member -NotePropertyName "terminal.integrated.env.windows" -NotePropertyValue @{} -Force
}
$settings."terminal.integrated.env.windows" | Add-Member -NotePropertyName "JAVA_HOME" -NotePropertyValue $javaPath -Force

# Save settings
$settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8

Write-Host "✓ Updated VS Code settings" -ForegroundColor Green

# Set system environment variable
Write-Host "Setting system JAVA_HOME..." -ForegroundColor Yellow
[Environment]::SetEnvironmentVariable("JAVA_HOME", $javaPath, "User")
Write-Host "✓ Set JAVA_HOME permanently" -ForegroundColor Green

Write-Host "`n=== Instructions ===" -ForegroundColor Cyan
Write-Host "1. Please restart VS Code completely (close all windows)" -ForegroundColor White
Write-Host "2. Reopen the workspace" -ForegroundColor White
Write-Host "3. The Java version errors should be resolved" -ForegroundColor White
Write-Host "`nIf errors persist, run this command in VS Code terminal:" -ForegroundColor Yellow
Write-Host "`$env:JAVA_HOME='$javaPath'" -ForegroundColor Green
