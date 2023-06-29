---
weight: 10
---

# Requirements

## PowerShell 7 

The installation of PowerShell 7 is recommended. Many functions of EulandaConnect also work under PowerShell 5.1, but the functions are tested and developed under PowerShell 7.x.

The following script can be inserted into the **PowerShell for Windows** console or from the DOS Command Prompt. The script loads version 7.3.x in the Windows 64-bit variant as MSI from the official GitHub page and initiates the installation. Elevated privileges are required and will be requested.

### From Windows PowerShell

`PS C:\Users\Administrator>`

```powershell
iwr -useb https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/PowerShell-7.3.5-win-x64.msi -o pwsh-7.3.5.msi; msiexec /i pwsh-7.3.5.msi /qn
```

### From Command Prompt

`C:\Users\Administrator>`

```bash
powershell.exe -Command "iwr -useb https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/PowerShell-7.3.5-win-x64.msi -o pwsh-7.3.5.msi; msiexec /i pwsh-7.3.5.msi /qn"
```

# Installation

Open a PowerShell console, the new PowerShell 7.3.x is best, but most functions also work in Windows PowerShell 5.1. The console does not need to have elevated rights. Then at the PowerShell copy and paste one line at a time into the console and press Enter each time.

`PS C:\Users\Administrator>`

```powershell
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name EulandaConnect -Repository PsGallery -scope CurrentUser
```

> **ATTENTION on ERRORS**: On some Windows systems with enabled folder monitoring (**ransomware protection**), the installation fails with a **directory error**. This is because neither the command line nor PowerShell for Windows can create a folder in the 'My Documents' area, even though this can be done seamlessly from File Explorer. To solve this issue, the feature should be turned off during installation and updates. Personally, I find this folder protection feature questionable because it requires the user to either be an administrator or constantly disable the feature before installing modules.
>
> This installation failure is not specific to **EulandaConnect** but affects **all PowerShell modules** that can be installed in the user context.

## Test your Installation

Type in:

```powershell
PS C:>Out-Welcome
```

If everything worked, you should see something like this:

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

Version:         EulandaConnect v3.1.1
Copyright:       (c) EULANDA Software GmbH. All rights reserved.
                 https://www.github.com/Eulanda/EulandaConnect
Modul path       C:\Users\john\Documents\PowerShell\Modules\eulandaConnect\3.1.1\EulandaConnect.psm1
Startet at:      06/02/2023 17:34:33
```

If you don't configure PSGallery as "Trusted," you'll receive a prompt asking if you want to trust a module before installation. As for trusting PSGallery overall, while it is a Microsoft-provided platform, there is no guarantee that it is entirely free of malware. However, since you only install modules that you trust, the risk is manageable and predictable.

# Update your Installation

After the module installation is completed, about 200 functions of EulandaConnect are available. These cover the various areas such as image manipulation, sending messages via Telegram, MSSQL data backups to NAS, FTP and SFTP, control of the EULANDA ERP Software and much more.
To update the module in the future, enter the following commands in the PowerShell console:

`PS C:\Users\Administrator>`

```powershell
Update-Module EulandaConnect -force
```

# Help

- The complete **online documentation** can be found at https://eulandaconnect.eulanda.eu

- Besides that the project is located on **GitHub** at https://www.github.com/eulanda/eulandaconnect
- Within the **GitHub** project, you can find online documentation at: https://github.com/Eulanda/EulandaConnect/tree/master/docs
- If you prefer to visit **PowerShell Gallery** directly, [this is your way](https://www.powershellgallery.com/packages/EulandaConnect)...
- If you would like to see how our ERP software works, feel free to check out https://www.eulanda.eu/.
- The **offline documentation** is installed with the EulandaConnect module and is directly available at the PowerShell console:

`PS C:\Users\Administrator>`

```powershell
Get-Help Out-Welcome
```

```
NAME
    Out-Welcome

SYNOPSIS
    Displays an opening output with start time


SYNTAX
    Out-Welcome [-noBanner] [-noInfo] [-projectScript <String>] [-culture <String>] [<CommonParameters>]


DESCRIPTION
    Creates the EULANDA logo in the output incl. the start time, the scriptdir name and if available the project name.
    The start time is stored in the `$startTime` global variable. When leaving with `out-goodby`, the execution time
    of the script is then also displayed.


RELATED LINKS
    Online Version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Out-Welcome.md
    Out-Goodbye

REMARKS
    To see the examples, type: "Get-Help Out-Welcome -Examples"
    For more information, type: "Get-Help Out-Welcome -Detailed"
    For technical information, type: "Get-Help Out-Welcome -Full"
    For online help, type: "Get-Help Out-Welcome -Online"

```

By appending the "-full" parameter to the help line, the descriptions of the parameters and examples will also be displayed. However, the online help provided in the next section is even more convenient.

# Available Functions

- The available functions are listed in the online documentation at:
   https://eulandaconnect.eulanda.eu/docs/Functions/.
- On GitHub there is a typical Markdown documentation at:
   https://github.com/Eulanda/EulandaConnect/tree/master/docs
- Upcoming things can be found at: [Roadmap](../general/Roadmap.md)

