$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
    Set-NetConnectionProfile -interfacealias * -NetworkCategory "Private"
    winrm quickconfig
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Enable-PSRemoting -Force
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
    Set-Service -Name WinRM -StartupType Automatic
    Set-Service -Name Winmgmt -StartupType Automatic
    Start-Service WinRM
    Start-Service Winmgmt
}
else{
    Write-Output "Please Run Powershell As Administrator."
}

