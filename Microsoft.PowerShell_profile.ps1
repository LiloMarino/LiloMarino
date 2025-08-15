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
Set-PSReadLineKeyHandler -Chord Ctrl+RightArrow -Function ForwardWord

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
Set-Alias treeunix "C:\ProgramData\chocolatey\bin\tree.exe"

function sha256 { param($file) certutil -hashfile $file SHA256 }
function md5    { param($file) certutil -hashfile $file MD5 }

function cat_files {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Files
    )

    if (-not $Files -or $Files.Count -eq 0) {
        Write-Output "Uso: cat_files <arquivo1> <arquivo2> ..."
        return
    }

    foreach ($file in $Files) {
        $path = Resolve-Path -LiteralPath $file -ErrorAction SilentlyContinue

        if (-not $path) {
            Write-Output "Erro: Arquivo '$file' não encontrado."
            continue
        }

        $filePath = $path.ProviderPath
        $fileName = [System.IO.Path]::GetFileName($filePath)

        Write-Output "$fileName"
        try {
            Get-Content -Path $filePath -Raw -Encoding UTF8
        }
        catch {
            Write-Output "Erro ao ler '$filePath': $_"
        }
    }
}

function clip_files {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Files
    )

    if (-not $Files -or $Files.Count -eq 0) {
        Write-Output "Uso: clip_files <arquivo1> <arquivo2> ..."
        return
    }

    $content = ""
    foreach ($file in $Files) {
        $path = Resolve-Path -LiteralPath $file -ErrorAction SilentlyContinue
        if (-not $path) {
            Write-Output "Erro: Arquivo '$file' não encontrado."
            continue
        }
        $filePath = $path.ProviderPath
        $fileName = [System.IO.Path]::GetFileName($filePath)
        $content += "$fileName`n"
        try {
            $content += (Get-Content -Path $filePath -Raw -Encoding UTF8) + "`n"
        }
        catch {
            $content += "Erro ao ler '$filePath': $_`n"
        }
    }
    $content | Set-Clipboard
    Write-Output "Conteúdo copiado para o clipboard."
}
