#
# Module manifest for module 'EulandaConnect'
#
# Generated by: Christian Niedergesäß - https://www.eulanda.eu
#
# Generated on: 02/25/2024
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'EulandaConnect.psm1'

# Version number of this module.
ModuleVersion = '3.3.1'

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
    'Get-XmlEulandaTieredPrices',
    'Hide-Extensions',
    'Import-ArticleFromXml',
    'Import-TieredPrices',
    'Install-LatestOpenVPN',
    'Install-SignTool',
    'Merge-IpGeoInfo',
    'New-ConnStr',
    'New-Delivery',
    'New-EulException',
    'New-EulLog',
    'New-OpenVpnCa',
    'New-OpenVpnServerConfig',
    'New-OpenVpnTls',
    'New-PropertyItem',
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
    'Remove-ItemWithRetry',
    'Remove-PropertyItem',
    'Remove-RemoteFile',
    'Remove-RemoteFingerprint',
    'Remove-RemoteFolder',
    'Remove-Snapshot',
    'Remove-SymbolicLink',
    'Rename-MssqlDatabase',
    'Rename-RemoteFile',
    'Rename-RemoteFolder',
    'Resize-Image',
    'Restore-MssqlDatabase',
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
    'Test-Console',
    'Test-HasProperty',
    'Test-IpAddress',
    'Test-MssqlAdministrator',
    'Test-Numeric',
    'Test-PrivateIp',
    'Test-PropertyItem',
    'Test-RemoteFile',
    'Test-RemoteFolder',
    'Test-ReservedIp',
    'Test-SalesOrder',
    'Test-ShopExtension',
    'Test-Verbose',
    'Test-Website',
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
    '.\EulandaConnect-help.xml',
    '.\EulandaConnect.de-DE.resx',
    '.\EulandaConnect.en-US.resx',
    '.\EulandaConnect.psm1',
    '.\License.md',
    '.\License.txt',
    '.\Readme.txt'
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


# SIG # Begin signature block
# MIIpZwYJKoZIhvcNAQcCoIIpWDCCKVQCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCjELb9EsNMjRPM
# sC1MDYK34R2ulhHks/KTQ1hkmjHwn6CCElYwggVvMIIEV6ADAgECAhBI/JO0YFWU
# jTanyYqJ1pQWMA0GCSqGSIb3DQEBDAUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQI
# DBJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoM
# EUNvbW9kbyBDQSBMaW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2Vy
# dmljZXMwHhcNMjEwNTI1MDAwMDAwWhcNMjgxMjMxMjM1OTU5WjBWMQswCQYDVQQG
# EwJHQjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMS0wKwYDVQQDEyRTZWN0aWdv
# IFB1YmxpYyBDb2RlIFNpZ25pbmcgUm9vdCBSNDYwggIiMA0GCSqGSIb3DQEBAQUA
# A4ICDwAwggIKAoICAQCN55QSIgQkdC7/FiMCkoq2rjaFrEfUI5ErPtx94jGgUW+s
# hJHjUoq14pbe0IdjJImK/+8Skzt9u7aKvb0Ffyeba2XTpQxpsbxJOZrxbW6q5KCD
# J9qaDStQ6Utbs7hkNqR+Sj2pcaths3OzPAsM79szV+W+NDfjlxtd/R8SPYIDdub7
# P2bSlDFp+m2zNKzBenjcklDyZMeqLQSrw2rq4C+np9xu1+j/2iGrQL+57g2extme
# me/G3h+pDHazJyCh1rr9gOcB0u/rgimVcI3/uxXP/tEPNqIuTzKQdEZrRzUTdwUz
# T2MuuC3hv2WnBGsY2HH6zAjybYmZELGt2z4s5KoYsMYHAXVn3m3pY2MeNn9pib6q
# RT5uWl+PoVvLnTCGMOgDs0DGDQ84zWeoU4j6uDBl+m/H5x2xg3RpPqzEaDux5mcz
# mrYI4IAFSEDu9oJkRqj1c7AGlfJsZZ+/VVscnFcax3hGfHCqlBuCF6yH6bbJDoEc
# QNYWFyn8XJwYK+pF9e+91WdPKF4F7pBMeufG9ND8+s0+MkYTIDaKBOq3qgdGnA2T
# OglmmVhcKaO5DKYwODzQRjY1fJy67sPV+Qp2+n4FG0DKkjXp1XrRtX8ArqmQqsV/
# AZwQsRb8zG4Y3G9i/qZQp7h7uJ0VP/4gDHXIIloTlRmQAOka1cKG8eOO7F/05QID
# AQABo4IBEjCCAQ4wHwYDVR0jBBgwFoAUoBEKIz6W8Qfs4q8p74Klf9AwpLQwHQYD
# VR0OBBYEFDLrkpr/NZZILyhAQnAgNpFcF4XmMA4GA1UdDwEB/wQEAwIBhjAPBgNV
# HRMBAf8EBTADAQH/MBMGA1UdJQQMMAoGCCsGAQUFBwMDMBsGA1UdIAQUMBIwBgYE
# VR0gADAIBgZngQwBBAEwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC5jb21v
# ZG9jYS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmwwNAYIKwYBBQUHAQEE
# KDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJKoZI
# hvcNAQEMBQADggEBABK/oe+LdJqYRLhpRrWrJAoMpIpnuDqBv0WKfVIHqI0fTiGF
# OaNrXi0ghr8QuK55O1PNtPvYRL4G2VxjZ9RAFodEhnIq1jIV9RKDwvnhXRFAZ/ZC
# J3LFI+ICOBpMIOLbAffNRk8monxmwFE2tokCVMf8WPtsAO7+mKYulaEMUykfb9gZ
# pk+e96wJ6l2CxouvgKe9gUhShDHaMuwV5KZMPWw5c9QLhTkg4IUaaOGnSDip0TYl
# d8GNGRbFiExmfS9jzpjoad+sPKhdnckcW67Y8y90z7h+9teDnRGWYpquRRPaf9xH
# +9/DUp/mBlXpnYzyOmJRvOwkDynUWICE5EV7WtgwggYcMIIEBKADAgECAhAz1wio
# kUBTGeKlu9M5ua1uMA0GCSqGSIb3DQEBDAUAMFYxCzAJBgNVBAYTAkdCMRgwFgYD
# VQQKEw9TZWN0aWdvIExpbWl0ZWQxLTArBgNVBAMTJFNlY3RpZ28gUHVibGljIENv
# ZGUgU2lnbmluZyBSb290IFI0NjAeFw0yMTAzMjIwMDAwMDBaFw0zNjAzMjEyMzU5
# NTlaMFcxCzAJBgNVBAYTAkdCMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxLjAs
# BgNVBAMTJVNlY3RpZ28gUHVibGljIENvZGUgU2lnbmluZyBDQSBFViBSMzYwggGi
# MA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQC70f4et0JbePWQp64sg/GNIdMw
# hoV739PN2RZLrIXFuwHP4owoEXIEdiyBxasSekBKxRDogRQ5G19PB/YwMDB/NSXl
# wHM9QAmU6Kj46zkLVdW2DIseJ/jePiLBv+9l7nPuZd0o3bsffZsyf7eZVReqskmo
# PBBqOsMhspmoQ9c7gqgZYbU+alpduLyeE9AKnvVbj2k4aOqlH1vKI+4L7bzQHkND
# brBTjMJzKkQxbr6PuMYC9ruCBBV5DFIg6JgncWHvL+T4AvszWbX0w1Xn3/YIIq62
# 0QlZ7AGfc4m3Q0/V8tm9VlkJ3bcX9sR0gLqHRqwG29sEDdVOuu6MCTQZlRvmcBME
# Jd+PuNeEM4xspgzraLqVT3xE6NRpjSV5wyHxNXf4T7YSVZXQVugYAtXueciGoWnx
# G06UE2oHYvDQa5mll1CeHDOhHu5hiwVoHI717iaQg9b+cYWnmvINFD42tRKtd3V6
# zOdGNmqQU8vGlHHeBzoh+dYyZ+CcblSGoGSgg8sCAwEAAaOCAWMwggFfMB8GA1Ud
# IwQYMBaAFDLrkpr/NZZILyhAQnAgNpFcF4XmMB0GA1UdDgQWBBSBMpJBKyjNRsjE
# osYqORLsSKk/FDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAT
# BgNVHSUEDDAKBggrBgEFBQcDAzAaBgNVHSAEEzARMAYGBFUdIAAwBwYFZ4EMAQMw
# SwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdv
# UHVibGljQ29kZVNpZ25pbmdSb290UjQ2LmNybDB7BggrBgEFBQcBAQRvMG0wRgYI
# KwYBBQUHMAKGOmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1B1YmxpY0Nv
# ZGVTaWduaW5nUm9vdFI0Ni5wN2MwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNl
# Y3RpZ28uY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBfNqz7+fZyWhS38Asd3tj9lwHS
# /QHumS2G6Pa38Dn/1oFKWqdCSgotFZ3mlP3FaUqy10vxFhJM9r6QZmWLLXTUqwj3
# ahEDCHd8vmnhsNufJIkD1t5cpOCy1rTP4zjVuW3MJ9bOZBHoEHJ20/ng6SyJ6UnT
# s5eWBgrh9grIQZqRXYHYNneYyoBBl6j4kT9jn6rNVFRLgOr1F2bTlHH9nv1HMePp
# GoYd074g0j+xUl+yk72MlQmYco+VAfSYQ6VK+xQmqp02v3Kw/Ny9hA3s7TSoXpUr
# OBZjBXXZ9jEuFWvilLIq0nQ1tZiao/74Ky+2F0snbFrmuXZe2obdq2TWauqDGIgb
# MYL1iLOUJcAhLwhpAuNMu0wqETDrgXkG4UGVKtQg9guT5Hx2DJ0dJmtfhAH2KpnN
# r97H8OQYok6bLyoMZqaSdSa+2UA1E2+upjcaeuitHFFjBypWBmztfhj24+xkc6Zt
# CDaLrw+ZrnVrFyvCTWrDUUZBVumPwo3/E3Gb2u2e05+r5UWmEsUUWlJBl6MGAAjF
# 5hzqJ4I8O9vmRsTvLQA1E802fZ3lqicIBczOwDYOSxlP0GOabb/FKVMxItt1UHeG
# 0PL4au5rBhs+hSMrl8h+eplBDN1Yfw6owxI9OjWb4J0sjBeBVESoeh2YnZZ/WVim
# VGX/UUIL+Efrz/jlvzCCBr8wggUnoAMCAQICEFCBx8cjvF1zcdb+jyfLv1AwDQYJ
# KoZIhvcNAQELBQAwVzELMAkGA1UEBhMCR0IxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
# aXRlZDEuMCwGA1UEAxMlU2VjdGlnbyBQdWJsaWMgQ29kZSBTaWduaW5nIENBIEVW
# IFIzNjAeFw0yNDAxMzAwMDAwMDBaFw0yNzAzMDMyMzU5NTlaMIGmMRIwEAYDVQQF
# EwlIUkIgMTg4NzAxEzARBgsrBgEEAYI3PAIBAxMCREUxHTAbBgNVBA8TFFByaXZh
# dGUgT3JnYW5pemF0aW9uMQswCQYDVQQGEwJERTEPMA0GA1UECAwGSGVzc2VuMR4w
# HAYDVQQKDBVFVUxBTkRBIFNvZnR3YXJlIEdtYkgxHjAcBgNVBAMMFUVVTEFOREEg
# U29mdHdhcmUgR21iSDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAN4W
# dWcgb3odLx6CFSx7LNNWGQIX1JIj4xXVPPWYo6nhO7/XsyICSWpvXGqyRQTacANO
# I+FKySZ31a42y7gryIZOrXCurhZYL0Jq+/JXK47MCn4UNDgrzOTT9grI+Mk3IeO9
# C+0EgBTVyZPm2TDHb4gshAuVHdFqfIMZgglZjYrylwxkgBQCMjHXnOGuEbrI3g1Y
# cgwDtqFizD0WRlgQ0F9s6GLc23Hku+t2+0KVVrsYit2fQs9HHvKAUtc9U5gcinXQ
# tkVQcchYzlgMGIgaLz7UYzdIroXB+a1qHSdO2wefCBOCeqRE+L7Rby7A2/N/YBDH
# LTg4Z3CKtTL2H4KyEdGBSILf5PSfgIV+vXn5+hQMEMKGCmMBPfVTV1n5RswT2avO
# qN+WBm6qVYd07iTZFkoV4f69BgLRWk48027VrWJQS+6n5/MbBB1Gifj7wZ8Y5OL6
# SpdtfyWKQPNXolwQgI7Sajho8E7HZhJEMDH5aotkIr5Zhblazjpv65jwzfFErW7D
# FzeeTorH1gI3CqL3BYAMIKWd3/Djd3ROxUqUhAOnxDZwnlwTrlvHac5OudGunW3X
# PpkLS0TId+sukItNGQZ4yWzKdk2eZShRgEJGAYubarx/vFEpTVP+YHmc+s9G2ak0
# v/6IiYR4+iopyhYX9twpaCAzWFiyLTkRnZcNfdL7AgMBAAGjggG1MIIBsTAfBgNV
# HSMEGDAWgBSBMpJBKyjNRsjEosYqORLsSKk/FDAdBgNVHQ4EFgQUU1vxnlkeYZsD
# gPUGbkzIbYg6nlswDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAwEwYDVR0l
# BAwwCgYIKwYBBQUHAwMwSQYDVR0gBEIwQDA1BgwrBgEEAbIxAQIBBgEwJTAjBggr
# BgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwBwYFZ4EMAQMwSwYDVR0f
# BEQwQjBAoD6gPIY6aHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUHVibGlj
# Q29kZVNpZ25pbmdDQUVWUjM2LmNybDB7BggrBgEFBQcBAQRvMG0wRgYIKwYBBQUH
# MAKGOmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1B1YmxpY0NvZGVTaWdu
# aW5nQ0FFVlIzNi5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28u
# Y29tMCcGA1UdEQQgMB6gHAYIKwYBBQUHCAOgEDAODAxERS1IUkIgMTg4NzAwDQYJ
# KoZIhvcNAQELBQADggGBAAsK5v1VykNj0s2gW0aRqbNx6eXtSdX3+8GRT6x3bxFq
# vPjB+BkY0RYDx/Sb23ouP9pqtA8svhJZfvJ4IM7v9GFuK9bakjFAhYGXSttAHoNb
# i+BApwIjntEZDrvg03q1hntyH9KHWW/9Kw880pMWHLeCNUFLnAATSwckGjvNkJ4U
# 42G5pSLf151x/oLL1XO+UfPmr3TtEN8iaP81SKzIHVypNyjvQmX1RxAfYNfrY6/e
# ooG1+YHCxgCd8BomhE6kUeA5LQFXfdl4Hth+ZIhx/XohzbnrPnTgSpuGQAevFYi2
# al8FYB8e/kCtMB3P3LgBzsaIpiofcEz8ctWFsA21xOi4TG4bgdIEscwxlVzTLUnr
# JxLAiL4vFvGtxxr2Zx88JSr18SJyA3t3A3fyWiMxBj9/GgfmXJf089SqNkaywvi+
# mN9Jbl1+mtVRoJv3qnHuxSOvK9VvsZVlp7siYc+ZS1OZLacDuaxcWnQuxn2LlSxg
# GeroDeukkfErCJbokqXEHDGCFmcwghZjAgEBMGswVzELMAkGA1UEBhMCR0IxGDAW
# BgNVBAoTD1NlY3RpZ28gTGltaXRlZDEuMCwGA1UEAxMlU2VjdGlnbyBQdWJsaWMg
# Q29kZSBTaWduaW5nIENBIEVWIFIzNgIQUIHHxyO8XXNx1v6PJ8u/UDANBglghkgB
# ZQMEAgEFAKB8MBAGCisGAQQBgjcCAQwxAjAAMBkGCSqGSIb3DQEJAzEMBgorBgEE
# AYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJ
# BDEiBCAJu5THt3NYPlbOHokuzrXtzx+lX0QI+5A5kzvlSlFc9DANBgkqhkiG9w0B
# AQEFAASCAgDQtEXG4O+SesLcEXgFfiFbOSYJRO5xhngSSQnzD39nHGinviKAd0de
# CV8yE7LGxPfSm4QYiPYtweQ8HpzibPGsWDcJxNDMKa8ML+7KJSH9cJ4fIa8kwMGp
# 72JbnXgKFcwnf8vW8sPfRVz7ZWhzDu2gb9pMhqqBmNdOg6NRE8EHK93EfoEZbWHg
# W9o9J+8fT35qqiSal81QSmvAIPy37EmNfvGNEtwfGyRTXfC2ZcGZQrrTEzHuBMGd
# QIkmvpl19p5MKEaBRfia2EsK+xy8Mz0OfTIyda1rs0S/t/FI3bkvNr4lJcPi+Or0
# mQjiG1HiV7s9BfYcf8ssuIr0Q9NHY63NvLwH/fFwxYJFmEOIFU1Y6nqUTOXpBDqv
# PvpxyJkImLeWW1n9lYL8qqtP0mFp0P4kMemX8vIAOfdvgadSIb51J2LJX+cxWMoq
# EaE1L4v5M/Crro11fCXxwDvt41aTeGapdD5AoFtwmizFvt6dYt4FbMnqNuf6giOI
# Uzg/uclKUPX28w+ee2J52FnF5u7VPaGwcqEG5tH21yZiVOL2Qeb5FpdPk2c7mDra
# yYDcGYC+hVx0qVVWKR6muaD823YXOmsWHjLA0oU0xZ+aE3Ay+Gdiyu85B/U49IcI
# C1RHwzS/lH6WhLhuqpycx4i+oQZRIRhSoqqShTO2E0J5YrKxYj1BOqGCE08wghNL
# BgorBgEEAYI3AwMBMYITOzCCEzcGCSqGSIb3DQEHAqCCEygwghMkAgEDMQ8wDQYJ
# YIZIAWUDBAICBQAwgfAGCyqGSIb3DQEJEAEEoIHgBIHdMIHaAgEBBgorBgEEAbIx
# AgEBMDEwDQYJYIZIAWUDBAIBBQAEIE3N6Q4u4nO1lSStW4DDr/1GaXRSGA30BNfQ
# xOlhC4NvAhUA3sNoajM8g9yHk10nLSMlULzYQ44YDzIwMjQwMjI1MTcyMTM1WqBu
# pGwwajELMAkGA1UEBhMCR0IxEzARBgNVBAgTCk1hbmNoZXN0ZXIxGDAWBgNVBAoT
# D1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0EgVGltZSBTdGFt
# cGluZyBTaWduZXIgIzSggg3pMIIG9TCCBN2gAwIBAgIQOUwl4XygbSeoZeI72R0i
# 1DANBgkqhkiG9w0BAQwFADB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
# ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0Ew
# HhcNMjMwNTAzMDAwMDAwWhcNMzQwODAyMjM1OTU5WjBqMQswCQYDVQQGEwJHQjET
# MBEGA1UECBMKTWFuY2hlc3RlcjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSww
# KgYDVQQDDCNTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIFNpZ25lciAjNDCCAiIw
# DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAKSTKFJLzyeHdqQpHJk4wOcO1NEc
# 7GjLAWTkis13sHFlgryf/Iu7u5WY+yURjlqICWYRFFiyuiJb5vYy8V0twHqiDuDg
# VmTtoeWBIHIgZEFsx8MI+vN9Xe8hmsJ+1yzDuhGYHvzTIAhCs1+/f4hYMqsws9iM
# epZKGRNcrPznq+kcFi6wsDiVSs+FUKtnAyWhuzjpD2+pWpqRKBM1uR/zPeEkyGux
# megN77tN5T2MVAOR0Pwtz1UzOHoJHAfRIuBjhqe+/dKDcxIUm5pMCUa9NLzhS1B7
# cuBb/Rm7HzxqGXtuuy1EKr48TMysigSTxleGoHM2K4GX+hubfoiH2FJ5if5udzfX
# u1Cf+hglTxPyXnypsSBaKaujQod34PRMAkjdWKVTpqOg7RmWZRUpxe0zMCXmloOB
# mvZgZpBYB4DNQnWs+7SR0MXdAUBqtqgQ7vaNereeda/TpUsYoQyfV7BeJUeRdM11
# EtGcb+ReDZvsdSbu/tP1ki9ShejaRFEqoswAyodmQ6MbAO+itZadYq0nC/IbSsnD
# lEI3iCCEqIeuw7ojcnv4VO/4ayewhfWnQ4XYKzl021p3AtGk+vXNnD3MH65R0Hts
# 2B0tEUJTcXTC5TWqLVIS2SXP8NPQkUMS1zJ9mGzjd0HI/x8kVO9urcY+VXvxXIc6
# ZPFgSwVP77kv7AkTAgMBAAGjggGCMIIBfjAfBgNVHSMEGDAWgBQaofhhGSAPw0F3
# RSiO0TVfBhIEVTAdBgNVHQ4EFgQUAw8xyJEqk71j89FdTaQ0D9KVARgwDgYDVR0P
# AQH/BAQDAgbAMAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgw
# SgYDVR0gBEMwQTA1BgwrBgEEAbIxAQIBAwgwJTAjBggrBgEFBQcCARYXaHR0cHM6
# Ly9zZWN0aWdvLmNvbS9DUFMwCAYGZ4EMAQQCMEQGA1UdHwQ9MDswOaA3oDWGM2h0
# dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNy
# bDB0BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQuc2VjdGln
# by5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNydDAjBggrBgEFBQcwAYYX
# aHR0cDovL29jc3Auc2VjdGlnby5jb20wDQYJKoZIhvcNAQEMBQADggIBAEybZVj6
# 4HnP7xXDMm3eM5Hrd1ji673LSjx13n6UbcMixwSV32VpYRMM9gye9YkgXsGHxwMk
# ysel8Cbf+PgxZQ3g621RV6aMhFIIRhwqwt7y2opF87739i7Efu347Wi/elZI6WHl
# mjl3vL66kWSIdf9dhRY0J9Ipy//tLdr/vpMM7G2iDczD8W69IZEaIwBSrZfUYngq
# hHmo1z2sIY9wwyR5OpfxDaOjW1PYqwC6WPs1gE9fKHFsGV7Cg3KQruDG2PKZ++q0
# kmV8B3w1RB2tWBhrYvvebMQKqWzTIUZw3C+NdUwjwkHQepY7w0vdzZImdHZcN6Ca
# JJ5OX07Tjw/lE09ZRGVLQ2TPSPhnZ7lNv8wNsTow0KE9SK16ZeTs3+AB8LMqSjms
# waT5qX010DJAoLEZKhghssh9BXEaSyc2quCYHIN158d+S4RDzUP7kJd2KhKsQMFw
# W5kKQPqAbZRhe8huuchnZyRcUI0BIN4H9wHU+C4RzZ2D5fjKJRxEPSflsIZHKgsb
# hHZ9e2hPjbf3E7TtoC3ucw/ZELqdmSx813UfjxDElOZ+JOWVSoiMJ9aFZh35rmR2
# kehI/shVCu0pwx/eOKbAFPsyPfipg2I2yMO+AIccq/pKQhyJA9z1XHxw2V14Tu6f
# XiDmCWp8KwijSPUV/ARP380hHHrl9Y4a1LlAMIIG7DCCBNSgAwIBAgIQMA9vrN1m
# mHR8qUY2p3gtuTANBgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVU
# aGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2Vy
# dGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1
# OTU5WjB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
# MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAj
# BgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3
# DQEBAQUAA4ICDwAwggIKAoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++z
# WsB21hoEpc5Hg7XrxMxJNMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr
# 1XEQeYf0RirNxFrJ29ddSU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56i
# XNc48RaycNOjxN+zxXKsLgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0
# IXuXAZSvf4DP0REKV4TJf1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRM
# yIw80xSinL0m/9NTIMdgaZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4O
# MGcrRrc1r5a+2kxgzKi7nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/Q
# OVQtJu5FGjpvzdeE8NfwKMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZp
# kyAcSpcsdxkrk5WYnJee647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnL
# qEbAyfKm/31X2xJ2+opBJNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3a
# a7fb9xhAV3PwcaP7Sn1FNsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6V
# QXqngwIDAQABo4IBWjCCAVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rID
# ZsswHQYDVR0OBBYEFBqh+GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIB
# hjASBgNVHRMBAf8ECDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1Ud
# IAQKMAgwBgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0
# cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmww
# dgYIKwYBBQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVz
# dC5jb20vVVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0
# dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUz
# XRbhtVOBkXXfA3oyCy0lhBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDv
# QMOt0+LkVvlYQc/xQuUQff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h2
# 4URnbY+wQxAPjeT5OGK/EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wW
# eDmTk5SbsdyybUFtZ83Jb5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6o
# b1olcGKBc2NeoLvY3NdK0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPC
# Rx3wXdahc1cFaJqnyTdlHb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLC
# S53xOV5M3kg9mzSWmglfjv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKz
# H7aZlib0PHmLXGTMze4nmuWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof
# 6aFBnf6xuKBlKjTg3qj5PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kH
# qv3sMNrxpy/Pt/360KOE2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661
# ogKGuinutFoAsYyr4/kKyVRd1LlqdJ69SK6YMYIELDCCBCgCAQEwgZEwfTELMAkG
# A1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
# U2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSUwIwYDVQQDExxTZWN0
# aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBAhA5TCXhfKBtJ6hl4jvZHSLUMA0GCWCG
# SAFlAwQCAgUAoIIBazAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwHAYJKoZI
# hvcNAQkFMQ8XDTI0MDIyNTE3MjEzNVowPwYJKoZIhvcNAQkEMTIEMJZW1nh+FaJE
# gMR2wwE8g7KOSWRLIsvt/5cTYBi2eMYHeha9DCLAZ6yH4IGU2udVDDCB7QYLKoZI
# hvcNAQkQAgwxgd0wgdowgdcwFgQUrmKvdQoMvUfWRh91aOK8jOfKT5QwgbwEFALW
# W5Xig3DBVwCV+oj5I92Tf62PMIGjMIGOpIGLMIGIMQswCQYDVQQGEwJVUzETMBEG
# A1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
# FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBD
# ZXJ0aWZpY2F0aW9uIEF1dGhvcml0eQIQMA9vrN1mmHR8qUY2p3gtuTANBgkqhkiG
# 9w0BAQEFAASCAgCMJL/HIidfbgc+sUC2dNMBJW5NdBmsBvA/Ft4DbbVrE4qnjmrK
# 6ASnnsH5i01AD8I9/BvmRM6FAXpEmgRH9ZUv2A00fGk7bqsl50NEc5ESrAWs8hcS
# +5q4OZvRQ9mHcII/2/jx15KvGIo5jNydJ1F7ua1XW/dWWHQz+lhPjHoOgf6hYOwO
# TDiP6r+3SVNtCr65KpYOkyMsefjNdPhAUdz3oRiGDOb8JDdAkepnV5UcCHIpyo72
# Vndf3bMWsmCfE9UHpn/uZKr6Qv8mAghe2UyFY5WYJhnYUypSIRz4h/i4/hvgrQCx
# e24DZw4YI75KuatEpTXeZ7zE9Ju6wSCyjIdxs1ibZjIEkRLeEykq9AmiHSzvIjqZ
# 2zMW3zmwjyKT7AgQkZt3YoePm3zSnZeH7tZjdWPv/PGyrI1h+8QKr62SnLlW2TDD
# qlhmNJYunCMILePrYL6kumJUBAYGjq4Y8NM2xEiRWI/+C95OyDHNGzr+MTcJxbf6
# lxe9tscVMnqg/42TDIXzubXlO7JuNzIJJel6SNojfdN4VqHqIejTMCfUW7sDC5+L
# 8e0rKzccMkh8bL0xuq7or79wkxWIbNfaikRqHwJuPZvUND0uftOzYO9WF2HofxjN
# EEPuGMULtx4WJOg+bsEXTt4qlJxLn1/tTi+6PV1NN250003a1xexVh0Cpg==
# SIG # End signature block
