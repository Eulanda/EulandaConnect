# *****************************************************************************
# (c) 2023, EULANDA Software GmbH
#
#     Build process for EulandaConnect
# *****************************************************************************

[cmdletbinding()] Param(
    [switch]$updateManifest      # 1
    ,
    [switch]$updateMarkdown      # 2
    ,
    [switch]$convertToMaml       # 3
    ,
    [switch]$newFinalImage       # 4
    ,
    [switch]$publishToPsGallery  # 5
    ,
    [switch]$updateOnlineDocs    # 6
    ,
    [switch]$invokePester        # 7
    ,
    [switch]$pesterNoTelegram    # Parameter
    )



# Imports only the unit without the complete module,
# because the module is temporarily removed in the script
. "$PsScriptRoot\source\public\Get-SignToolPath.ps1"
. "$PsScriptRoot\source\public\Use-Culture.ps1"



function Get-Manifest {
    param(
        [string]$createDate,
        [string]$version,
        [string]$functionsToExport,
        [string]$assetsFileList
    )

    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

[string]$Result = @"
#
# Module manifest for module 'EulandaConnect'
#
# Generated by: Christian Niedergesäß - https://www.eulanda.eu
#
# Generated on: $createDate
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'EulandaConnect.psm1'

# Version number of this module.
ModuleVersion = '$version'

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
Description = 'Automate operations within your EULANDA ERP software with this powerful PowerShell extension, available on the PsGallery. This extension supports EULANDA ERP 8.x and PowerShell 5.1 or a newer version. It supports features for XML data exchange, delivery notes as HTML, messages to Telegram, diagnostic functions, MSSQL functions such as complete renaming of the database, data backup, finding the SQL browser on the network, creating orders, and much more. Currently, there are over 180 functions available, with an additional 60 functions in preparation for release.'

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
    '$functionsToExport'
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
    $assetsFileList
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
        "Order",
        "Delivery",
        "Invoice",
        "Shop",
        "Store",
        "Carrier",
        "MSSQL",
        "Rename",
        "Database",
        "Signing",
        "Signtool",
        "XM",
        "Telegram",
        "SqlBrowser",
        "Img",
        "Image",
        "Jpg",
        "Jpeg",
        "Resize",
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
        RequireLicenseAcceptance = `$false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/Eulanda/EulandaConnect'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

"@

    Return $result
}



function Get-FunctionsToExport {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    # all functions to be exported from the modul, means all in public
    $params = @{
        Filter      = '*.ps1'
        Recurse     = $true
        ErrorAction = 'Stop'
    }
    try {
        $public = @(Get-ChildItem -Path "$projectFolder\source\public" @params)
    }
    catch {
        Write-Error $_
        throw 'Scanning public folders, but could not be read successfully'
    }
    [string]$Result = "$($public.Basename -join("',`n    '"))"

    Return $Result
}



function Get-SourceFiles {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    # All functions to be exported from the modul, means all in public
    $params = @{
        Filter      = '*.ps1'
        Recurse     = $true
        ErrorAction = 'Stop'
    }
    try {
        $public = @(Get-ChildItem -Path "$projectFolder\source\public" @params)
        $private = @(Get-ChildItem -Path "$projectFolder\source\private" @params)
        $prolog_ = @(Get-ChildItem -Path "$projectFolder\source\others\prolog.ps1")
        $variables_ = @(Get-ChildItem -Path "$projectFolder\source\others\variables.ps1")
        $initialize_ = @(Get-ChildItem -Path "$projectFolder\source\others\initialize.ps1")
        $public_ = @(Get-ChildItem -Path "$projectFolder\source\others\public.ps1")
        $private_ = @(Get-ChildItem -Path "$projectFolder\source\others\private.ps1")
    }
    catch {
        Write-Error $_
        throw 'Scanning public+private folders, but could not be read successfully'
    }
    $result = @($prolog_ + $variables_ + $initialize_ + $public_ + $public + $private_ + $private)

    Return $result
}



function Get-AssetsFileList {
    param(
        [switch]$developer
    )
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    # All files are just in final folder, except psd1 and MAML
    $params = @{
        Filter      = '*.*'
        Recurse     = $false
        ErrorAction = 'Stop'
    }

    try {
        if ($developer) {
            [string]$folder = Resolve-Path -Path "$projectFolder\assets"
            $assets = @((Get-ChildItem -Path "$folder" @params).Name)
            for ($i = 0; $i -lt $assets.Length; $i++) {
                $assets[$i] = ".\assets\" + $assets[$i]
            }

            [string]$folder = Resolve-Path -Path "$projectFolder"
            $languages = @((Get-ChildItem -Path "$folder" -Filter *.resx -ErrorAction Stop).Name)
            for ($i = 0; $i -lt $languages.Length; $i++) {
                $languages[$i] = ".\" + $languages[$i]
            }

            $assets = @('.\EulandaConnect.psd1','.\EulandaConnect.psm1','.\EulandaConnect-help.xml') + $languages + $assets
        } else {
            [string]$folder = Resolve-Path -Path "$projectFolder\final\EulandaConnect"
            $assets =  @((Get-ChildItem -Path "$folder" @params).Name)
            for ($i = 0; $i -lt $assets.Length; $i++) {
                $assets[$i] = ".\" + $assets[$i]
            }
            $assets = @('.\EulandaConnect.psd1','.\EulandaConnect-help.xml') + $assets
        }
    }
    catch {
        Write-Error $_
        throw 'Unable to asset file.'
    }

    $assetsFileList = "`n    '$($assets -join("',`n    '"))'"

    [string]$result = $assetsFileList

    Return $result
}



function Update-FrontMatter {
    param(
        [Parameter(Mandatory=$true)]
        [string]$frontMatter,

        [Parameter(Mandatory=$true)]
        [string]$variable,

        [Parameter(Mandatory=$true)]
        [string]$value
    )
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    if ($frontMatter -match "${variable}: (.*)") {
        if ($variable -ne 'weight') {
            # If weight is specified  in the document it should be used
            $frontMatter = $frontMatter -replace "${variable}: (.*)", "${variable}: $value"
        }
    }
    else {
        $frontMatter += "`r`n$($variable): $value"
    }

    $frontMatter = $frontMatter.Replace("`r`n`r`n", "`r`n")

    return $frontMatter
}



function Sync-MarkdownFiles {
    param(
        [Parameter(Mandatory=$true)]
        [string]$sourceDir
        ,
        [Parameter(Mandatory=$true)]
        [string]$targetDir
        ,
        [Parameter(Mandatory=$false)]
        [int]$weight = 10
        ,
        [Parameter(Mandatory=$false)]
        [int]$chapterWeight = 10
    )
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    # Readme.md on GitHub is the a chapter. In HUGO, which
    # is used for online documentation, this page is named _index.md.

    # Get all markdown files from the source (sorted) and target directory
    $sourceFiles = Get-ChildItem -Path $SourceDir -Filter '*.md'  |  Sort-Object Name

    $targetFiles = Get-ChildItem -Path $TargetDir -Recurse -Filter *.md

    foreach ($sourceFile in $sourceFiles) {
        # String to remove in all Readme.md files
        [string]$hugoLinks = "> **Local links in this readme document do not work, they are rendered for online documentation in HUGO CMS.**`r`n"

        # Read the contents of the source markdown file
        $contentOrg = Get-Content -Path $sourceFile.FullName -Raw

        # Create the target file path, but change the name of the chapter page for HUGO CMS
        if ($sourceFile.Name -eq 'Readme.md') {
            $content = $contentOrg.Replace($hugoLinks, '')
            $targetFile = Join-Path -Path $TargetDir -ChildPath '_index.md'
        } else {
            $content = $contentOrg
            $targetFile = Join-Path -Path $TargetDir -ChildPath $sourceFile.Name
        }

        # Identify local links
        $localLinks = [regex]::Matches($content, '\]\((?!http|/)([^)]+)\)') | ForEach-Object { $_.Groups[1].Value }

        foreach ($link in $localLinks) {
            # Remove  markdown in the name, because it will be an html folder after creation process in Hugo
            $index = $link.LastIndexOf(".md")
            if ($index -gt 0) {
                $adjustedLink = $link.Substring(0, $index)
            } else {
                $adjustedLink = $link
            }
            $filePart = Split-Path -Leaf $adjustedLink

            $parts = $link -split '#'
            if($parts.Length -gt 1) {
                $hashTag = '#' + $parts[1]
            } else {
                $hashTag = ""
            }

            $index = $adjustedLink.LastIndexOf("/")
            if ($index -ne -1) {
                $basePart = $adjustedLink.Substring(0, $index + 1)
            } else {
                $basePart = ''
            }
            if ($basePart) {
               if (($basePart -eq '../docs/') -or ($basePart -eq './docs/')) {
                    $newBasePart = '../../Functions/'
                } elseif (($basePart -eq '../appendix/') -or ($basePart -eq './appendix/')) {
                    $newBasePart = '../../Appendix/'
                } elseif (($basePart -eq '../examples/') -or ($basePart -eq './examples/')) {
                    $newBasePart = '../../Examples/'
                } elseif (($basePart -eq '../general/') -or ($basePart -eq './general/')) {
                    $newBasePart = '../../General/'
                } elseif ($filePart.IndexOf('.') -ge 0) { # all media are going in the root
                    $newBasePart = "/"
                } elseif ($filePart.IndexOf('Readme') -eq 0) { # allreadme links also with hash tag (#)
                    $newBasePart = "../../General/"
                } elseif ($basePart -eq './') {
                    $newBasePart = '../'
                } else {
                    $newBasePart = '../'
                }
            } else {
                $newBasePart = '../'
            }

            $adjustedLink = $newBasePart + $filePart + $hashTag
            try {
                $content = $content -replace "\]\($link\)", "]($adjustedLink)"
            }
            catch {
                Write-Error "Markdown: $sourceFile  | Link: $link | NewLink: $adjustedLink | Exception: $_"
            }
        }

        # Extract the file modification date in local time
        $date = $sourceFile.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")

        if ($sourceFile.Name -eq 'Readme.md') {
            [int]$fileWeight = $chapterWeight
        } else {
            [int]$fileWeight = $weight
        }
        # Matches FrontMatter by the the first occurrence of "---...---"
        if ($content -match "(?s)(---\r?\n.*?\r?\n---)(.*)") {
            $originalFrontMatter = $Matches[1]
            $remainingContent = $Matches[2]

            # Remove the "---" from the original FrontMatter, to get inner data
            $originalFrontMatter = $originalFrontMatter -replace '---', ''
            $originalFrontMatter = $originalFrontMatter.trim()
            $originalFrontMatter = $originalFrontMatter.Replace("`r`n`r`n", "`r`n") # $originalFrontMatter -replace "^\r\n", ""

            # Update 'lastMod' in  FrontMatter with last file changed date
            $frontMatter = Update-FrontMatter -FrontMatter $originalFrontMatter -Variable 'lastMod' -Value $date

            # update 'weight' variable in FrontMatter
            $frontMatter = Update-FrontMatter -FrontMatter $frontMatter -Variable 'weight' -Value $fileWeight

            # Replace the original FrontMatter with the updated one
            $content = "---`r`n$frontMatter`r`n---$remainingContent"
        }
        else {
            # If there was no FrontMatter, add 'date' and 'weight'
            $content = "---`r`nlastMod: $date`r`nweight: $fileWeight`r`n---`r`n`r`n$content"
        }

        # Leave some space in the order, but only if it is not a chapter page.
        if ($sourceFile.Name -ne 'Readme.md') {
            $weight += 10
        }

        # Write the content to the target file
        $path = Split-Path $targetFile
        if (-not (Test-Path $path)) {
            New-Item -ItemType Directory -Path $path -Force | Out-Null
        }
        Set-Content -Path $targetFile -Value $content -NoNewline

        # Remove the copied file from the targetFiles list
        $targetFiles = $targetFiles | Where-Object { $_.FullName -ne $targetFile }
    }
}



function ReleaseToGit {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    Write-Host "Source to GitHub..."

    Push-Location -StackName Github
    Set-Location "$projectFolder"
    git init
    git add *
    git commit -m "Final updates for version v$version"
    git remote add origin https://github.com/Eulanda/EulandaConnect
    git push origin master

    # Create a new Release
    [string]$Tag = "v$Version"
    [string]$Release = gh release list --limit 1
    if ($Release.IndexOf($Tag) -ge 0) {
        Write-Warning "Release '$Tag' exists on GitHub and will be deleted prior to create a new one!"
        gh release delete $tag
    }
    gh release create $Tag --notes "This version was also uploaded to PowerShell Gallery at 'https://www.powershellgallery.com/packages/EulandaConnect' on $(get-date)." --title "Final $Version"

    Pop-Location -StackName Github
}



# *****************************************************************************
# Step 1
# *****************************************************************************
function Update-Manifest {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    Write-Host "Project-Folder: $projectFolder"

    Remove-Module -Name EulandaConnect -force -ErrorAction SilentlyContinue
    if (Test-Path "$projectFolder\EulandaConnect.psd1") {
        Remove-Item -Path "$projectFolder\EulandaConnect.psd1" -Force
    }
    $manifest= Get-Manifest -version $version -createDate $createDate -functionsToExport (Get-FunctionsToExport) -assetsFileList (Get-AssetsFileList -Developer)
    $manifest | Set-Content -Path "$projectFolder\EulandaConnect.psd1" -Encoding UTF8 -Force
    Import-Module "$projectFolder\eulandaConnect.psd1" -force -scope global
    # Import-Module "$projectFolder\eulandaConnect.psd1" -force
}



# *****************************************************************************
# Step 2
# *****************************************************************************
function Update-Markdown {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    Write-Host "Project-Folder: $projectFolder"

    Import-Module -Name platyps
    Remove-Module -Name EulandaConnect -force -ErrorAction SilentlyContinue
    # UNINSTALL-MODULE is neccessary, because Update-MarkdownHelp takes after removing module tone of the installed versions
    # The Problem occurs with Install-SignTool where the new parameter URL was not detected.
    Uninstall-Module -Name EulandaConnect -AllVersions -Force -ErrorAction SilentlyContinue
    Import-Module -Name "$projectFolder\EulandaConnect.psm1" -force
    Update-MarkdownHelp -path "$projectFolder\docs\functions" -force
    New-MarkdownHelp -Module EulandaConnect -OutputFolder "$projectFolder\docs\functions" -erroraction silentlycontinue

    # Update-ReadmeTableOfContents # we don't need it any more (06/2023)
}



# *****************************************************************************
# Step 3
# *****************************************************************************
function ConvertTo-Maml {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    # Delete MAML help
    if (Test-Path "$projectFolder\EulandaConnect-help.xml") {
        Remove-Item -Path "$projectFolder\EulandaConnect-help.xml" -Force
    }

    # Get manifest for developer
    $manifest= Get-Manifest -version $version -createDate $createDate -functionsToExport (Get-FunctionsToExport) -assetsFileList (Get-AssetsFileList -Developer)
    $manifest | Set-Content -Path "$projectFolder\EulandaConnect.psd1" -Encoding UTF8 -Force

    # Create a new MAML help from markdown, using this dummy module
    Import-Module -Name platyps
    Import-Module -Name "$projectFolder\EulandaConnect.psm1"
    New-ExternalHelp $docFolder -OutputPath $projectFolder -force

    # Copy MAML help file to FinalFolder
    if (! (Test-Path "$finalFolder\EulandaConnect-help.xml")) {
        Copy-Item -Path "$projectFolder\EulandaConnect-help.xml" -Force -Destination $finalFolder
    }
}



# *****************************************************************************
# Step 4
# *****************************************************************************
function New-FinalImage {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)
    Write-Host "Build final image into '$finalFolder'..."

    # Delete all in FINAL
    Remove-Item -Path "$finalFolder\*.*" -Force

    # All assets to FINAL
    Copy-Item -Path "$projectFolder\assets\*.*" -Force -Destination "$finalFolder"

    # Put all ps1 files in one file on put it to FINAL
    $moduleContent = Get-SourceFiles | ForEach-Object { $_.OpenText().ReadToEnd() }
    $moduleContent | Out-File "$finalFolder\EulandaConnect.psm1" -Encoding UTF8BOM

    # All resx resources to FINAL
    Copy-Item -Path "$projectFolder\*.resx" -Force -Destination "$finalFolder"

    # Get manifest for FINAL
    $manifest= Get-Manifest -version $version -createDate $createDate -functionsToExport (Get-FunctionsToExport) -assetsFileList (Get-AssetsFileList)
    $manifest | Set-Content -Path "$finalFolder\EulandaConnect.psd1" -Encoding UTF8 -Force

    ConvertTo-Maml
    Approve-Signature "$finalFolder\EulandaConnect.psm1"
    Approve-Signature "$finalFolder\EulandaConnect.psd1"

    # Good place to run pester
}



# *****************************************************************************
# STEP 5
# *****************************************************************************
function Publish-ToPsGallery {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)
    Write-Host "Publish to PowerShell Gallery..."

    # Save location and go to PsGallery folder
    Push-Location -StackName Publishing
    Set-Location -Path $finalFolder

    # To convert NuGet ApiKey to a SecureString serialized as an Xml file you need pwsh 7
    #   [string]$ecHomeFolder = "$home\.eulandaconnect"
    #   [string]$apiKey = "9fiewtYvkix2KcuQXpt2hVJ8r6BrZf4D7pdlGvsRGiHc0Rj"
    #   [securestring]$secureApiKey = ConvertTo-SecureString -String $apiKey -AsPlainText -Force
    #   $secureApiKey | Export-Clixml -Path "$ecHomeFolder\secureNuGetApiKey.xml"

    # Upload all to PsGallery
    [securestring]$secureApiKey = Import-Clixml -Path "$ecHomeFolder\secureNuGetApiKey.xml"
    [string]$apiKey = ConvertFrom-SecureString -SecureString $secureApiKey -AsPlainText # -AsPlainText needs pwsh 7

    try {
        Publish-Module -Path $finalFolder -NuGetApiKey $apiKey -force -SkipAutomaticTags

        # Wait 30 seconds to see the module listed
        Start-Sleep -Seconds 30

        # wait 5 seconds
        Find-Module -Name EulandaConnect

        # Remove just created EulandaConnect modul from runtime
        Remove-Module -Name EulandaConnect -force -ErrorAction SilentlyContinue

        # Install new module
        Install-Module -Name EulandaConnect -force

        # Restore-Location
        Pop-Location -StackName Publishing

        # Upload all Updates and make an release
        ReleaseToGit

        # Open explorer in install path
        explorer.exe "$home\Documents\PowerShell\Modules"
    }
    catch {
        Throw "$myInvocation.Mycommand failed. $_"
    }

}



# *****************************************************************************
# Step 6
# *****************************************************************************
function Invoke-Pester {
    param ()

    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    # Import the module
    Import-Module .\EulandaConnect.psd1

    # Run all Pester tests
    # Pester with no variables
    # $testResults = Invoke-Pester -Path .\tests -Output Detailed -PassThru

    [bool]$noTelegram = $pesterNoTelegram
    $container = New-PesterContainer -Path .\source\tests -Data @{ NoTelegram = $noTelegram; additionalVariable = $noTelegram }
    $testResults = Invoke-Pester -Container $container -Output Detailed -PassThru


    # Print summary of test results
    $testResults | Format-List -Property *
}


# *****************************************************************************
# Step 7
# *****************************************************************************
function Update-OnlineDocs {
    Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

    $sourceBase = "$PSScriptRoot\docs"
    $targetBase = "C:\Git\Hugo\EulandaConnect"

    if (Test-path "$targetBase\content\docs") {
        Remove-Item -Path "$targetBase\content\docs" -Recurse -Force
    }
    New-Item -ItemType Directory -Path "$targetBase\content\docs"

    if ((Test-Path $targetBase)){
        # The root in HUGOS did not have files in his folder
        Sync-MarkdownFiles -SourceDir "$sourceBase\Readme.md" -TargetDir "$targetBase\content" -chapterWeight 10

        Sync-MarkdownFiles -SourceDir "$sourceBase\general" -TargetDir "$targetBase\content\docs\General" -chapterWeight 10
        Sync-MarkdownFiles -SourceDir "$sourceBase\functions" -TargetDir "$targetBase\content\docs\Functions" -chapterWeight 20
        Sync-MarkdownFiles -SourceDir "$sourceBase\examples" -TargetDir "$targetBase\content\docs\Examples" -chapterWeight 30
        Sync-MarkdownFiles -SourceDir "$sourceBase\appendix" -TargetDir "$targetBase\content\docs\Appendix"-chapterWeight 40

        try {
            Push-Location
            Set-Location -Path $targetBase
            if (Test-Path "$targetBase\public") {
                Remove-Item -Path "$targetBase\public\*.*" -Force
            }
            $hugoPath = (Get-Command hugo).Source
            & $hugoPath
        } catch {
            Throw "Error while running Hugo:: $_"
        } finally {
            Pop-Location
        }

    } else {
        Write-Error "The Hugo project is not found in '$targetBase'"
    }
}



function Invoke-Main {
    param(
        [string]$version
    )

    if ($psversiontable.psversion.major -lt 7) {
        Write-Error "Powershell 7.x or higher is required! TERMINATING APP..."
        $LastExitCode = 99
        Exit $LastExitCode
    }

    Clear-Host
    $ErrorActionPreference = 'stop'
    Set-StrictMode -version latest
    Push-Location -StackName 'Main'
    Set-Location $PSScriptRoot

    try {
        # ----------------
        # Preparation
        # ----------------
        Write-Host "Preparation..."

        [string]$finalFolder = "$PSScriptRoot\final\EulandaConnect"
        [string]$projectFolder = "$PSScriptRoot"
        [string]$docFolder= "$PSScriptRoot\docs\functions"
        $newCulture = New-Object System.Globalization.CultureInfo("en-US")
        [string]$createDate = (Get-Date).ToLocalTime().ToString("MM/dd/yyyy", $newCulture)

        if (! (Test-Path $finalFolder)) {
            New-Item -ItemType Directory -Path $finalFolder -Force
        }

        [string]$ecHomeFolder = "$home\.eulandaconnect"
        if ( ! (Test-Path $ecHomeFolder)) {
            New-Item -ItemType Directory -Path $ecHomeFolder
        }

        if ($updateManifest) {
            Update-Manifest                 # Creates new manifest (e.g. for new functions)
        } elseif ($updateMarkdown) {
            Update-Markdown                 # Creates new markdowns from PS1 files or updates them
        } elseif ($convertToMaml) {
            ConvertTo-Maml                  # Generates the MAML XML help from markdowns
        } elseif ($newFinalImage) {
            New-FinalImage                  # Creates an uploadable image in the FinalFolder
        } elseif ($publishToPsGallery) {
            Publish-ToPsGallery             # Publishes to PowerShell Gallery
        } elseif ($updateOnlineDocs) {
            Update-OnlineDocs               # Sync to CMS, Compile Size, Upload
        } elseif ($invokePester) {
            Invoke-Pester                   # Pester tests
        }

    } finally {
        Pop-Location -StackName 'Main'
    }

}

# https://www.powershellgallery.com/api/v2/package/EulandaConnect
# http://www.google.com/ping?sitemap=https://eulandaconnect.eulanda.eu/sitemap.xml
Invoke-Main -version '3.1.6'
