@echo off
title Mukai Translate - Configuracion Automatica
cd /d "%~dp0"

echo.
echo  ============================================
echo   MUKAI TRANSLATE - Configuracion Automatica
echo  ============================================
echo.

REM ── PASO 1: Python 3.12 ──────────────────────────────────────────────
set PYTHON_CMD=

python -c "import sys; exit(0 if sys.version_info>=(3,12) else 1)" >nul 2>&1
if not errorlevel 1 (
    set PYTHON_CMD=python
    goto :python_ok
)

py -3.12 --version >nul 2>&1
if not errorlevel 1 (
    set PYTHON_CMD=py -3.12
    goto :python_ok
)

echo [INFO] Python 3.12 no encontrado. Instalando...

winget install --id Python.Python.3.12 --silent --accept-package-agreements --accept-source-agreements >nul 2>&1

if errorlevel 1 (
    echo [INFO] Descargando instalador de Python 3.12...
    powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe' -OutFile '%TEMP%\python312.exe'"
    "%TEMP%\python312.exe" /quiet InstallAllUsers=0 PrependPath=1 Include_test=0
    del "%TEMP%\python312.exe" >nul 2>&1
)

set "PATH=%LOCALAPPDATA%\Programs\Python\Python312;%LOCALAPPDATA%\Programs\Python\Python312\Scripts;%PATH%"
set "PATH=%PROGRAMFILES%\Python312;%PROGRAMFILES%\Python312\Scripts;%PATH%"

python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] No se pudo instalar Python. Descargalo desde https://www.python.org/downloads/
    pause
    exit /b 1
)
set PYTHON_CMD=python

:python_ok
echo [OK] Python listo.

REM ── PASO 2: uv ───────────────────────────────────────────────────────
uv --version >nul 2>&1
if not errorlevel 1 goto :uv_ok

echo [INFO] Instalando uv...
%PYTHON_CMD% -m pip install uv --quiet

set "PATH=%LOCALAPPDATA%\Programs\Python\Python312\Scripts;%APPDATA%\Python\Python312\Scripts;%PATH%"

uv --version >nul 2>&1
if not errorlevel 1 goto :uv_ok

echo [INFO] Intentando instalar uv con PowerShell...
powershell -NoProfile -Command "irm https://astral.sh/uv/install.ps1 | iex" >nul 2>&1
set "PATH=%USERPROFILE%\.local\bin;%USERPROFILE%\.cargo\bin;%PATH%"

uv --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] No se pudo instalar uv.
    pause
    exit /b 1
)

:uv_ok
echo [OK] uv listo.

REM ── PASO 3: Dependencias ─────────────────────────────────────────────
echo [INFO] Instalando dependencias (la primera vez puede tardar varios minutos)...
uv sync
if errorlevel 1 (
    echo [ERROR] Fallo al instalar dependencias.
    pause
    exit /b 1
)
echo [OK] Dependencias listas.

REM ── PASO 4: Claves de API ────────────────────────────────────────────
set "GEMINI_API_KEY=YOUR_GEMINI_API_KEY_HERE"
set "GEMINI_MODEL=gemini-3.1-flash-lite-preview"
set "OPENAI_API_KEY=YOUR_OPENAI_API_KEY_HERE"
set "DEEPSEEK_API_KEY=YOUR_DEEPSEEK_API_KEY_HERE"
set "CUSTOM_OPENAI_API_KEY=YOUR_CUSTOM_OPENAI_API_KEY_HERE"
set "CUSTOM_OPENAI_API_BASE=https://api.x.ai/v1"
set "CUSTOM_OPENAI_MODEL=grok-4-1-fast-reasoning"

REM ── PASO 5: Suprimir warnings de librerias incompatibles con 3.12 ────
set "PYTHONWARNINGS=ignore::SyntaxWarning,ignore::DeprecationWarning"

REM ── PASO 6: Iniciar ──────────────────────────────────────────────────
echo.
echo [OK] Todo listo. Iniciando Mukai Translate...
echo.
uv run --python 3.12 python -W ignore::SyntaxWarning -W ignore::DeprecationWarning mukai.py %*

if errorlevel 1 (
    echo.
    echo [ERROR] La aplicacion cerro con un error inesperado.
    pause
)