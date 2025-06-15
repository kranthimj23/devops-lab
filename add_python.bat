@echo off
setlocal

echo ================================
echo 🔧 Add Python Scripts to PATH
echo ================================

set "PY_SCRIPTS_PATH=C:\Python313\Scripts"

if not exist "%PY_SCRIPTS_PATH%" (
    echo ❌ Folder not found: %PY_SCRIPTS_PATH%
    echo Please check if Python Scripts folder exists.
    pause
    exit /b
)

echo 🛠 Updating PATH...
powershell -Command ^
 "[Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | foreach { $_.Trim() } | where { \$_ -ne '' } | Set-Variable -Name paths;" ^
 "; if ($paths -notcontains '%PY_SCRIPTS_PATH%') { \$newpath = (\$paths + '%PY_SCRIPTS_PATH%') -join ';'; [Environment]::SetEnvironmentVariable('Path', \$newpath, 'User'); Write-Host '✅ Python Scripts folder added to PATH.' } else { Write-Host 'ℹ️ Python Scripts folder is already in PATH.' }"

echo ✅ Done. Please restart PowerShell or Command Prompt to apply changes.
pause
