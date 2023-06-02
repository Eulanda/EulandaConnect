function Get-SignToolPath {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'folders' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'newestFolder' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rootPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sortedFolders' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'versionRegex' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$rootPath = "$(Get-Path32)\Windows Kits\10\bin\"
        [string]$versionRegex = '^10\.\d+\.\d+\.\d+$'
        $folders = Get-ChildItem -Path $rootPath -Directory | Where-Object { $_.Name -match $versionRegex }
        $sortedFolders = $folders | Sort-Object -Property @{Expression = {[version] $_.Name}; Descending = $true}
        $newestFolder = $sortedFolders | Select-Object -First 1
        $result = Join-Path -Path $newestFolder.FullName -ChildPath 'x64\signtool.exe'
        if (! (Test-Path $result)) {
            throw ((Get-ResStr 'SIGNTOOL_NOT_FOUND') -f $rootPath)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SignToolPath
}
