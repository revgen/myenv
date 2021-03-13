# ==================================================================================
# To download it with PowerShell use a command:
# Invoke-WebRequest https://raw.githubusercontent.com/revgen/myenv/master/setup/windows/install-myenv-settings.ps1 -OutFile install-myenv-settings.ps1
# ==================================================================================

$ErrorActionPreference = "Stop"

$repo = "https://raw.githubusercontent.com/revgen/myenv/master"
$dest = $env:USERPROFILE

function createDirectory($dirPath) {
    Write-Host "Create directory ${dirPath}"
    New-Item -ItemType Directory -Force -Path "${dirPath}" | Out-Null
}

function download($url, $output) {
    Write-Host "Downloading  file '${url}'..."
    Write-Host "  Output to ${output}"
    $dir = [System.IO.Path]::GetDirectoryName("${output}")
    createDirectory "${dir}"
    Invoke-WebRequest "${url}" -OutFile "${output}"
    Write-Host "  Done, ${output} saved"
}

Write-Host "Download all settings and script into the '${dest}' directory..."

download "${repo}/setup/windows/userprofile/Documents/WindowsPowerShell/profile.ps1" "${dest}\Documents\WindowsPowerShell\profile.ps1"
download "${repo}/setup/windows/userprofile/.bash_profile" "${dest}\.bash_profile"
download "${repo}/setup/windows/userprofile/.bashrc" "${dest}\.bashrc"
download "${repo}/setup/windows/userprofile/.minttyrc" "${dest}\.minttyrc"
createDirectory "${dest}/AppData/Roaming/bin"
createDirectory "${dest}/Workspace"

download "${repo}/home/.gitconfig" "${dest}\.gitconfig"
download "${repo}/home/.vimrc" "${dest}\.vimrc"
download "${repo}/home/.vim/colors/dracula.vim" "${dest}\vimfiles\colors\dracula.vim"
download "${repo}/home/.vim/colors/dracula.vim" "${dest}\.vim\colors\dracula.vim"

download "${repo}/.vscode/settings.json" "${dest}\AppData\Roaming\Code\User\settings.json"

# Download additional settings to the ~/Downloads directory
#download "${repo}/setup/windows/settings/add-open-with-powershell.reg" "$env:USERPROFILE\Downloads\add-open-with-powershell.reg"
download "${repo}/setup/windows/install-chocolatey.ps1" "${dest}\Downloads\install-chocolatey.ps1"
download "${repo}/setup/windows/install-core-tools.ps1" "${dest}\Downloads\install-core-tools.ps1"


# == Special settings ====================================================================

# Settings for GIT
# Settings for gvimdiff tool
git config --global difftool.gvimdiff.cmd 'gvim -c \":set columns=200 lines=50\" -d \"$LOCAL\" \"$REMOTE\"'

# Settings for Compare It! v3 tool (default tool for diff and merge)
git config --global difftool.compareit.cmd 'wincmp3.exe \"$LOCAL\" //=\"Old Version\" \"$REMOTE\"'
git config --global diff.tool compareit
git config --global mergetool.compareit.cmd 'wincmp3.exe \"$LOCAL\" //=\"Old Version\" \"$REMOTE\"'
git config --global mergetool.compareit.trustExitCode false
git config --global merge.tool compareit

# Fix: git: 'credential-cache' is not a git command
git config --global credential.helper wincred

