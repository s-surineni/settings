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

# Export the function to be available in the session
# Export-ModuleMember -Function gacp
