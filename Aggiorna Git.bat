@echo off
cd /d %~dp0

echo ==========================================
echo   PUSH AUTOMATICO GITHUB (INSERISCI LINK)
echo ==========================================
echo.

:: Chiede il link del repository
set /p REPO_URL=Inserisci il link del repository GitHub:

if "%REPO_URL%"=="" (
echo Nessun link inserito. Operazione annullata.
pause
exit /b
)

:: Inizializza repo
git init

:: Imposta origin con il link inserito
git remote remove origin >nul 2>&1
git remote add origin %REPO_URL%

:: Imposta branch main
git branch -M main

:: Aggiunge file
git add .

:: Controlla modifiche
git diff --cached --quiet
if %errorlevel%==0 (
echo Nessuna modifica da caricare.
pause
exit /b
)

:: Data e ora commit
for /f "tokens=1-3 delims=/.- " %%a in ("%date%") do set d1=%%a& set d2=%%b& set d3=%%c
for /f "tokens=1-2 delims=:." %%a in ("%time%") do set t1=%%a& set t2=%%b

git commit -m "Update bot %d1%-%d2%-%d3% %t1%-%t2%"

:: Pull e push
git pull origin main --rebase
git push -u origin main

echo.
echo Aggiornamento completato!
pause
