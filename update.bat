@echo off
REM === Git Auto Commit & Push Script for Windows ===
REM Usage: Double-click or run: git_update.bat "Your commit message"

title Git Auto Update

cd /d %~dp0

if not exist .git (
  echo ❌ Not a git repository. Please run inside your project folder.
  pause
  exit /b
)

git add .

set msg=%1
if "%msg%"=="" set msg=Auto update on %date% %time%

echo 🔄 Committing changes with message: "%msg%"
git commit -m "%msg%"

echo 🚀 Pushing to GitHub...
git push origin main

echo.
echo ✅ Successfully committed and pushed!
echo -----------------------------
