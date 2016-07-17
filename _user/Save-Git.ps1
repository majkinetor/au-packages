function Save-Git() {
    $pushed = $Info.result.pushed
    if (!$Info.pushed) { "Git: no package is pushed to chocolatey, skipping"; return }

    "`nExecuting git pull"
    git checkout master
    git pull

    "Commiting updated packages to git repository"
    $pushed | % { git add $_.PackageName }
    git commit -m "UPDATE BOT: $($Info.pushed) packages updated"

    "`nPushing git changes"
    $repository = git ls-remote --get-url
    $o = $Info.Options.Git
    $repo = if ( $o.UserName ) { $repository -replace '://', ('$0{0}:{1}@' -f $o.UserName, $o.Password) } else { $repository }
    git push $repo
}
