### VARIABLES TO CHANGE FOR YOUR ENVIRONMENT
$DOWNLOAD_PATH = "C:\TEMP-PATH-TO-DOWNLOAD\torlist.txt"

### TOR List Source for downloading the latest list
$TOR_LIST_SOURCE = "https://check.torproject.org/torbulkexitlist" ### Alternative source: https://www.dan.me.uk/torlist/

# Download and temporarily store current TOR node IP list
[Net.ServicePointManager]::SecurityProtocol = "Tls12, Tls11, Tls, Ssl3"
Invoke-WebRequest -Uri $TOR_LIST_SOURCE -OutFile $DOWNLOAD_PATH

# Get new data for rules
$lines = 0
$lines = Get-Content $DOWNLOAD_PATH | Measure-Object -Line | Select-Object -expand Lines
$iterations = (($lines-$lines%1000)/1000) + 1

# Quit the program if no data was pulled down
if($lines -lt 10) { 
	Write-Host Server limited to one request every 30 minutes
	exit 
}

# Delete all created TorBlock rules to prevent rule collisions
# Dumps all rules and parses for "TorBlock" and "TorBlocker
$total = Get-NetFireWallRule -All | Select-String TorBlock | Measure-Object -Line | Select-Object -expand Lines
for ($t = 0; $t -lt $total/2; $t++) {
	$name = "TorBlock$t"

	Remove-NetFireWallRule -DisplayName $name
}

# Set New Firewall rule banning TOR IP's by the 1000's
# (Maximum number of IP's allowed per rule is 1000)
for($i = 0; $i -lt $iterations; $i++) {
	$skip = $i * 1000
	$ips = Get-Content $DOWNLOAD_PATH | Select-Object -First 1000 -Skip $skip
	$name = "TorBlock$i"
	New-NetFirewallRule -Direction Inbound -DisplayName $name -Name $name2 -RemoteAddress $ips -Action Block -ea "SilentlyContinue"
}

# Cleanup
Remove-Item $DOWNLOAD_PATH
