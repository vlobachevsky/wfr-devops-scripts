(Get-WmiObject -computerName localhost Win32_Service -Filter "Name='Tomcat7'").StartService() | out-null
Write-Host "Starting Tomcat..."

if ($env:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
 Write-Log -level warning "changing from 32bit to 64bit powershell"
 $powershell=join-path $PSHOME.tolower().replace("syswow64","sysnative").replace("system32","sysnative") powershell.exe
 if ($myInvocation.Line) {
 &"$powershell" -NonInteractive -NoProfile -ExecutionPolicy Bypass $myInvocation.Line
 } else {
 &"$powershell" -NonInteractive -NoProfile -ExecutionPolicy Bypass -file "$($myInvocation.InvocationName)" $args
 }
 exit $lastexitcode
}
Set-WebConfiguration system.webServer/httpRedirect "IIS:\sites\Default Web Site" -Value @{enabled="true";destination="";exactDestination="true";httpResponseStatus="Permanent"}
iisreset
