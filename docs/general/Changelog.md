---
weight: 30
---

# Changelog

The most important changes to EulandaConnect can be found listed chronologically here:

| Version | Date        | Description                                                  |
| ------- | ----------- | ------------------------------------------------------------ |
| 3.2.6 | coming soon | `New`: New-OpenVpnTls, ConvertTo-WindowsLineEndingFile, ConvertTo-UnixLineEndingFile in preparation for OpenVpn-Autoinstaller. |
| 3.2.5 | 07/02/2023 | `Bugfixes`:In the private function Test-FtpFolder, which is used by Test-RemoteFolder. Also in some ftp functions and in German resource files. For this reason the Backup-MssqlDatabase function triggered a format error in German. |
| 3.2.5 | 07/02/2023 | `New`: A bunch of new pester tests (more then 100). |
| 3.2.3 | 06/30/2023 | `New`: [Get-NewNumberFromSeries](../functions/Get-NewNumberFromSeries.md) Get the next number from series like OrderNo, OfferNo and so on, from EULANDA ERP system. [New-PurchaseOrder](../functions/New-PurchaseOrder.md) and [New-PurchaseOrderLineItem](../functions/New-PurchaseOrderLineItem.md) creates EULANDA Purchase order by API in PowerShell. [Get-SupplierId](../functions/Get-SupplierId.md) gets the supplierId for an -addressMatch. [Test-Website](../functions/Test-Website.md) checks broken links and more. |
| 3.2.3 | 06/30/2023 | `Bugfixes`: for Get-ArticleId, Get-ArticleNo and Get-ArticlePackingUnit if the search criteria was not a string an exception was thrown. |
| 3.2.2 | 06/25/2023 | Added a lot of new Pester-Tests |
| 3.2.2 | 06/25/2023 | `Bugfixes`: Convert-Slugify had an problem with the EUR symbol. |
| 3.2.2 | 06/25/2023 | More Pester-Tests |
| 3.2.1 | 06/25/2023 | `New`: [Convert-DatanormToXml](../functions/Convert-DatanormToXml.md), [Convert-FromDatanorm](../functions/Convert-FromDatanorm.md), [Import-ArticleFromXml](../functions/Import-ArticleFromXml) and [Convert-OemToUtf8](../functions/Convert-OemToUtf8.md) brings the datanorm standard to PowerShell. |
| 3.1.9 | 06/21/2023 | `Breaking Change`: Function Import-TieredPrices renamed, lot of new parameters and also alias exists.|
| 3.1.8 | 06/21/2023 | `Bugfixes`: Some bugfixes, when it is an Excel file. |
| 3.1.7 | 06/21/2023 | `New`: Import-TieredPrice to add tiered prices to the article table. |
| 3.1.7 | 06/21/2023 | The Hugo public folder is now cleaned up each time a new documentation is built |
| 3.1.6 | 06/13/2023 | Conflict with Send-TelegramLocation, renamed to [Send-TelegramMap](../functions/Send-TelegramMap.md). One user already had a module that used this function name. Since the function is very new, I decided to change the name. |
| 3.1.6 | 06/13/2023 | Typo in Get-AddressId **WWrite**-Verbose instead of **Write**-Verbose. |
| 3.1.5 | 06/12/2023 | Confusion, the beta flag was set incorrectly in the manifest. |
| 3.1.4 | 06/12/2023 | Strange behavior of the delimiter function in New-Table, fixed by changeover. |
| 3.1.3   | 06/12/2023  | Typo in EulLog, Get-RestStr instead of Get-ResStr.           |
| 3.1.3   | 06/12/2023 | Get-SftpNextFilename has used the FullName instead of Name.  |
| 3.1.2   | 06/12/2023 | [Send-TelegramLocation](../functions/Send-TelegramMap.md) sends a location via a Telegram message, visualized on a map based on given latitude and longitude or IP address. |
| 3.1.1   | 06/02/2023  | `New`: All text outputs from error messages, help texts, warnings etc. have been converted to resources and are available as resx-file. The English edition is the template of which a German edition is now also available. |
| 3.1.1   | 06/02/2023  | `Breaking Change`: The default protocol for all remote functions has been changed to `sftp` instead of `ftp`. If you require an ftp transmission, you must explicitly set the `-protocol` parameter to the value `ftp`. |
| 3.1.1   | 06/02/2023  | `New`: [Test-ReservedIp](../functions/Test-ReservedIp.md) This function checks whether a given IP address is a part of the reserved IP address ranges. [Test-IpAddress](../functions/Test-IpAddress.md) This function validates whether a given string is a valid IPv4 address. [Get-IpGeoInfo](../functions/Get-IpGeoInfo.md) This function retrieves geographic information for a specified IP address in a local cache. [Merge-IpGeoInfo](../functions/Merge-IpGeoInfo.md) This function merges two geographic xml databases. [Split-LogFile](../functions/Split-LogFile.md) This function is designed to split large log files into smaller, more manageable parts based on a specified file size limit. [New-Snapshot](../functions/New-Snapshot.md) This PowerShell function named `New-Snapshot` creates a Volume Shadow Copy (snapshot) on a specified drive and makes it accessible through a symbolic link. [Remove-Snapshot](../functions/Remove-Snapshot.md) deletes a snapshot that was previously created with `New-Snapshot`. [New-SymbolicLink](../functions/New-SymbolicLink.md) Creates a new symbolic link to a target directory or file. [Remove-SymbolicLink](../functions/Remove-SymbolicLink.md) Removes an existing symbolic link. [Get-Distance](../functions/Get-Distance.md) Calculates the distance between two points on the Earth's surface. [Convert-ToDecimalDegrees](../functions/Convert-ToDecimalDegrees.md) Converts coordinates in Degrees-Minutes-Seconds (DMS) format to Decimal Degrees (DD). [Send-TelegramMessage](../functions/Send-TelegramMessage.md) Sends a message via Telegram API, without requiring a locally installed Telegram app, compatible with PowerShell 5.x and 7.x. [Send-TelegramPhoto](../functions/Send-TelegramPhoto.md) Sends a photo with a caption via Telegram API, compatible with PowerShell 5.x and 7.x. |
| 3.0.3   | 05/21/2023  | `Bugfix`: Deny-RemoteServer worked only on standard port 22  |
| 3.0.2   | 05/21/2023  | `Bugfix`: Deny-RemoteServer was a bug in the logic           |
| 3.0.2   | 05/21/2023  | `Enhanced`: Write-Verbose is overwritten with indent (testwise) |
| 3.0.1   | 05/19/2023  | `New`: [Deny-RemoteFingerprint](../functions/Deny-RemoteFingerprint.md), [Get-RemoteDir](./docs/Get-RemoteDir.md), [Get-RemoteFileAge](../functions/Get-RemoteFileAge.md), [Get-RemoteFileDate](../functions/Get-RemoteFileDate.md), [Get-RemoteFileSize](../functions/Get-RemoteFileSize.md), [Get-RemoteNextFilename](../functions/Get-RemoteNextFilename.md), [New-RemoteFolder](../functions/New-RemoteFolder.md), [Receive-RemoteFile](../functions/Receive-RemoteFile.md), [Remove-RemoteFingerprint](../functions/Remove-RemoteFingerprint.md), [Remove-RemoteFolder](../functions/Remove-RemoteFolder.md), [Rename-RemoteFile](../functions/Rename-RemoteFile.md), [Rename-RemoteFolder](../functions/Rename-RemoteFolder.md), [Select-OutdatedFilenames](../functions/Select-OutdatedFilenames.md), [Send-RemoteFile](../functions/Send-RemoteFile.md),[Test-RemoteFile](../functions/Test-RemoteFile.md) and [Test-RemoteFolder](../functions/Test-RemoteFolder.md). Now all remote functions supports **FTP**, **FTPS** and **SFTP**. If SFTP is used, you have to install POSH-SSH from PsGallery also. |
| 3.0.1   | 05/19/2023  | `Enhanced`: [ConvertTo-WrappedLines.md](../functions/ConvertTo-WrappedLines.md) and  [ConvertTo-WrappedLinesEdi.md](../functions/ConvertTo-WrappedLinesEdi.md) now accepts also empty text parameter. |
| 2.5.8   | 05/07/2023  | `Bugfix`: There was a count error on a new installation, and the documentation was also expanded. |
| 2.5.7   | 05/07/2023  | `New`:  [Backup-MssqlDatabase.md](../functions/Backup-MssqlDatabase.md) |
| 2.5.6   | 05/05/2023  | `Bugfix`: The functions  [Get-DmsFolderSalesOrder.md](../functions/Get-DmsFolderSalesOrder.md)  and  [Get-DmsFolderDelivery.md](../functions/Get-DmsFolderDelivery.md)  now utilize a registry key to calculate the folder name. |
| 2.5.5   | 05/04/2023  | `Bugfix`: No version number in [Out-Welcome.md](../functions/Out-Welcome.md), module folder not detected in the right way. |
| 2.5.4   | 05/04/2023  | `New`: Test-Console                                          |
| 2.5.3   | 05/03/2023  | `New`: [Export-DeliveryToXml.md](../functions/Export-DeliveryToXml.md), [Get-XmlEulandaDelivery.md](../functions/Get-XmlEulandaDelivery.md), [Get-XmlEulandaDeliveryPos.md](../functions/Get-XmlEulandaDeliveryPos.md) and [ConvertTo-XmlString.md](../functions/ConvertTo-XmlString.md) |
| 2.5.3   | 05/02/2023  | `New`: Export-ArticleToXml, Export-PropertyToXml, Find-MssqlServer,  Get-BreadcrumbId, Get-BreadcrumbPath, Get-PropertySql, Get-SalesOrderId, Get-UpsellingFromVariants, Get-XmlEulandaAddress, Get-XmlEulandaArticle, Get-XmlEulandaBreadcrumb, Get-XmlEulandaMetadata, Get-XmlEulandaProperty, Get-XmlEulandaRoot, Get-XmlEulandaShop, Get-XmlEulandaStock, Get-XmlEulandaTierPrice, New-ConnStr, Test-PrivateIP, Test-ShopExtension |
| 2.5.3   | 05/02/2023  | `Enhanced`: Lot of function now with more parameter e.g. Get-ArticleId now also with UDI and others. All global variables now have `ec` prefix. Find-MssqlServer is now much more faster. |
| 2.5.3   | 05/02/2023  | `Breaking Change`: All standalone global variables now have `ec` prefix. Dropped Find-MssqBrowser (now see Find-MssqlServer). |
| 2.3.12  | 03/19/2023  | `Enhanced`: Documentation enhanced with XML file format description and roadmap on the first page |
|         |             | `Bugfix`: When using the article number in the Get-ArticleId function, an error was occurring stating that the ArticleId variable was unknown. This has now been fixed. |
| 2.3.11  | 03/10/2023  | `New`: Get-Subnet, Get-NextIp, Get-NetworkId,Get-MaxHosts , Get-LocalIp, Get-GatewayIp,Get-FirstIp, Get-Cidr, Get-BroadcastIp, Find-MssqlBrowser, Convert-SubnetToBitMask, Confirm-System |
| 2.3.10  | 03/09/2023  | `New`:  [Format-Xml.md](../functions/Format-Xml.md)   |
| 2.3.9   | 03/08/2023  | `New`:  [Get-LoremIpsum.md](../functions/Get-LoremIpsum.md)  and  [Convert-ImageToBase64.md](../functions/Convert-ImageToBase64.md) |
| 2.3.8   | 03/08/2023  | `Bugfix`: The 'Out-Welcome' function in PowerShell has also influenced the culture of the system. |
| 2.3.7   | 03/08/2023  | `New`: The 'Update-Desktop' function refreshes the desktop.  |
| 2.3.6   | 03/08/2023  | `Bugfix`: The 'Hide-Extensions' and 'Show-Extensions' functions are now working as expected |
| 2.3.5   | 03/08/2023  | `Enhanced`: The 'Out-Welcome' function supports culture and displays the module path. |
| 2.3.4   | 03/07/2023  | `New`: The 'Resize-Image' function has been added and supports simple pipeline commands |
| 2.3.3   | 03/07/2023  | `Enhanced`: The 'Approve-Signature' function now uses the file with the last folder name when invoked without parameters. |
| 2.3.2   | 03/07/2023  | `New`: Approve-Signature                                     |
| 2.3.1   | 03/06/2023  | `Breaking Change`: The 'Rename-Database' function has been renamed to 'Rename-MssqlDatabase'. Additionally, some functions such as 'Get-MssqlInstances' and 'Rename-MssqlDatabase' are now backward compatible with Windows PowerShell 5.1. |
| 2.2.6   | 03/06/2023  | `Bugfix`: The 'Get-MssqlInstances' function did not work correctly when the user was an administrator. |
| 2.2.4   | 03/06/2023  | `New`: Get-MssqlInstances                                    |
| 2.2.3   | 03/05/2023  | `Bugfix`: There were formatting glitches in 'Out-Welcome' when no project was defined. |
|         |             | `New`: Additionally, new functions have been added, including 'Protect-String', 'Unprotect-String', and 'Get-TranslateSection'. |
| 2.2.2   | 03/04/2023  | `New`: Rename-Database (MSSQL)                               |
| 2.2.1   | 03/02/2023  | `Enhanced`: The project has been restructured. The folder structure is now streamlined and more organized. |
| 2.1.28  | 03/01/2023  | `Enhanced`: The banner has a new layout.                     |
|         |             | `Breaking Change`: Additionally, there are some breaking changes, including the removal of the 'ChangeLocation' feature in 'Out-Welcome' and the addition of a new parameter called 'ProjectScript'. |
| 2.1.27  | 03/01/2023  | `New`: Read-VersionFromSynopsis                              |
| 2.1.26  | 03/01/2023  | `New`: Show-MsgBox supports now OnTop                        |
| 2.1.25  | 03/01/2023  | `New`: Show-MsgBox and ShowMsgBoxYes                         |
| 2.1.24  | 02/28/2023  | `Bugfix`: The 'Install-SignTool' bug has been fixed.         |
|         |             | `New`: 'Out-Welcome' now includes an additional parameter called 'ChangeLocation'. |
|         |             | `Enhanced`: Furthermore, the documentation has been enhanced. |
| 2.1.23  | 02/28/2023  | `Enhanced`: The documentation (a separate GitHub project) is now synchronized with the PowerShell modules GitHub project. |
| 2.1.21  | 02/27/2023  | `New`: Get-ArticleSql                                        |
| 2.1.20  | 02/26/2023  | `New`: The license file is now available in both MD and TXT formats. |
|         |             | `New`: Global ADO constants have been added                  |
| 2.1.18  | 02/25/2023  | `Enhanced`: All help files, including MAML, are now complete |
| 2.1.12  | 02/24/2023  | `Enhanced`: The EulandaConnect module is now EV signed.      |
| 2.1.11  | 02/20/2023  | `Bugfix`: have been made to 'adoConstants'                   |

