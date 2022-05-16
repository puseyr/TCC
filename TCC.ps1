Set-ExecutionPolicy -ExecutionPolicy Unrestricted
$ExecutionContext.SessionState.LanguageMode = "FullLanguage"

$UserCredential = Get-Credential

Write-host "Teams Cache Cleaner" -ForegroundColor Blue
#$user = Read-Host "`nEnter current userName"
<#
@("Outlook") | 
ForEach-Object 
{
  if((Get-Process $_ -ErrorAction SilentlyContinue) -eq $null) 
  {Write-Host "$_ not running"} 
  else 
  {Write-Host "$_ is running"}
}
#>

<## get teams process
$teams = Get-Process -Name Teams -ErrorAction SilentlyContinue
if ($teams) {
  # try gracefully first
  $teams.CloseMainWindow()
  # kill after five seconds

  Start-Sleep -Seconds 5

if (!$teams.HasExited) {
  Stop-Process $teams -Force
  $teams | Stop-Process -Force
  }
}
Remove-Variable Teams
#>
$termproc = (get-wmiobject -ComputerName $server -Class Win32_Process -Filter "name like 'Teams'"$termproc.terminate())

Get-ChildItem -Path "C:\Users\puseyr\AppData\Roaming\Microsoft\Teams\*" | Where name -in ('application cache','cache','blob_storage','databases','GPUcache','IndexedDB','Local Storage','tmp') | ForEach{Remove-Item $_.FullName -Recurse -Force}