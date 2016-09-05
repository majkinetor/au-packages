function Save-Git() {
    $pushed = $Info.result.pushed
    if (!$Info.pushed) { "Git: no package is pushed to Chocolatey community feed, skipping"; return }

    ""
    "Executing git pull"
    git checkout master
    git pull

    "Commiting updated packages to git repository"
    $pushed | % { git add $_.PackageName }

    $s = if ($Info.pushed -gt 1) { 's' } else { '' }
    git commit -m "UPDATE BOT: $($Info.pushed) package${s} updated [skip ci]"

    "Pushing git changes"
    git push
}
