@echo off
title 🚀 Portfolio Auto Setup + GitHub Pages
cd /d %~dp0

echo.
echo ==========================================
echo 🔧 Setting up your portfolio project...
echo ==========================================
echo.

:: === Step 1: Create files if missing ===
if not exist index.html (
    echo 📝 Creating index.html
    echo ^<!DOCTYPE html^> > index.html
    echo ^<html lang="en"^> >> index.html
    echo ^<head^> >> index.html
    echo     ^<meta charset="UTF-8" /^> >> index.html
    echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0" /^> >> index.html
    echo     ^<title^>My Portfolio^</title^> >> index.html
    echo     ^<link rel="stylesheet" href="style.css" /^> >> index.html
    echo ^</head^> >> index.html
    echo ^<body^> >> index.html
    echo     ^<h1^>Welcome to My Portfolio^</h1^> >> index.html
    echo     ^<script src="script.js"^>^</script^> >> index.html
    echo ^</body^> >> index.html
    echo ^</html^> >> index.html
)

if not exist style.css (
    echo 🎨 Creating style.css
    echo body { >> style.css
    echo   font-family: Arial, sans-serif; >> style.css
    echo   text-align: center; >> style.css
    echo   margin-top: 50px; >> style.css
    echo   background: #f9f9f9; >> style.css
    echo   color: #333; >> style.css
    echo } >> style.css
)

if not exist script.js (
    echo ⚡ Creating script.js
    echo console.log("🚀 Portfolio script loaded!"); > script.js
)

:: === Step 2: Initialize Git ===
if not exist .git (
    echo 🧠 Initializing Git repository...
    git init
    git branch -M main
)

:: === Step 3: Commit changes ===
git add .
git commit -m "Initial portfolio setup"

:: === Step 4: Set up remote ===
git remote -v >nul 2>nul
if %errorlevel% neq 0 (
    echo 🔗 Adding remote GitHub repository...
    set /p repo="Enter your GitHub repo URL (e.g. git@github.com:intelectsam/my-portfolio.git): "
    git remote add origin %repo%
)

:: === Step 5: Push to GitHub ===
echo 🚀 Pushing to GitHub...
git push -u origin main

:: === Step 6: Enable GitHub Pages via API ===
echo 🌐 Enabling GitHub Pages automatically...
set /p token="Enter your GitHub Personal Access Token (with repo rights): "

:: Extract username and repo from remote
for /f "tokens=2 delims=:@/" %%a in ('git remote get-url origin') do set username=%%a
for /f "tokens=3 delims=:/." %%b in ('git remote get-url origin') do set reponame=%%b

:: Use curl to call GitHub API
curl -L -X PUT ^
  -H "Accept: application/vnd.github+json" ^
  -H "Authorization: Bearer %token%" ^
  -H "X-GitHub-Api-Version: 2022-11-28" ^
  https://api.github.com/repos/%username%/%reponame%/pages ^
  -d "{\"source\":{\"branch\":\"main\",\"path\":\"/\"}}"

echo.
echo ✅ GitHub Pages activated!
echo 🌍 Your site will be live at: https://%username%.github.io/%reponame%
echo ==========================================
pause
