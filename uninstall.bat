@echo off
rem Double-click to uninstall PBZ Auto Sprint.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0uninstall.ps1" %*
