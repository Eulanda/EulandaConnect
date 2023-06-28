# Importing Tracking Numbers with EulandaConnect

Effortlessly import any number of tracking numbers to a delivery note using a simple CSV file. To get started, you'll need EULANDA ERP system version 8.5 and the PowerShell extension version 7.3.x EulandaConnect.

## What is EulandaConnect?

EulandaConnect is an MIT-licensed function library that automates tasks in the EULANDA ERP system using PowerShell. The MIT license allows free use of the software in commercial settings. PowerShell is a scripting language developed by Microsoft, available on many operating systems. Like batch or VBScript files in the past, it automates recurring processes.

Missed the first part? Read here how to install EulandaConnect: [Install PowerShell and EulandaConnect](../General/Installation.md#from-command-prompt)

## Today's Showcase

We'll demonstrate how to import tracking numbers from a simple CSV file with the following example structure:

```
DeliveryNoteNumber;TrackingNumber1,TrackingNumber2,TrackingNumber3...
```

Each line of the CSV file contains a record consisting of a delivery note number and any number of associated tracking numbers. Delivery note numbers and tracking numbers are separated by a semicolon, while individual tracking numbers are separated by a comma. Line endings use the standard Windows CRLF format.

## A Sample File

```
69;1UW09LZ328259,1UW07LZ853614
65;1UW02LZ7414563
```

This file should be named 'tracking.csv' and saved on the desktop. Open Notepad and copy the content inside. You'll likely need to change the delivery note numbers 69 and 65 to match those in your EULANDA ERP system.

The first delivery note with number 69 consists of two shipments, 1UW09LZ328259 and 1UW07LZ853614, while delivery note 65 contains only one shipment.

## The Script

First, open a PowerShell console with version 7.x. This can be done directly through the Windows logo with `pwsh.exe` or through the `Windows Terminal`. The console window should look like this:

```powershell
PowerShell 7.3.x
PS C:\Users\cn>
```

You'll also need to modify the script. Adjust the UDL file path to match your EULANDA installation.

Then, copy the entire script and paste it into the PowerShell window. Press ENTER to confirm.

```powershell
Import-Module EulandaConnect -Force
Out-Welcome
$csv = Import-Csv -Path "$(Get-DesktopDir)\tracking.csv" -Delimiter ";" -Header "DeliveryNo", "TrackingNo"
foreach ($row in $csv) {
	$trackingNo = $row.TrackingNo.Split(",")
	Set-TrackingNo -DeliveryNo $row.DeliveryNo -TrackingNo $trackingNo -udl 'c:\temp\Eulanda_1 Truccamo.udl'
}
Out-Goodbye
```

The output should look similar to this:

```

          ________  ____    ___    _   ______  ___
         / ____/ / / / /   /   |  / | / / __ \/   |
        / __/ / / / / /   / /| | /  |/ / / / / /| |
       / /___/ /_/ / /___/ ___ |/ /|  / /_/ / ___ |
      /_____/\____/_____/_/  |_/_/ |_/_____/_/  |_|
         _____       ______
        / ___/____  / __/ /__      ______ _________
        \__ \/ __ \/ /_/ __/ | /| / / __  / ___/ _ \
       ___/ / /_/ / __/ /_ | |/ |/ / /_/ / /  /  __/
      /____/\____/_/  \__/ |__/|__/\__,_/_/   \___/

Version: EulandaConnect v2.3.12
Copyright: (c) EULANDA Software GmbH. All rights reserved.
Modulpfad C:\Users\cn\Documents\PowerShell\Modules\EulandaConnect\2.3.12\EulandaConnect.psm1
Gestartet um: 21.04.2023 14:10:12
Execution start: 04/21/2023 14:10:12
Execution end: 04/21/2023 14:10:13
Duration: 0,33 seconds
```

The tracking numbers have now been added to both delivery notes. You can launch the EULANDA ERP system, open the delivery notes, and check the tracking numbers. This automation can help both programmers who are just starting with this topic and companies using EULANDA ERP to simplify their processes through automation.