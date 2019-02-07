# Source: https://chocolatey.org/docs/installation
$ErrorActionPreference = "Stop"

Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco upgrade chocolatey
