# Inspired by https://www.leeholmes.com/projects/ps_html5/Invoke-PSHtml5.ps1

## Open the background song
$script = @'
   $player = New-Object -ComObject 'MediaPlayer.MediaPlayer'
   $player.Open("http://www.leeholmes.com/projects/ps_html5/background.mp3")
   $player
'@

## ... in a background MTA-threaded PowerShell because
## the MediaPlayer COM object doesn't like STA
$runspace = [RunspaceFactory]::CreateRunspace()
$runspace.ApartmentState = "MTA"
$bgPowerShell = [PowerShell]::Create()
$bgPowerShell.Runspace = $runspace
$runspace.Open()
$player = @($bgPowerShell.AddScript($script).Invoke())[0]
cmd.exe /c "curl http://ascii.live/rick"