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
# MIIpiAYJKoZIhvcNAQcCoIIpeTCCKXUCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDxkPgxQajSoDKx
# rAfdC6cLRaNheRDgLl5EP4pRIMpRdqCCEngwggVvMIIEV6ADAgECAhBI/JO0YFWU
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
# jc8xghZmMIIWYgIBATBrMFcxCzAJBgNVBAYTAkdCMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxLjAsBgNVBAMTJVNlY3RpZ28gUHVibGljIENvZGUgU2lnbmluZyBD
# QSBFViBSMzYCEGilgQZhq4aQSRu7qELTizkwDQYJYIZIAWUDBAIBBQCgfDAQBgor
# BgEEAYI3AgEMMQIwADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgwZkyABFXtTIy
# R4/aTIxIG7MRopPFnjKMpZbnkwg+v1MwDQYJKoZIhvcNAQEBBQAEggIANEW8QU/6
# janfGeG/oygmsWWsDVtPhtmTIm7PwZ8Ezkt4FK4r5EL1zWMuXy9EGltVdiO7xVjP
# MVNRiMUlP6mntWW8eSUKOe9RiL01DL02j8RaUArbeLK3tN3UyHhoD9G4WHlCL+Wk
# /kBVbRoPQsn3ybJ2+eqZa5fbBqRYjHDIJ7M0AywXZWSrK3U+yhkeVtzD/obkhOog
# rROp6Hkc/zkYz8YbUJv4YIbFyAI2jheORhbxmJGxhQKElvBOiYYqJd7kdVi1NKOj
# wRJBapqr2U4ZmOlpE+LG3P6qscRiVtHfKOHQ0GaEkvz/7BGnOA/zm0iAHDS5cV07
# eryMjMwzVK28wvXw2rH0FlW5b0Th1/iO+PTWxprRLy2F7fqaAzOIYoZQkzS7Q+le
# CBGQQU9OfNHeYocyKZr8JR3OHA8sdVCO5RI84lbXoA9Gx5C1cJWJjwJkVLu0m5Ap
# Wz0oGPglpZFAgCRDmrn7yR2s0sEZbG26wD8EVsqYndQL7OZAe1qkc6C1l2TGyr5L
# 7ckzJzdaWCuXNlrvZpkajJWHl777MasIn+ffBXW+gDErdkXnUqPHr8wHZ8YiIs5C
# egYkBHKUIERxAPdONVHBjmazI4HTvwjGyDuLKN1PnNQ8+7ggDlJcJoIy1DaeDq5y
# GC9JkINsOKTMWietvapQGsKUqeOqS1hIL3KhghNOMIITSgYKKwYBBAGCNwMDATGC
# EzowghM2BgkqhkiG9w0BBwKgghMnMIITIwIBAzEPMA0GCWCGSAFlAwQCAgUAMIHv
# BgsqhkiG9w0BCRABBKCB3wSB3DCB2QIBAQYKKwYBBAGyMQIBATAxMA0GCWCGSAFl
# AwQCAQUABCAfO2utODHD0KHIKFDIXiHcn/seKmeJsD90BXjCh4/HbwIUfDYVEJwu
# Ec1A0Zn7Q826arAMqEQYDzIwMjMwNjI4MTE0OTQ2WqBupGwwajELMAkGA1UEBhMC
# R0IxEzARBgNVBAgTCk1hbmNoZXN0ZXIxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRl
# ZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0EgVGltZSBTdGFtcGluZyBTaWduZXIgIzSg
# gg3pMIIG9TCCBN2gAwIBAgIQOUwl4XygbSeoZeI72R0i1DANBgkqhkiG9w0BAQwF
# ADB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAw
# DgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNV
# BAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwHhcNMjMwNTAzMDAwMDAw
# WhcNMzQwODAyMjM1OTU5WjBqMQswCQYDVQQGEwJHQjETMBEGA1UECBMKTWFuY2hl
# c3RlcjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSwwKgYDVQQDDCNTZWN0aWdv
# IFJTQSBUaW1lIFN0YW1waW5nIFNpZ25lciAjNDCCAiIwDQYJKoZIhvcNAQEBBQAD
# ggIPADCCAgoCggIBAKSTKFJLzyeHdqQpHJk4wOcO1NEc7GjLAWTkis13sHFlgryf
# /Iu7u5WY+yURjlqICWYRFFiyuiJb5vYy8V0twHqiDuDgVmTtoeWBIHIgZEFsx8MI
# +vN9Xe8hmsJ+1yzDuhGYHvzTIAhCs1+/f4hYMqsws9iMepZKGRNcrPznq+kcFi6w
# sDiVSs+FUKtnAyWhuzjpD2+pWpqRKBM1uR/zPeEkyGuxmegN77tN5T2MVAOR0Pwt
# z1UzOHoJHAfRIuBjhqe+/dKDcxIUm5pMCUa9NLzhS1B7cuBb/Rm7HzxqGXtuuy1E
# Kr48TMysigSTxleGoHM2K4GX+hubfoiH2FJ5if5udzfXu1Cf+hglTxPyXnypsSBa
# KaujQod34PRMAkjdWKVTpqOg7RmWZRUpxe0zMCXmloOBmvZgZpBYB4DNQnWs+7SR
# 0MXdAUBqtqgQ7vaNereeda/TpUsYoQyfV7BeJUeRdM11EtGcb+ReDZvsdSbu/tP1
# ki9ShejaRFEqoswAyodmQ6MbAO+itZadYq0nC/IbSsnDlEI3iCCEqIeuw7ojcnv4
# VO/4ayewhfWnQ4XYKzl021p3AtGk+vXNnD3MH65R0Hts2B0tEUJTcXTC5TWqLVIS
# 2SXP8NPQkUMS1zJ9mGzjd0HI/x8kVO9urcY+VXvxXIc6ZPFgSwVP77kv7AkTAgMB
# AAGjggGCMIIBfjAfBgNVHSMEGDAWgBQaofhhGSAPw0F3RSiO0TVfBhIEVTAdBgNV
# HQ4EFgQUAw8xyJEqk71j89FdTaQ0D9KVARgwDgYDVR0PAQH/BAQDAgbAMAwGA1Ud
# EwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwSgYDVR0gBEMwQTA1Bgwr
# BgEEAbIxAQIBAwgwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
# UFMwCAYGZ4EMAQQCMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuc2VjdGln
# by5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNybDB0BggrBgEFBQcBAQRo
# MGYwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JT
# QVRpbWVTdGFtcGluZ0NBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2Vj
# dGlnby5jb20wDQYJKoZIhvcNAQEMBQADggIBAEybZVj64HnP7xXDMm3eM5Hrd1ji
# 673LSjx13n6UbcMixwSV32VpYRMM9gye9YkgXsGHxwMkysel8Cbf+PgxZQ3g621R
# V6aMhFIIRhwqwt7y2opF87739i7Efu347Wi/elZI6WHlmjl3vL66kWSIdf9dhRY0
# J9Ipy//tLdr/vpMM7G2iDczD8W69IZEaIwBSrZfUYngqhHmo1z2sIY9wwyR5Opfx
# DaOjW1PYqwC6WPs1gE9fKHFsGV7Cg3KQruDG2PKZ++q0kmV8B3w1RB2tWBhrYvve
# bMQKqWzTIUZw3C+NdUwjwkHQepY7w0vdzZImdHZcN6CaJJ5OX07Tjw/lE09ZRGVL
# Q2TPSPhnZ7lNv8wNsTow0KE9SK16ZeTs3+AB8LMqSjmswaT5qX010DJAoLEZKhgh
# ssh9BXEaSyc2quCYHIN158d+S4RDzUP7kJd2KhKsQMFwW5kKQPqAbZRhe8huuchn
# ZyRcUI0BIN4H9wHU+C4RzZ2D5fjKJRxEPSflsIZHKgsbhHZ9e2hPjbf3E7TtoC3u
# cw/ZELqdmSx813UfjxDElOZ+JOWVSoiMJ9aFZh35rmR2kehI/shVCu0pwx/eOKbA
# FPsyPfipg2I2yMO+AIccq/pKQhyJA9z1XHxw2V14Tu6fXiDmCWp8KwijSPUV/ARP
# 380hHHrl9Y4a1LlAMIIG7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTANBgkq
# hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
# FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
# dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
# b3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYDVQQG
# EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
# b3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28g
# UlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
# AoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7XrxMxJ
# NMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ29dd
# SU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+zxXKs
# Lgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REKV4TJ
# f1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NTIMdg
# aZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxgzKi7
# nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE8Nfw
# KMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WYnJee
# 647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2+opB
# JNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7Sn1F
# NsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IBWjCC
# AVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFBqh
# +GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
# AQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0gADBQ
# BgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEEajBo
# MD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0
# UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0
# cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oyCy0l
# hBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/xQuUQ
# ff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5OGK/
# EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFtZ83J
# b5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY3NdK
# 0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqnyTdl
# Hb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSWmglf
# jv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTMze4n
# muWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg3qj5
# PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/360KOE
# 2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr4/kK
# yVRd1LlqdJ69SK6YMYIELDCCBCgCAQEwgZEwfTELMAkGA1UEBhMCR0IxGzAZBgNV
# BAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UE
# ChMPU2VjdGlnbyBMaW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0
# YW1waW5nIENBAhA5TCXhfKBtJ6hl4jvZHSLUMA0GCWCGSAFlAwQCAgUAoIIBazAa
# BgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwHAYJKoZIhvcNAQkFMQ8XDTIzMDYy
# ODExNDk0NlowPwYJKoZIhvcNAQkEMTIEMKxKow3Sh98diqbu/OEXggLliOFfXAyQ
# fdObiP8qc3neGfpia3m6lrl1OPuV+k/UrTCB7QYLKoZIhvcNAQkQAgwxgd0wgdow
# gdcwFgQUrmKvdQoMvUfWRh91aOK8jOfKT5QwgbwEFALWW5Xig3DBVwCV+oj5I92T
# f62PMIGjMIGOpIGLMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNl
# eTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1Qg
# TmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1
# dGhvcml0eQIQMA9vrN1mmHR8qUY2p3gtuTANBgkqhkiG9w0BAQEFAASCAgCKM9lj
# gdtIsdAWwSqPL9l3x0bBd7fxKTgoQbiW3oEyMc90zoxFNWSykyt+jf0bPdBXMYe1
# lvCLOjMgtxbL8TXq1VzPNFeWZgDlA+X3hhYahLAuJYbqjYkHDqpT1E2ekyCxc9ew
# OLOhK4utEHS7PwxhWyJI6gHOGEJhsR3raFTphgdZOuKKEPYLqw0Y4zoi7YfqINp5
# Sj6tu+iGvNBzqxq1rizoyqoucx/aV9snNwNzj0WU9sRUahXuDnd/zuKmVQMiVO91
# JOZQ1QvKYUfqwRfHTs+RsRh6SMKIg/sbEJVVfW+YM0/wUSNU8CEpS39iRLH1l0BR
# YHn5qjWemB8zE2U5C+K4U4wQgnebUd+ou6/+5F7/0XQtGspD7gAWgNe/U90GnUTZ
# XbvHnUnpqyRVUqtL2S6iSLjov3HcNOEZI8dmcUNU9jbu8RDU/ierVJ4Sdtiv7GkF
# gkySipEBgSymjTGkMc6CTIVjcmP/YZkTqI+kpPIZT7nWlH+4sBThJUfpXCLauisX
# /AwRDHrrwyAUg6K3rT/BBp3Vt7coMPYGU1Bon2Ft2QO0nZ8iypd5Osz/3NtGEoXb
# EbDQ4R7zylgnNS8I6yVd8ATpBvhupJUh6eg5CkA2zqhF2apNaRibItwAYAHP7kc1
# nrnJ3gB6sZHVhaRsfndLqp1kvSP5AxNNv6bVMA==
# SIG # End signature block
