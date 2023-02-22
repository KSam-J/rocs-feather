# Use l as and alias for dir/ls
New-Alias l ls

# Make tab completion more like bash
Set-PSReadlineKeyHandler -Key Tab -Function Complete

# SVN environment variables
$env:SVN_EDITOR='vim'

function get-revision
{
    ((svn log --limit 1 | Select-String -Pattern "r[0-9]{1,5}" -AllMatches).Matches.Value | Select-String -Pattern "[0-9]{1,5}" -AllMatches).Matches.Value
}

function prompt
{
    if (svn info)
    {
        Write-Host ("(" + $(svn info --show-item revision) + ")") -NoNewLine -ForegroundColor DarkGray
        Write-Host ($(svn info --show-item relative-url) + ":" ) -nonewline -foregroundcolor Yellow
	Write-Host ($(get-revision) +">") -nonewline -foregroundcolor Blue
    return " "
    }
    else
    {
    Write-Host ("PS " + $(Get-Location) +">") -nonewline -foregroundcolor Yellow
    return " "
    }
}

function uicgui {cd E:\repos\ledilluminator\uic-gui\}

Set-Alias -Name sed -Value C:\"Program Files"\Git\usr\bin\sed.exe
Set-Alias -Name grep -Value C:\"Program Files"\Git\usr\bin\grep.exe
