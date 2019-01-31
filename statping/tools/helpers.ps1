function Install-Service($ExePath) {
    $exeName = (Split-Path $ExePath -Leaf) -replace '\.exe$'
    Write-Host "Installing service '$exeName'"
  
    nssm install $exeName $ExePath 
    if ($pp.Service -ne 0) {
        Write-Host "Starting service"
        Start-Service $exeName
    }
  }
  