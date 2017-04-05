# For the list of all environment vars run `gitlab-runner register --help`

$Env:CONFIG_FILE                = "$PSScriptRoot\config.toml"
$Env:REGISTRATION_TOKEN         = ''
$Env:CI_SERVER_URL              = ''
$Env:RUNNER_NAME                = ''
$Env:RUNNER_TAG_LIST            = ''
$Env:REGISTER_RUN_UNTAGGED      = 'false'
$Env:RUNNER_EXECUTOR            = 'shell'
$Env:SHELL                      = 'powershell'
$Env:RUNNER_REQUEST_CONCURRENCY = 1
$Env:RUNNER_BUILDS_DIR          = ''
$Env:RUNNER_CACHE_DIR           = ''

gitlab-runner register --non-interactive
