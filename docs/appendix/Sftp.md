---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
schema: 2.0.0
lastMod: 2025-07-26T15:34:00
---

# SFTP Functions

`EulandaConnect` supports some basic functionalities that can be executed via SFTP. These include [Get-RemoteNextFilename.md](../functions/Get-RemoteNextFilename.md), [Remove-RemoteFile.md](../functions/Remove-RemoteFile.md), [Send-RemoteFile.md](../functions/Send-RemoteFile.md), and [Receive-RemoteFile.md](../functions/Receive-RemoteFile.md). The functions uses other libraries that are not part of the basic scope of PowerShell or Windows. Starting from version 2.6 of `EulandaConnect` uses for SFTP the POSH-SSH module, which, like `EulandaConnect`, can simply be installed via the `PSGallery` with `Install-Module -Name POSH-SSH`. You have to install it yourself. If you call a SFTP function and do not have installed POSH-SSH then you will get an exception.

The basic functions are specifically designed for data exchange and processing of queues. With `Get-RemoteNextFilename`, an SFTP directory can be queried and filtered by a file extension (e.g., *.xml). The filename of the oldest matching file is then returned so that it can be loaded with `Receive-RemoteFile`. The file can then be removed from the queue using `Remove-RemoteFile`.

Conversely, if data is to be uploaded to an SFTP server, this can be done with `Send-RemoteFile`. Each function is independent and can also be called from a PowerShell console from the command line.

The Backup-MssqlDatabase function supports file transfer via both FTP and SFTP protocols.

## Install POSH-SSH

Open a PowerShell console, the new PowerShell 7.3.x is best, but most functions also work in Windows PowerShell 5.1. The console does not need to have elevated rights. Then at the PowerShell copy and paste one line at a time into the console and press Enter each time.

```powershell
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name POSH-SSH -Repository PsGallery -scope CurrentUser
```

> **ATTENTION on ERRORS**: On some Windows systems with enabled folder monitoring (**ransomware protection**), the installation fails with a **directory error**. This is because neither the command line nor PowerShell for Windows can create a folder in the 'My Documents' area, even though this can be done seamlessly from File Explorer. To solve this issue, the feature should be turned off during installation and updates. Personally, I find this folder protection feature questionable because it requires the user to either be an administrator or constantly disable the feature before installing modules.
>
> This installation failure is not specific to **POSH-SSH** but affects **all PowerShell modules** that can be installed in the user context.
