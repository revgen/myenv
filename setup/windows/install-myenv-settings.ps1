# ==================================================================================
# To download it with PowerShell use a command:
# wget https://raw.githubusercontent.com/revgen/myenv/master/setup/windows/install-myenv-settings.ps1 -OutFile install-myenv-settings.ps1
# ==================================================================================

$ErrorActionPreference = "Stop"

$repo = "https://raw.githubusercontent.com/revgen/myenv/master"

function download($url, $output) {
    Write-Host "Downloading  file '${url}'..."
    Write-Host "  Output to ${output}"
    $dir = [System.IO.Path]::GetDirectoryName("${output}")
    New-Item -ItemType Directory -Force -Path "${dir}" | Out-Null
    wget "${url}" -OutFile "${output}"
    Write-Host "  Done, ${output} saved"
}

download "${repo}/setup/windows/userprofile/profile.ps1" "$env:USERPROFILE\Documents\WindowsPowerShell\profile.ps1"
download "${repo}/setup/windows/userprofile/profile" "$env:USERPROFILE\.profile"
download "${repo}/setup/windows/userprofile/bashrc" "$env:USERPROFILE\.bashrc"
download "${repo}/setup/windows/userprofile/minttyrc" "$env:USERPROFILE\.minttyrc"
download "${repo}/setup/windows/userprofile/minttyrc.admin" "$env:USERPROFILE\.minttyrc.admin"
download "${repo}/setup/windows/userprofile/mintty.admin.cmd" "$env:USERPROFILE\.mintty.admin.cmd"

download "${repo}/home/.gitconfig" "$env:USERPROFILE\.gitconfig"
download "${repo}/home/.vimrc" "$env:USERPROFILE\.vimrc"
download "${repo}/home/.vim/colors/dracula.vim" "$env:USERPROFILE\vimfiles\colors\dracula.vim"
download "${repo}/home/.vim/colors/dracula.vim" "$env:USERPROFILE\.vim\colors\dracula.vim"

download "${repo}/.vscode/settings.json" "$env:APPDATA\Code\User\settings.json"

# Download additional settings to the ~/Downloads directory
download "${repo}/setup/windows/settings/add-open-with-powershell.reg" "$env:USERPROFILE\Downloads\add-open-with-powershell.reg"
download "${repo}/setup/windows/install-chocolatey.ps1" "$env:USERPROFILE\Downloads\install-chocolatey.ps1"
download "${repo}/setup/windows/install-core-tools.ps1" "$env:USERPROFILE\Downloads\install-core-tools.ps1"


# == Special settings ====================================================================

# Settings for GIT
git config --global difftool.gvimdiff.cmd 'gvim -c \":set columns=200 lines=50\" -d \"$LOCAL\" \"$REMOTE\"'
git config --global diff.tool gvimdiff
# Fix: git: 'credential-cache' is not a git command
git config --global credential.helper wincred

