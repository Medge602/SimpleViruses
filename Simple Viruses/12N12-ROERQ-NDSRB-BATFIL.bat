@echo off
title Simple Unlocker
color 0A

:menu
cls
echo ============================================
echo       SIMPLE UNLOCKER - Process Manager
echo ============================================
echo.
echo   [1] Show all processes
echo   [2] Kill process by name
echo   [3] Kill process by PID
echo   [4] Search process
echo   [5] Force kill (with child processes)
echo   [0] Exit
echo.
set /p choice="Select action (0-5): "

if "%choice%"=="1" goto show
if "%choice%"=="2" goto killname
if "%choice%"=="3" goto killpid
if "%choice%"=="4" goto search
if "%choice%"=="5" goto force
if "%choice%"=="0" exit
goto menu

:show
cls
echo ========== ALL PROCESSES ==========
echo.
tasklist
echo.
echo Press any key...
pause >nul
goto menu

:killname
cls
echo ========== KILL BY NAME ==========
echo.
tasklist
echo.
set /p name="Enter process name (e.g., notepad.exe): "
if "%name%"=="" goto menu
echo.
taskkill /f /im "%name%" 2>nul
if %errorlevel%==0 (
    echo [OK] Process %name% terminated!
) else (
    echo [ERROR] Failed to terminate %name%
)
echo.
pause
goto menu

:killpid
cls
echo ========== KILL BY PID ==========
echo.
tasklist
echo.
set /p pid="Enter PID: "
if "%pid%"=="" goto menu
echo.
taskkill /f /pid %pid% 2>nul
if %errorlevel%==0 (
    echo [OK] Process with PID %pid% terminated!
) else (
    echo [ERROR] Failed to terminate PID %pid%
)
echo.
pause
goto menu

:search
cls
echo ========== SEARCH PROCESS ==========
echo.
set /p search="Enter name to search: "
if "%search%"=="" goto menu
echo.
echo Search results for "%search%":
echo ----------------------------------------
tasklist | find /i "%search%"
if errorlevel 1 echo Nothing found.
echo.
pause
goto menu

:force
cls
echo ========== FORCE TERMINATE ==========
echo WARNING! This may cause data loss!
echo.
tasklist
echo.
set /p name2="Enter process name: "
if "%name2%"=="" goto menu
echo.
set /p confirm="Are you sure? (Y/N): "
if /i not "%confirm%"=="Y" goto menu
echo.
taskkill /f /im "%name2%" /t 2>nul
if %errorlevel%==0 (
    echo [OK] Process %name2% and child processes terminated!
) else (
    echo [ERROR] Failed to terminate %name2%
)
echo.
pause
goto menu