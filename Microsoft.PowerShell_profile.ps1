# Ativa o tema do Oh My Posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\star.omp.json" | Invoke-Expression

# Módulos adicionais
Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module PSReadLine

# Autocompletar com estilo ZSH
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -EditMode Windows

# Teclas de navegação com autocompletar no estilo menu
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Atalhos e aliases estilo Unix
Set-Alias ll "Get-ChildItem -Force -l"
Set-Alias la "Get-ChildItem -Force"
Set-Alias l "Get-ChildItem"
Set-Alias c "Clear-Host"
Set-Alias cat Get-Content
Set-Alias touch New-Item
Set-Alias tail "Get-Content -Tail 20 -Wait"
Set-Alias grep Select-String
Set-Alias mv Move-Item
Set-Alias rm Remove-Item
Set-Alias which Get-Command
Set-Alias pwd Get-Location
