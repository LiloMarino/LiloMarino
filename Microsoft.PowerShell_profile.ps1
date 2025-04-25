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
Set-Alias ll Get-ChildItem
Set-Alias la "Get-ChildItem -Force"
Set-Alias grep Select-String
Set-Alias tail Get-Content
Set-Alias cat Get-Content
Set-Alias md5 Get-FileHash
Set-Alias sha256 'Get-FileHash -Algorithm SHA256'