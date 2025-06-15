@echo off
setlocal

echo ================================
echo ≡ Terraform Git Cleanup Script
echo ================================

:: Step 1: Check Python existence
where python >nul 2>&1
if errorlevel 1 (
    echo ❌ Python not found in PATH.
    echo Please install Python and add it to PATH before continuing.
    pause
    exit /b
) else (
    echo ✅ Python found.
)

:: Step 2: Check git-filter-repo availability
git filter-repo --help >nul 2>&1
if errorlevel 1 (
    echo ❌ git-filter-repo not found.
    echo Installing git-filter-repo via pip...
    python -m pip install --upgrade pip setuptools wheel
    python -m pip install git-filter-repo
    if errorlevel 1 (
        echo ❌ Installation failed. Please install manually.
        pause
        exit /b
    ) else (
        echo ✅ git-filter-repo installed successfully.
    )
) else (
    echo ✅ git-filter-repo is installed.
)

:: Step 3: Ask user to manually check PATH
echo.
echo Please ensure the folder C:\Python313\Scripts is added to your User PATH environment variable.
echo You can add it manually via System Properties > Environment Variables.
echo This is required for git-filter-repo to work correctly.
echo Press any key to continue...
pause >nul

:: Step 4: Confirm before running git filter-repo
echo.
echo WARNING: This will remove the '.terraform' folder from your git history.
echo Make sure you have backed up your repo or committed everything.
echo Do you want to proceed? (Y/N)
set /p confirm=

if /I "%confirm%"=="Y" (
    git filter-repo --path .terraform --invert-paths
    if errorlevel 1 (
        echo ❌ git filter-repo failed. Please check errors.
        pause
        exit /b
    ) else (
        echo ✅ Cleanup complete!
    )
) else (
    echo Cleanup cancelled.
)

echo.
echo Please restart your terminal to apply any PATH changes.
pause
