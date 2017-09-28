Get-Service gitlab-runner -ea 0 | Stop-Service
ps gitlab-runner -ea 0 | kill
