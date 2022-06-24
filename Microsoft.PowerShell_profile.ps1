Import-Module -Name Terminal-Icons

oh-my-posh --init --shell pwsh --config "E:\My Stuff\oh-my-posh themes\custom-oh-my-posh.omp - stable.json" | Invoke-Expression

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Vi

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

function makefile {
    New-Item -Path $args -ItemType File
}

function git-prep {
    Write-Host 'Current repository status:'
    git status
    Write-Host 'Logging file changes to git....' -NoNewLine
    git add -A
    Write-Host 'done!'
    Write-Host 'Renewed repository tracking status:'
    git status
}

function git-prep-push {
    Write-Host 'Last commit message was: '
    git log -1 --pretty=%B
    $commit = Read-Host "Enter new commit message"
    Write-Host 'Current repository status:'
    git status
    Write-Host 'Logging file changes to git...'
    git add -A
    Write-Host 'done!'
    Write-Host 'Renewed repository tracking status:'
    git status
    Write-Host 'Adding commit message: $commit ...'
    git commit -m $commit
    Write-Host 'done!'
    Write-Host 'Pushing changes to branch...'
    git push
    Write-Host 'done!'
}

function xenv {vim $PROFILE}
function xvim {vim "C:\Users\Morpheus\_vimrc"}
function bsauce {. $PROFILE}

Set-Alias -Name git-set -Value git-prep
Set-Alias -Name git-set-push -Value git-prep-push
Set-Alias -Name touch -Value makefile
