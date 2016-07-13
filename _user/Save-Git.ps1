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
    $o = $Info.Options.Git
    $repo = if ( $o.UserName ) { $o.Repository -replace '://', ('$0{0}:{1}@' -f $o.UserName, $o.Password) } else { $o.Repository }
    git push $repo
    popd
}
