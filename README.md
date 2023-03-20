# BlockTor
A Powershell script for blocking all inbound TOR node traffic using windows defender

Follow the steps below to enable the block:
1. Download tor.ps1 and change the VARIABLES near the top of the file to your liking.
2. From an Admin prompt, run the following command to enable the script to run hourly.
Be sure to change the <Full_path_to> variable to the actual path where the tor.ps1 file is located.

`schtasks /Create /SC HOURLY /TR "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ep Bypass -File <Full_Path_to>\tor.ps1" /TN TorBlock`

3. From Task Scheduler change the scheduled task to have full permissions
4. Lastly, attempt to run the task manually to ensure no permissions are blocking it from performing correctly.
