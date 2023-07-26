#
# Module manifest for module 'EulandaConnect'
#
# Generated by: Christian Niedergesäß - https://www.eulanda.eu
#
# Generated on: 07/26/2023
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'EulandaConnect.psm1'

# Version number of this module.
ModuleVersion = '3.2.6'

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
    'Install-LatestOpenVPN',
    'Install-SignTool',
    'Merge-IpGeoInfo',
    'New-ConnStr',
    'New-Delivery',
    'New-DeliveryPropertyItem',
    'New-EulException',
    'New-EulLog',
    'New-OpenVpnCa',
    'New-OpenVpnServerConfig',
    'New-OpenVpnTls',
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
    'Test-ArticlePropertyItem',
    'Test-Console',
    'Test-HasProperty',
    'Test-IpAddress',
    'Test-MssqlAdministrator',
    'Test-Numeric',
    'Test-PrivateIp',
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
# MIIpiQYJKoZIhvcNAQcCoIIpejCCKXYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDG2v3yxT/EmERW
# qmyc5jYP19W7HcJqzKPHz/3bVY8yBqCCEngwggVvMIIEV6ADAgECAhBI/JO0YFWU
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
# VGX/UUIL+Efrz/jlvzCCBuEwggVJoAMCAQICEGilgQZhq4aQSRu7qELTizkwDQYJ
# KoZIhvcNAQELBQAwVzELMAkGA1UEBhMCR0IxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
# aXRlZDEuMCwGA1UEAxMlU2VjdGlnbyBQdWJsaWMgQ29kZSBTaWduaW5nIENBIEVW
# IFIzNjAeFw0yMjAxMjcwMDAwMDBaFw0yNDAxMjcyMzU5NTlaMIGmMRIwEAYDVQQF
# EwlIUkIgMTg4NzAxEzARBgsrBgEEAYI3PAIBAxMCREUxHTAbBgNVBA8TFFByaXZh
# dGUgT3JnYW5pemF0aW9uMQswCQYDVQQGEwJERTEPMA0GA1UECAwGSGVzc2VuMR4w
# HAYDVQQKDBVFVUxBTkRBIFNvZnR3YXJlIEdtYkgxHjAcBgNVBAMMFUVVTEFOREEg
# U29mdHdhcmUgR21iSDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMzT
# O8Mbj+llr7AC7DuCfXcQUJJsAnYeHudXCXyw/vCpdBJLvd3IMkk0EGtl/owTlq9t
# m6tdzPTjh4bUjJQVqmsdfo15EldPOI9fTuaoG4xBDeJwhdFC/tiNfq/JsCWWclca
# 50QBBo5JDAZvCJSrw71t7s5LLzs0rHMUnDjKyjAWwd7qC+tTZdwaGAppx6bpL9vd
# CzLZDQZGbOkZL1eaPikwkou98XY7DeaF/SzpAuQP6oVfgjoe82fLlgXBhl92KGB8
# M+E96okXJNrNFPY3iYWLRJk5D/r0NUkJR+NY/hxC8wnRqLyc9ANh99ykTSe5OlD9
# kx4DlStypnmQIm9oV+oRKr3cXKH+QvWh23sjdw42pkiHK0MP39RJDs5Jk0NG8FUY
# MrMTFiTmsxg9sJsLKWmFy/MzvJycVHnyKe6WTMeVz63ouCK/Ep41BIuajW/ivcCx
# LfSYAwzxpGQgEdta2eZrvna9+EzTiuEBoaV4mDGTdg1/P8Hjr/9a6fREl82Rqw3W
# CCt6ymOb31fxkUSr6Be26CY3JEHnxbb30PsVmNFCdayKjKbjf39zzTEWQRGSywC7
# +bgQWHu2kFvSH9YSWTxDjZdsdrL2bUvmobCTmaDCxTgjRiaBh+jSzhQ0M1MkQNzf
# W/gwP4z6a0FO2YatdXJFVGpV4rOzlHOsulFiyvgNAgMBAAGjggHXMIIB0zAfBgNV
# HSMEGDAWgBSBMpJBKyjNRsjEosYqORLsSKk/FDAdBgNVHQ4EFgQUsZ5evsRYcZpr
# WcPwOErnS2ZxP7cwDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAwEwYDVR0l
# BAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEkGA1UdIARCMEAwNQYM
# KwYBBAGyMQECAQYBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20v
# Q1BTMAcGBWeBDAEDMEsGA1UdHwREMEIwQKA+oDyGOmh0dHA6Ly9jcmwuc2VjdGln
# by5jb20vU2VjdGlnb1B1YmxpY0NvZGVTaWduaW5nQ0FFVlIzNi5jcmwwewYIKwYB
# BQUHAQEEbzBtMEYGCCsGAQUFBzAChjpodHRwOi8vY3J0LnNlY3RpZ28uY29tL1Nl
# Y3RpZ29QdWJsaWNDb2RlU2lnbmluZ0NBRVZSMzYuY3J0MCMGCCsGAQUFBzABhhdo
# dHRwOi8vb2NzcC5zZWN0aWdvLmNvbTA2BgNVHREELzAtoBwGCCsGAQUFBwgDoBAw
# DgwMREUtSFJCIDE4ODcwgQ1jbkBldWxhbmRhLmRlMA0GCSqGSIb3DQEBCwUAA4IB
# gQBNj78jtsmPrpiGXPRt/DAyJJDd8CHHbH7SQpEC2abBc4ypmnseXbSIQlZdySaJ
# BOrDqj75gjB5FOSbir9FsIzPLgP2qjTyxsd3FtRcNcXDK7VIZgxmeJh2ipsXAqsB
# nivA9Vut2mu72wQ877VSkoUYIe7JMAUDKG0qwHU4LyMXoNYttto2y7yR6odDYwGC
# YxXNlPNx9wNVzJOMhnRalP1fwRC9RwjUoizGAEUg5BNh7dKNkSFRzimHh2iAvgeV
# akhbV2+IkekWo7GdEwGLLUSUG8tLwLxOXQ2qsJyOPv0bK/OXiqkgyvqzJ3TRZWiS
# KNX5jSiwwUBrA8vNyCh6d8ZCorwimYkDyGtstF0D9UoU9dX66QrfTsK+zxO7/0QF
# 1qIc5CTZe6Kcsuxe99p5UbPU665d5BvOwq0lJKg59k+6exo1Cc5awip+d4krfyWl
# D1sMkS0eiRSN1UNVs3Hg5gbaEEBx98sQMBF45vv0DFgY/SQVRp9yaFayTyfbb/qk
# jc8xghZnMIIWYwIBATBrMFcxCzAJBgNVBAYTAkdCMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxLjAsBgNVBAMTJVNlY3RpZ28gUHVibGljIENvZGUgU2lnbmluZyBD
# QSBFViBSMzYCEGilgQZhq4aQSRu7qELTizkwDQYJYIZIAWUDBAIBBQCgfDAQBgor
# BgEEAYI3AgEMMQIwADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQg1CJjhCqUN3G+
# upkDmpteHFuerJZcGpkFNq2wJwf+DCswDQYJKoZIhvcNAQEBBQAEggIAL1XM908Z
# VBdXF9Zfx+c83MBlbcSorh/fcrcOr2KB12kJgyPQg6H2gQ0k94IDnSQKKbVzD3Fl
# dDVAVFAZfINx248l3jwwTpSK1MeFZIkTk5I0Zi7VYWJnFI28yhjPIVNdLhFXBcEh
# fPiGmzwNUdlDH4LHJhXVK2AQZXvVpkSLmYxMNrz6p0fDP14Wz0Tk6cvBqdPyiGpH
# QmxsnoJBOt9kUloxaNHrvT4fqPx9zuew9vKP/1HsPrkuhL0IzKvBXJOw/MBp7NzK
# V+KwTUZyuTa8foCW24wjTgXFoEaXGeTyujV/kN9CfTZrKMTP/h7bkSHRJxmgmf7e
# 3CgPOS53LRAb2vwkx/aO3sMbAwOIzZ02Ow1fQtJ5LSmYmXclDXPIOFWvfMs+xR8M
# IfuLx/KVo5qLnUQI8eW0HWbGEycu2RcQBbbIhUzjiM57hxlnH691A59mMu52fIPO
# WSp3e0o8wW/AlmAyjXo9AZN+txxAR676J0WJ0FX6eNchXALTXc5u2N+eXKtQj/U5
# UM+tXUL13mG3PGW2KblrrG3FYxydoZ6FbELoMPp2b9sp5eQm14pfjEJ/101X+WC8
# yXrQC/k6dp8C4wU6NUDw+1JOGsGriZKTNZI8GVjBGQx4TDYn6d6yANfnhdQfvNxr
# VdnaU/4aKU3OwuksHyPfDP4TVz4CdCoxUGKhghNPMIITSwYKKwYBBAGCNwMDATGC
# EzswghM3BgkqhkiG9w0BBwKgghMoMIITJAIBAzEPMA0GCWCGSAFlAwQCAgUAMIHw
# BgsqhkiG9w0BCRABBKCB4ASB3TCB2gIBAQYKKwYBBAGyMQIBATAxMA0GCWCGSAFl
# AwQCAQUABCCTCffzroxymnQZTRjtdGxp7KbtQA2w/c+Mxhf0s2uBlQIVAJoxwi1q
# 5kKz8OrA+BMicUZHDA4aGA8yMDIzMDcyNjE4NDMwOFqgbqRsMGoxCzAJBgNVBAYT
# AkdCMRMwEQYDVQQIEwpNYW5jaGVzdGVyMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
# ZWQxLDAqBgNVBAMMI1NlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgU2lnbmVyICM0
# oIIN6TCCBvUwggTdoAMCAQICEDlMJeF8oG0nqGXiO9kdItQwDQYJKoZIhvcNAQEM
# BQAwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
# MA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSUwIwYD
# VQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4XDTIzMDUwMzAwMDAw
# MFoXDTM0MDgwMjIzNTk1OVowajELMAkGA1UEBhMCR0IxEzARBgNVBAgTCk1hbmNo
# ZXN0ZXIxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGln
# byBSU0EgVGltZSBTdGFtcGluZyBTaWduZXIgIzQwggIiMA0GCSqGSIb3DQEBAQUA
# A4ICDwAwggIKAoICAQCkkyhSS88nh3akKRyZOMDnDtTRHOxoywFk5IrNd7BxZYK8
# n/yLu7uVmPslEY5aiAlmERRYsroiW+b2MvFdLcB6og7g4FZk7aHlgSByIGRBbMfD
# CPrzfV3vIZrCftcsw7oRmB780yAIQrNfv3+IWDKrMLPYjHqWShkTXKz856vpHBYu
# sLA4lUrPhVCrZwMlobs46Q9vqVqakSgTNbkf8z3hJMhrsZnoDe+7TeU9jFQDkdD8
# Lc9VMzh6CRwH0SLgY4anvv3Sg3MSFJuaTAlGvTS84UtQe3LgW/0Zux88ahl7brst
# RCq+PEzMrIoEk8ZXhqBzNiuBl/obm36Ih9hSeYn+bnc317tQn/oYJU8T8l58qbEg
# Wimro0KHd+D0TAJI3VilU6ajoO0ZlmUVKcXtMzAl5paDgZr2YGaQWAeAzUJ1rPu0
# kdDF3QFAaraoEO72jXq3nnWv06VLGKEMn1ewXiVHkXTNdRLRnG/kXg2b7HUm7v7T
# 9ZIvUoXo2kRRKqLMAMqHZkOjGwDvorWWnWKtJwvyG0rJw5RCN4gghKiHrsO6I3J7
# +FTv+GsnsIX1p0OF2Cs5dNtadwLRpPr1zZw9zB+uUdB7bNgdLRFCU3F0wuU1qi1S
# Etklz/DT0JFDEtcyfZhs43dByP8fJFTvbq3GPlV78VyHOmTxYEsFT++5L+wJEwID
# AQABo4IBgjCCAX4wHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYD
# VR0OBBYEFAMPMciRKpO9Y/PRXU2kNA/SlQEYMA4GA1UdDwEB/wQEAwIGwDAMBgNV
# HRMBAf8EAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEoGA1UdIARDMEEwNQYM
# KwYBBAGyMQECAQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20v
# Q1BTMAgGBmeBDAEEAjBEBgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLnNlY3Rp
# Z28uY29tL1NlY3RpZ29SU0FUaW1lU3RhbXBpbmdDQS5jcmwwdAYIKwYBBQUHAQEE
# aDBmMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29S
# U0FUaW1lU3RhbXBpbmdDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNl
# Y3RpZ28uY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBMm2VY+uB5z+8VwzJt3jOR63dY
# 4uu9y0o8dd5+lG3DIscEld9laWETDPYMnvWJIF7Bh8cDJMrHpfAm3/j4MWUN4Ott
# UVemjIRSCEYcKsLe8tqKRfO+9/YuxH7t+O1ov3pWSOlh5Zo5d7y+upFkiHX/XYUW
# NCfSKcv/7S3a/76TDOxtog3Mw/FuvSGRGiMAUq2X1GJ4KoR5qNc9rCGPcMMkeTqX
# 8Q2jo1tT2KsAulj7NYBPXyhxbBlewoNykK7gxtjymfvqtJJlfAd8NUQdrVgYa2L7
# 3mzECqls0yFGcNwvjXVMI8JB0HqWO8NL3c2SJnR2XDegmiSeTl9O048P5RNPWURl
# S0Nkz0j4Z2e5Tb/MDbE6MNChPUitemXk7N/gAfCzKko5rMGk+al9NdAyQKCxGSoY
# IbLIfQVxGksnNqrgmByDdefHfkuEQ81D+5CXdioSrEDBcFuZCkD6gG2UYXvIbrnI
# Z2ckXFCNASDeB/cB1PguEc2dg+X4yiUcRD0n5bCGRyoLG4R2fXtoT4239xO07aAt
# 7nMP2RC6nZksfNd1H48QxJTmfiTllUqIjCfWhWYd+a5kdpHoSP7IVQrtKcMf3jim
# wBT7Mj34qYNiNsjDvgCHHKv6SkIciQPc9Vx8cNldeE7un14g5glqfCsIo0j1FfwE
# T9/NIRx65fWOGtS5QDCCBuwwggTUoAMCAQICEDAPb6zdZph0fKlGNqd4LbkwDQYJ
# KoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5
# MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBO
# ZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0
# aG9yaXR5MB4XDTE5MDUwMjAwMDAwMFoXDTM4MDExODIzNTk1OVowfTELMAkGA1UE
# BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
# Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSUwIwYDVQQDExxTZWN0aWdv
# IFJTQSBUaW1lIFN0YW1waW5nIENBMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
# CgKCAgEAyBsBr9ksfoiZfQGYPyCQvZyAIVSTuc+gPlPvs1rAdtYaBKXOR4O168TM
# STTL80VlufmnZBYmCfvVMlJ5LsljwhObtoY/AQWSZm8hq9VxEHmH9EYqzcRaydvX
# XUlNclYP3MnjU5g6Kh78zlhJ07/zObu5pCNCrNAVw3+eolzXOPEWsnDTo8Tfs8Vy
# rC4Kd/wNlFK3/B+VcyQ9ASi8Dw1Ps5EBjm6dJ3VV0Rc7NCF7lwGUr3+Az9ERCleE
# yX9W4L1GnIK+lJ2/tCCwYH64TfUNP9vQ6oWMilZx0S2UTMiMPNMUopy9Jv/TUyDH
# YGmbWApU9AXn/TGs+ciFF8e4KRmkKS9G493bkV+fPzY+DjBnK0a3Na+WvtpMYMyo
# u58NFNQYxDCYdIIhz2JWtSFzEh79qsoIWId3pBXrGVX/0DlULSbuRRo6b83XhPDX
# 8CjFT2SDAtT74t7xvAIo9G3aJ4oG0paH3uhrDvBbfel2aZMgHEqXLHcZK5OVmJyX
# nuuOwXhWxkQl3wYSmgYtnwNe/YOiU2fKsfqNoWTJiJJZy6hGwMnypv99V9sSdvqK
# QSTUG/xypRSi1K1DHKRJi0E5FAMeKfobpSKupcNNgtCN2mu32/cYQFdz8HGj+0p9
# RTbB942C+rnJDVOAffq2OVgy728YUInXT50zvRq1naHelUF6p4MCAwEAAaOCAVow
# ggFWMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQa
# ofhhGSAPw0F3RSiO0TVfBhIEVTAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgw
# BgEB/wIBADATBgNVHSUEDDAKBggrBgEFBQcDCDARBgNVHSAECjAIMAYGBFUdIAAw
# UAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJU
# cnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGow
# aDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVz
# dFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2Vy
# dHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBtVIGlM10W4bVTgZF13wN6Mgst
# JYQRsrDbKn0qBfW8Oyf0WqC5SVmQKWxhy7VQ2+J9+Z8A70DDrdPi5Fb5WEHP8ULl
# EH3/sHQfj8ZcCfkzXuqgHCZYXPO0EQ/V1cPivNVYeL9IduFEZ22PsEMQD43k+Thi
# vxMBxYWjTMXMslMwlaTW9JZWCLjNXH8Blr5yUmo7Qjd8Fng5k5OUm7Hcsm1BbWfN
# yW+QPX9FcsEbI9bCVYRm5LPFZgb289ZLXq2jK0KKIZL+qG9aJXBigXNjXqC72NzX
# StM9r4MGOBIdJIct5PwC1j53BLwENrXnd8ucLo0jGLmjwkcd8F3WoXNXBWiap8k3
# ZR2+6rzYQoNDBaWLpgn/0aGUpk6qPQn1BWy30mRa2Coiwkud8TleTN5IPZs0lpoJ
# X47997FSkc4/ifYcobWpdR9xv1tDXWU9UIFuq/DQ0/yysx+2mZYm9Dx5i1xkzM3u
# J5rloMAMcofBbk1a0x7q8ETmMm8c6xdOlMN4ZSA7D0GqH+mhQZ3+sbigZSo04N6o
# +TzmwTC7wKBjLPxcFgCo0MR/6hGdHgbGpm0yXbQ4CStJB6r97DDa8acvz7f9+tCj
# hNknnvsBZne5VhDhIG7GrrH5trrINV0zdo7xfCAMKneutaIChrop7rRaALGMq+P5
# CslUXdS5anSevUiumDGCBCwwggQoAgEBMIGRMH0xCzAJBgNVBAYTAkdCMRswGQYD
# VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNV
# BAoTD1NlY3RpZ28gTGltaXRlZDElMCMGA1UEAxMcU2VjdGlnbyBSU0EgVGltZSBT
# dGFtcGluZyBDQQIQOUwl4XygbSeoZeI72R0i1DANBglghkgBZQMEAgIFAKCCAWsw
# GgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMBwGCSqGSIb3DQEJBTEPFw0yMzA3
# MjYxODQzMDhaMD8GCSqGSIb3DQEJBDEyBDC2nVw40A155gPyWLdXrjyzFbNcKrH8
# SRuc8myu+M02YLWjjOmHMuW/zEYUcsQ1kBcwge0GCyqGSIb3DQEJEAIMMYHdMIHa
# MIHXMBYEFK5ir3UKDL1H1kYfdWjivIznyk+UMIG8BBQC1luV4oNwwVcAlfqI+SPd
# k3+tjzCBozCBjqSBizCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJz
# ZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
# IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkCEDAPb6zdZph0fKlGNqd4LbkwDQYJKoZIhvcNAQEBBQAEggIAFJje
# AhzsVMA6tdwovD0XgwD7BYPOW/G9efi8jGHjll8BB4RIjflh4BSJcNx0KG1is87L
# i4uxT3VUqr/2YihNOcWamsTxU1l/AXu7xhYkJcjOeKHU7HNDwinZJF+q6W4rYBre
# IuZO/J1axqwgFWwe86mMXHkt4v0De9KpqCX7q+bvlJ6J4YHiblI3pxlBOyON4V/e
# exJAv2dDsVwJvnSZfzuOIXWF3a/zOxpusIBfcWBiQwYv6TIrUmq56qtWQCOEfsyw
# tldgK18cigA4m1hsiDZKXfdqg5g7sAD3faU/W1U22nfG5ZruQ5Kx8+Fp3akqqNfn
# Pr6rr3gDZvUkEFExcZ9MTRWCJupM2h0LRyfYuONlC05Dn0jpHb5zTYM1fEf9i2Pl
# ROpiibVkPeYD5pDDnARrQEKlN1FIZqkHX7zNuPYckUkQ/G59luF/HR+4UYXKJEiy
# OJ0foDTs6elHyGXfR15OqGZzIaa9Jqd65iHRaZLKW8WGl/nYheT+GV/B1+hNk2h8
# GnXeOD+j0sNDnyhszsjbtDIQo057gpNb5UQDTwJX6u9sgqWZ1pilfmlDzLDpEKWu
# DqhzDLW20hL9hae4uu7V4D7cgYjkGCWUeVf+iwN7Aqu06lO1YHqex7BVw7nx0nQe
# fPtywVR4U3BqcejPwIM3GTcBvD5SfSQdRcmbKO0=
# SIG # End signature block
