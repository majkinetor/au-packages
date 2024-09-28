#require -version 3.0

<#
.SYNOPSIS
    Clear all event logs
#>
function Clear-EventLogs {
  Get-EventLog * | ForEach-Object {
    try {
      Clear-EventLog $_.Log
    }
    catch {
      Write-Warning 'Error during clearing event logs'
      Write-Warning "$_"
    }
  }

  #Clear this one again as it accumulates clearing events from previous step
  try {
    Clear-EventLog System
  }
  catch {
    Write-Warning 'Error during clearing event logs'
    Write-Warning "$_"
  }
  Get-EventLog *
}

<#
.SYNOPSIS
    Get latest event logs across all event logs
.Example
    logs Error,Warning -Newest 5
#>
function Get-EventLogs {
  param(
    [ValidateSet('Error', 'Information', 'Warning', '*')]
    [string[]] $EntryType = 'Error',

    [int] $Newest = 1000,

    [switch] $Raw
  )
  $r = @()

  if ($EntryType -eq '*') { $EntryType = 'Error', 'Information', 'Warning' }
  Get-EventLog * | ForEach-Object Log | ForEach-Object {
    $log = $_
    try {
      $r += Get-EventLog -Log $log -Newest $Newest -EntryType $EntryType -ea 0
    }
    catch { Write-Warning "$log - $_" }
  }
  $r = $r | Sort-Object TimeWritten -Descending
  if ($Raw) { $r } else { $r | Select-Object Source, TimeWritten, Message }
}

Set-Alias logs Get-EventLogs
Set-Alias clearlogs Clear-EventLogs
