function Merge-IpGeoInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$xmlFile1,
        [Parameter(Mandatory = $true)]
        [string]$xmlFile2,
        [Parameter(Mandatory = $true)]
        [string]$outputFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'mergedIpGeoInfos' -Scope 'Private' -Value ([System.Collections.Hashtable]::new())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Deserialize XML files into objects
        $ipGeoInfos1 = Import-Clixml -Path $xmlFile1
        $ipGeoInfos2 = Import-Clixml -Path $xmlFile2

        # Add all entries from the first set to the result
        foreach ($key in $ipGeoInfos1.Keys) {
            $mergedIpGeoInfos[$key] = $ipGeoInfos1[$key]
        }

        # Merge the second set into the result
        foreach ($key in $ipGeoInfos2.Keys) {
            if (-not $mergedIpGeoInfos.ContainsKey($key) -or
                ($mergedIpGeoInfos.ContainsKey($key) -and $mergedIpGeoInfos[$key].changeDate -lt $ipGeoInfos2[$key].changeDate)) {
                $mergedIpGeoInfos[$key] = $ipGeoInfos2[$key]
            }
        }
    }

    end {
        # Serialize the merged data back into an XML file
        $mergedIpGeoInfos | Export-Clixml -Path $outputFile
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Merge-IpGeoInfo -xmlFile1 'path\to\file1.xml' -xmlFile2 'path\to\file2.xml' -outputFile 'path\to\output.xml'
}
