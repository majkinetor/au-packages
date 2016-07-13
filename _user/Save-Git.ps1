function save-git() {
    $pushed = $Info.result.pushed
    if (!($pushed -and $pushed.Count)) { "Git: no package is pushed to chocolatey, skipping"; return }

    pushd $PSScriptRoot

    "`nExecuting git pull"
    git checkout master
    git pull

    "Commiting updated packages to git repository"
    $pushed | % { git add $_.PackageName }
    git commit -m "UPDATE BOT: $($pushed.Count) packages updated"

    "`nPushing git changes"
    git push "https://$Env:github_user:$Env:github_pass@github.com/majkinetor/chocolatey.git"
    popd
}
