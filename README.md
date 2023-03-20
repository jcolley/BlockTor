# BlockTor
A Powershell script for blocking all inbound TOR node traffic using windows defender

Follow the steps below to enable the block:
1. Download tor.ps1 and change the VARIABLES near the top of the file to your liking.
2. From an Admin prompt, run the following command to enable the script to run hourly.
Be sure to change the <Full_Path_To> variable to the actual path where the tor.ps1 file is located.

```batchfile
schtasks /Create /SC HOURLY /TR "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ep Bypass -File <Full_Path_To>\tor.ps1" /TN BlockTor
```

3. From Task Scheduler change the scheduled task to:
   * Run as the SYSTEM user account
   * Run whether user is logged in or not
   * Run with highest privileges
5. Lastly, attempt to run the task manually to ensure noting is blocking it from performing correctly.
