# == Default system settings ==================================================
# Allow all version of SSL protocols for Invoke-WebRequest method
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

# == Static variables =========================================================
# Specify 'WORKSPACE' system environment variable with your project directory
# path. The default value is ~/Documents.
if (Test-Path env:WORKSPACE) { $WS = (get-item env:WORKSPACE ).Value }
else { $WS = [Environment]::GetFolderPath("MyDocuments") }

# == Functions ================================================================
function dirSize($path) {
    if (!$path) {
        $path = Get-Location
    }
    Write-Host "Calculate size of the '$path' directory..."
    $sizeMD=(Get-ChildItem "$path" -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum
    $sizeStr = "{0:N2} MB" -f ($sizeMD / 1MB)
    Write-Host "$sizeStr - $path"
}
function openExplorer($path) {
    if (!$path) {
        $path = Get-Location
    }
    explorer "${path}"
}
function runVimDiff($file1, $file2) {
    gvim -c ":set columns=200 lines=50" -d "${file1}" "${file2}"
}
function runExit() { [Environment]::Exit(0) }
function cdToWorkspace() { Set-Location $WS }
function runAs() { Start-Process PowerShell -Verb RunAs }
function runTig() { git tig }
function runSnakeTail($file) { & "$env:PROGRAMFILES\SnakeTail\SnakeTail.exe" "$file"}
function runMidnightCommander() { & "C:\Program Files (x86)\Midnight Commander\mc.exe" "$WS" }
function runGitBash() { & "$env:PROGRAMFILES\Git\git-bash.exe" }
# vim -d
function runVimDiff() { runMeld }
function resetPS() { [Console]::ResetColor(); cls }


# == Aliases ==================================================================
Set-Alias -Name :q      -Value runExit
Set-Alias -Name ll      -Value ls
Set-Alias -Name c       -Value cls
Set-Alias -Name ws      -Value cdToWorkspace
Set-Alias -Name su      -Value runAs
Set-Alias -name du      -Value dirSize
Set-Alias -name du0     -Value dirSize
Set-Alias -name open-explorer -Value openExplorer
Set-Alias -Name reset   -Value resetPS

Set-Alias -Name apk     -Value choco
Set-Alias -Name apt     -Value choco

Set-Alias -Name vscode  -Value code
Set-Alias -Name mc      -Value runMidnightCommander
Set-Alias -Name bash    -Value runGitBash

Set-Alias -Name top     -Value taskmgr
Set-Alias -Name tig     -Value runTig
Set-Alias -Name tail    -Value runSnakeTail
Set-Alias -Name vimdiff -Value runVimDiff

Set-Alias -Name cd      -Value pushd  -Option AllScope
Set-Alias -Name bd      -Value popd  -Option AllScope

# == Local profile script =====================================================
$localProfile = "$PSScriptRoot\profile.local.ps1"
if ([System.IO.File]::Exists($localProfile)) {
    & "$localProfile"
}
