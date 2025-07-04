# . "C:\Users\sampa\projects\settings\window_settings.ps1"
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
function Get-GitStatus { git status } 
Set-Alias -Name stt -Value Get-GitStatus

function Get-GitStatusuno { git status -uno } 
Set-Alias -Name sttu -Value Get-GitStatusuno

function gacp {
    param (
        [string]$message
    )

    git add .
    git commit -m $message
    git push
}

function gacpp {
    param (
        [string]$message
    )
    git add .
    git commit -m $message
    git pull origin $(git rev-parse --abbrev-ref HEAD)
    git push
}

function Invoke-GitCheckout {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        $Args
    )
    git checkout @Args
}
Set-Alias -Name cot -Value Invoke-GitCheckout

function Invoke-GitCommit {
    param (
        [string]$message
    )
    git commit -m $message
}
Set-Alias -Name ct -Value Invoke-GitCommit
