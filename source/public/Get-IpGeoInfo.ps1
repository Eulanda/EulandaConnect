function Get-IpGeoInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$age = 6  # default age is 6 months
        ,
        [Parameter(Mandatory = $false)]
        [int]$apiWait = 2000  # default apiWait is 2000 milliseconds
        ,
        [Parameter(Mandatory = $false)]
        [string]$xmlGeoPath = 'IpGeoInfo.xml'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'entry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'eulandaConnectFolderPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'homeFolderPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($xmlGeoPath -notmatch '\\') {
            # Use the user home folder and the '.eulandaconnect' folder
            $homeFolderPath = [Environment]::GetFolderPath('UserProfile')
            $eulandaConnectFolderPath = Join-Path -Path $homeFolderPath -ChildPath '.eulandaconnect'

            # Creates the '.eulandaconnect' folder if it does not exist
            if (-not (Test-Path $eulandaConnectFolderPath)) {
                New-Item -ItemType Directory -Path $eulandaConnectFolderPath | Out-Null
            }

            $xmlGeoPath = Join-Path -Path $eulandaConnectFolderPath -ChildPath $xmlGeoPath
        }

        Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_PATH') -f $xmlGeoPath)
        if (! (Test-Path variable:global:geoHashTable)) {
            if (Test-Path $xmlGeoPath) {
                $global:geoHashTable = Import-Clixml -Path $xmlGeoPath

                <#
                    # On The Fly Update if the format changes

                    # Check and update the existing entries to use the new structure
                    # We have added createdate and changedate
                    $keys = $global:geoHashTable.Keys
                    $tempHashTable = @{}
                    foreach ($key in $keys) {
                        $entry = $global:geoHashTable[$key]
                        if (-not ($entry | Get-Member -Name createDate -ErrorAction SilentlyContinue)) {
                            $tempHashTable[$key] = New-Object PSObject -Property @{
                                createDate = Get-Date
                                changeDate = Get-Date
                                data = $entry
                            }
                        }
                        else {
                            $tempHashTable[$key] = $entry
                        }
                    }
                    $global:geoHashTable = $tempHashTable
                    $global:geoHashTable | Export-Clixml -Path $xmlGeoPath
                #>

            } else {
                $global:geoHashTable = @{}
            }
        }
        $result = '-1'  # Default for exceptions

        if (!(Test-Path variable:global:lastGeoIpInfoCall)) {
            $global:lastGeoIpInfoCall = Get-Date
        }

        if (! (Test-IpAddress -ip $ip)) {
            $result = '-2'
        } elseif (Test-PrivateIP -ip $ip) {
            $result = '-3'
        } elseif (Test-ReservedIP -ip $ip) {
            $result = '-4'
        } elseif ($global:geoHashTable.ContainsKey($ip)) {
            # If it is a known Ip then retrieve it from cache
            $entry = $global:geoHashTable[$ip]
            $result = $entry.data.countryCode

            # Check if the entry is older than $age months
            if ($entry.changeDate.AddMonths($age) -lt (Get-Date)) {
                try {
                    $currentTime = Get-Date
                    $elapsedTime = $currentTime - $global:lastGeoIpInfoCall
                    $waitTime = [Math]::Max(0, $apiWait - $elapsedTime.TotalMilliseconds)
                    if ($waitTime -gt 0) {
                        Start-Sleep -Milliseconds $waitTime
                    }
                    Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_WAITTIME') -f $waitTime)
                    $response = Invoke-RestMethod -Uri "http://ip-api.com/json/$ip"
                    $global:lastGeoIpInfoCall = Get-Date

                    if ($response.status -eq 'fail') {
                        $result = '-1'
                        Write-Error ((Get-ResStr 'GEOINFO_API_FAILED') -f $($response.message))
                    } else {
                        # Update the entry and save it
                        $entry.data = $response
                        $result = $response.countryCode
                        $entry.changeDate = Get-Date
                        $global:geoHashTable[$ip] = $entry
                        $global:geoHashTable | Export-Clixml -Path $xmlGeoPath
                        Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_NEW_ENTRY') -f $ip, $result.ToString())
                    }
                }
                catch {
                    $result = '-1'
                    Write-Error ((Get-ResStr 'GEOINFO_GENERAL_ERROR') -f $_)
                }
            }
        }
        else {
            try {
                $currentTime = Get-Date
                $elapsedTime = $currentTime - $global:lastGeoIpInfoCall
                $waitTime = [Math]::Max(0, $apiWait - $elapsedTime.TotalMilliseconds)
                if ($waitTime -gt 0) {
                    Start-Sleep -Milliseconds $waitTime
                }
                Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_WAITTIME') -f $waitTime)
                $response = Invoke-RestMethod -Uri "http://ip-api.com/json/$ip"
                $global:lastGeoIpInfoCall = Get-Date

                if ($response.status -eq 'fail') {
                    $result = '-1'
                    Write-Error ((Get-ResStr 'GEOINFO_API_FAILED') -f $($response.message))
                } else {
                    # Add new entry and save it
                    $entry = New-Object PSObject -Property @{
                        createDate = Get-Date
                        changeDate = Get-Date
                        data = $response
                    }
                    $result = $response.countryCode
                    $global:geoHashTable.Add($ip, $entry)
                    $global:geoHashTable | Export-Clixml -Path $xmlGeoPath
                    Write-Verbose ((Get-ResStr 'VERBOSE_GEOINFO_NEW_ENTRY') -f $ip, $result.ToString())
                }
            }
            catch {
                $result = '-1'
                Write-Error ((Get-ResStr 'GEOINFO_GENERAL_ERROR') -f $_)
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Get-IpGeoInfo -ip 79.42.55.123 -verbose -debug
}
