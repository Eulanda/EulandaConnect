#
# Module manifest for module 'EulandaConnect'
#
# Generated by: Christian Niedergesäß - https://www.eulanda.eu
#
# Generated on: 06/28/2023
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'EulandaConnect.psm1'

# Version number of this module.
ModuleVersion = '3.2.3'

# Supported PSEditions
CompatiblePSEditions = @('Desktop', 'Core')

# ID used to uniquely identify this module
GUID = 'd80a730f-d7af-49a2-a6bb-49732aa5287d'

# Author of this module
Author = 'Christian Niedergesäß'

# Company or vendor of this module
CompanyName = 'EULANDA Software GmbH'

# Copyright statement for this module
Copyright = '© EULANDA Software GmbH. All rights reserved.'

# Description of the functionality provided by this module
Description = 'EulandaConnect enables the automation of processes both within and beyond your EULANDA ERP software. Compatible with EULANDA ERP 8.x and PowerShell 5.1 or higher, it supports a range of functionalities. These include XML data exchange, Datanorm, delivery bills, order creation, and communication via the Telegram API. In addition, EulandaConnect offers image functions, diagnostic functions, and a suite of MSSQL features such as comprehensive database renaming, data backup, and SQL browser location within the network. With over 250 functions currently available and more in development, EulandaConnect is a powerful extension not only for your ERP system. https://eulandaconnect.eulanda.eu'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Approve-Signature',
    'Backup-MssqlDatabase',
    'Close-Delivery',
    'Close-SalesOrder',
    'Confirm-System',
    'Convert-Accent',
    'Convert-DatanormToXml',
    'Convert-DataToXml',
    'Convert-DateToIso',
    'Convert-FromDatanorm',
    'Convert-ImageToBase64',
    'Convert-OemToUtf8',
    'Convert-Slugify',
    'Convert-StringCase',
    'Convert-SubnetToBitMask',
    'Convert-ToDecimalDegrees',
    'ConvertTo-USFloat',
    'ConvertTo-WrappedLines',
    'ConvertTo-WrappedLinesEdi',
    'ConvertTo-XmlString',
    'Deny-RemoteFingerprint',
    'Export-ArticleToXml',
    'Export-DeliveryToXml',
    'Export-PropertyToXml',
    'Export-StockToXml',
    'Find-MssqlServer',
    'Format-Xml',
    'Get-AddressId',
    'Get-AddressSql',
    'Get-AdoRs',
    'Get-ArticleId',
    'Get-ArticleNo',
    'Get-ArticlePackingUnit',
    'Get-ArticleSql',
    'Get-Bool',
    'Get-BreadcrumbId',
    'Get-BreadcrumbPath',
    'Get-BroadcastIp',
    'Get-Cidr',
    'Get-Conn',
    'Get-ConnItems',
    'Get-ConnStr',
    'Get-DataFromSql',
    'Get-DeliveryId',
    'Get-DeliveryLink',
    'Get-DeliveryNo',
    'Get-DeliveryQty',
    'Get-DeliverySql',
    'Get-DeliveryStatus',
    'Get-DesktopDir',
    'Get-Distance',
    'Get-DmsFolderDelivery',
    'Get-DmsFolderSalesOrder',
    'Get-FieldTruncated',
    'Get-Filename',
    'Get-FirstIp',
    'Get-GatewayIp',
    'Get-Hostname',
    'Get-HtmlEncoded',
    'Get-HtmlMetaData',
    'Get-HtmlStyle',
    'Get-IniBool',
    'Get-IpGeoInfo',
    'Get-LastIp',
    'Get-LocalIp',
    'Get-LogName',
    'Get-LoremIpsum',
    'Get-MaxHosts',
    'Get-ModulePath',
    'Get-MssqlInstances',
    'Get-MultipleOptions',
    'Get-NetworkId',
    'Get-NewNumberFromSeries',
    'Get-NextIp',
    'Get-OldestFile',
    'Get-Path32',
    'Get-PropertySql',
    'Get-PublicIp',
    'Get-RemoteDir',
    'Get-RemoteFileAge',
    'Get-RemoteFileDate',
    'Get-RemoteFileSize',
    'Get-RemoteNextFilename',
    'Get-ResStr',
    'Get-SalesOrderId',
    'Get-ScriptDir',
    'Get-SignToolPath',
    'Get-SingleOption',
    'Get-Spaces',
    'Get-StockSql',
    'Get-Subnet',
    'Get-SupplierAddressId',
    'Get-SupplierId',
    'Get-TempDir',
    'Get-TranslateSection',
    'Get-UpsellingFromVariants',
    'Get-XmlEulandaAddress',
    'Get-XmlEulandaArticle',
    'Get-XmlEulandaBreadcrumb',
    'Get-XmlEulandaDelivery',
    'Get-XmlEulandaDeliveryPos',
    'Get-XmlEulandaMetadata',
    'Get-XmlEulandaProperty',
    'Get-XmlEulandaRoot',
    'Get-XmlEulandaShop',
    'Get-XmlEulandaStock',
    'Get-XmlEulandaTierPrice',
    'Hide-Extensions',
    'Import-ArticleFromXml',
    'Import-TieredPrices',
    'Install-SignTool',
    'Merge-IpGeoInfo',
    'New-ConnStr',
    'New-Delivery',
    'New-DeliveryPropertyItem',
    'New-EulException',
    'New-EulLog',
    'New-PurchaseOrder',
    'New-PurchaseOrderLineItem',
    'New-RemoteFolder',
    'New-SalesOrder',
    'New-Shortcut',
    'New-Snapshot',
    'New-SymbolicLink',
    'New-Table',
    'New-TempDir',
    'Open-Delivery',
    'Out-Beep',
    'Out-Goodbye',
    'Out-Welcome',
    'Protect-String',
    'Read-IniFile',
    'Read-VersionFromSynopsis',
    'Receive-RemoteFile',
    'Remove-DeliveryPropertyItem',
    'Remove-ItemWithRetry',
    'Remove-RemoteFile',
    'Remove-RemoteFingerprint',
    'Remove-RemoteFolder',
    'Remove-Snapshot',
    'Remove-SymbolicLink',
    'Rename-MssqlDatabase',
    'Rename-RemoteFile',
    'Rename-RemoteFolder',
    'Resize-Image',
    'Select-OutdatedFilenames',
    'Send-Mail',
    'Send-RemoteFile',
    'Send-TelegramMap',
    'Send-TelegramMessage',
    'Send-TelegramPhoto',
    'Set-DeliveryQty',
    'Set-StockQty',
    'Set-TrackingNo',
    'Show-Extensions',
    'Show-MsgBox',
    'Show-MsgBoxYes',
    'Split-LogFile',
    'Test-Administrator',
    'Test-ArticlePropertyItem',
    'Test-Console',
    'Test-HasProperty',
    'Test-IpAddress',
    'Test-Numeric',
    'Test-PrivateIp',
    'Test-RemoteFile',
    'Test-RemoteFolder',
    'Test-ReservedIp',
    'Test-SalesOrder',
    'Test-ShopExtension',
    'Test-Verbose',
    'Test-XmlSchema',
    'Unprotect-String',
    'Update-Desktop',
    'Use-Culture',
    'Write-XmlMetadata'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
# CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
# AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
ModuleList = @('.\EulandaConnect.psm1')

# List of all files packaged with this module
FileList = @(
    
    '.\EulandaConnect.psd1',
    '.\EulandaConnect.psm1',
    '.\EulandaConnect-help.xml',
    '.\EulandaConnect.de-DE.resx',
    '.\EulandaConnect.en-US.resx',
    '.\assets\License.md',
    '.\assets\License.txt',
    '.\assets\Readme.txt'
)

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{
        Title = 'Eulanda ERP functions supporting PowerShell'

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("Eulanda",
        "ERP",
        "SDK",
        "API",
        "OEM-Charset",
        "DATANORM",
        "CUDEL",
        "Order",
        "Delivery",
        "Invoice",
        "Shop",
        "Store",
        "Carrier",
        "Textprocessing",
        "Slugify",
        "LoremIpsum",
        "MSSQL",
        "Backup",
        "Ftp",
        "Convert",
        "Rename",
        "Database",
        "VSS",
        "Signing",
        "Signtool",
        "PublicIp",
        "XML",
        "Telegram",
        "SqlBrowser",
        "ImageProcessing",
        "WIA.ImageFile")

        # A URL to the license for this module.
        # LicenseUri = 'https://github.com/Eulanda/EulandaConnect/blob/master/License.md'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Eulanda/EulandaConnect'

        # A URL to an icon representing this module.
        IconUri = 'https://github.com/Eulanda/EulandaConnect/blob/master/media/EulandaConnect-icon.png?raw=true'

        # ReleaseNotes of this module
        ReleaseNotes = 'Look at Changelog in Project Site: https://github.com/Eulanda/EulandaConnect/blob/master/docs/general/Changelog.md'

        # Prerelease string of this module
        # Prerelease = 'beta'

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/Eulanda/EulandaConnect'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

