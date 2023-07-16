function Out-Welcome {
    [CmdletBinding()]
    Param (
        [parameter(Position = 0, Mandatory = $false)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ) {
                throw "File or folder '$_' does not exist!"
             } else {
                 $true
            }
        })]
        [ValidateScript({
            if($_ -notmatch "(\.ps1)") {
                throw "The file '$_' specified in the path argument must of type .ps1"
            } else {
                 $true
            }
        })]
        [string]$projectScript
        ,
        [parameter(Position = 1, Mandatory = $false)]
        [switch]$noBanner
        ,
        [parameter(Position = 2, Mandatory = $false)]
        [switch]$noInfo
        ,
        [parameter(Position = 3, Mandatory = $false)]
        [string]$culture
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'banner' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'cultureObj' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $banner = @"
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

"@
        if (! $noBanner) {
            write-host $banner -ForegroundColor "blue"
        }

        New-Variable -Name 'ecStartTime' -Scope 'Global'  -Option ReadOnly -Force -Value ([datetime](Get-Date)) -Description 'Start time of EulandaConnect module'

        if (! $culture) {
            $culture = [System.Threading.Thread]::CurrentThread.CurrentCulture.Name
        } else {
            $cultureObj = [System.Globalization.CultureInfo]::GetCultureInfo($culture)
            [System.Threading.Thread]::CurrentThread.CurrentCulture = $cultureObj
            [System.Threading.Thread]::CurrentThread.CurrentUiCulture = $cultureObj
            New-Variable -Name 'ecCulture' -Scope 'Global' -Option ReadOnly -Force -Value ([string]$culture) -Description 'User language like en-US of EulandaConnect module'
        }

        if ($projectScript) {
            if ($PsVersionTable.PsVersion.Major -gt 5) {
                $leafBase = ([string](Split-Path -LeafBase $projectScript))
            } else {
                [string]$leafBase = (Get-Item $projectScript).BaseName
            }
            New-Variable -Name 'ecProjectName' -Scope 'Global'  -Option ReadOnly -Force -Value $leafBase -Description 'Project name using EulandaConnect module'
            New-Variable -Name 'ecProjectVersion' -Scope 'Global' -Option ReadOnly -Force -Value ([version](Read-VersionFromSynopsis -path $projectScript)) -Description 'Project version using for the EulandaConnect module'
        }

        Write-Verbose "$($myInvocation.Mycommand) $((get-module -Name EulandaConnect).path)"

        if (! $noInfo) {
            Write-Host  ( (Get-ResStr 'OUT_WELCOME_VERSION') -f $ecModuleName, $($ecModuleVersion.ToString()))  -ForegroundColor Blue
            Write-Verbose  ( (Get-ResStr 'OUT_WELCOME_VERSION') -f $ecModuleName, $($ecModuleVersion.ToString()))
            Write-Host  ( (Get-ResStr 'OUT_WELCOME_COPYRIGHT') -f $($ecModuleCopyright))  -ForegroundColor Blue
            Write-Host  ( (Get-ResStr 'OUT_WELCOME_LICENSEURI') -f $($ecModuleLicenseURI)) -ForegroundColor Blue
            Write-Host  ( (Get-ResStr 'OUT_WELCOME_PATH') -f $($ecModulePath)) -ForegroundColor Blue
            write-host  ( (Get-ResStr 'OUT_WELCOME_STARTTIME') -f $(Use-Culture -culture $ecCulture -script {$($ecStartTime.toString())})) -ForegroundColor Blue
            if ($ecProjectVersion -gt [version]"0.0") {
                write-host  ( (Get-ResStr 'OUT_WELCOME_PROJECTVERSION') -f $($ecProjectName), $($ecProjectVersion.ToString())) -ForegroundColor Green
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Out-Welcome -culture 'en-US'
}
