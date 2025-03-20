# . "C:\Users\sampa\projects\settings\window_settings.ps1"
function Get-GitStatus { git status } 
Set-Alias -Name stt -Value Get-GitStatus


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

# Export the function to be available in the session
# Export-ModuleMember -Function gacp
