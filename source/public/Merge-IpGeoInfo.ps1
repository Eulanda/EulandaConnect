function Merge-IpGeoInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$xmlFile1 = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'xmlFile1', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$xmlFile2 = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'xmlFile2', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$outputFile = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'outputFile', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ipGeoInfos1' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ipGeoInfos2' -Scope 'Private' -Value ($null)
        New-Variable -Name 'mergedIpGeoInfos' -Scope 'Private' -Value ([System.Collections.Hashtable]::new())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Deserialize XML files into objects
        $ipGeoInfos1 = Import-Clixml -Path $xmlFile1
        $ipGeoInfos2 = Import-Clixml -Path $xmlFile2

        # Add all entries from the first set to the result
        foreach ($info in $ipGeoInfos1) {
            $mergedIpGeoInfos[$info.IP] = $info
        }

        # Merge the second set into the result
        foreach ($info in $ipGeoInfos2) {
            if (-not $mergedIpGeoInfos.ContainsKey($info.IP) -or
                ($mergedIpGeoInfos.ContainsKey($info.IP) -and $mergedIpGeoInfos[$info.IP].ChangeDate -lt $info.ChangeDate)) {
                $mergedIpGeoInfos[$info.IP] = $info
            }
        }
    }

    end {
        # Serialize the merged data back into an XML file
        $mergedIpGeoInfos.Values | Export-Clixml -Path $outputFile
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Merge-IpGeoInfo -xmlFile1 'path\to\file1.xml' -xmlFile2 'path\to\file2.xml' -outputFile 'path\to\output.xml'
}
