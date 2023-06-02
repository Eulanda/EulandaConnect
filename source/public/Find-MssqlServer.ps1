Function Find-MssqlServer {
    [CmdletBinding()]
     param(
        [parameter(Mandatory = $false)]
        [string]$localIp = (Get-LocalIp)
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteIp = '255.255.255.255'
        ,
        [Parameter(Mandatory = $false)]
        [int]$udpPort = 1434
        ,
        [Parameter(Mandatory = $false)]
        [int]$timeoutSeconds = 2
     )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'broadcastIP' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'udpClient' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tempObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'startTime' -Scope 'Private' -Value ($null)
        New-Variable -Name 'responseString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'response' -Scope 'Private' -Value ($null)
        New-Variable -Name 'receivedEndpoint' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rawString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'udpPacket' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'pairs' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'list' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'item' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'foundServers' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'endpoint' -Scope 'Private' -Value ($null)
        New-Variable -Name 'elapsedTime' -Scope 'Private' -Value ([double]0.0)
        New-Variable -Name 'localEndpoint' -Scope 'Private' -Value ($null)
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # $result = New-Object System.Collections.ArrayList

        # Create UDP client
        $udpClient = New-Object System.Net.Sockets.UdpClient
        $udpClient.Client.ReceiveTimeout = $timeoutSeconds * 1000
        $udpClient.Client.SetSocketOption([System.Net.Sockets.SocketOptionLevel]::Socket, [System.Net.Sockets.SocketOptionName]::Broadcast, 1)

        # Bind UDP client to local network interface
        $localEndpoint = New-Object System.Net.IPEndPoint ([System.Net.IPAddress]::Parse($localIp), 0)
        $udpClient.Client.Bind($localEndpoint)

        # Prepare magic message
        $udpPacket = 0x02, 0x00, 0x00

        # Broadcast or single remote ip
        $endpoint = New-Object System.Net.IPEndPoint ([System.Net.IPAddress]::Parse($remoteIp), $udpPort)

        # Send message
        $udpClient.Send($udpPacket, $udpPacket.Length, $endpoint) | Out-Null

        # Wait for response
        $startTime = Get-Date
        $elapsedTime = 0
        $foundServers = @{}

        try {
            while ($elapsedTime -lt $timeoutSeconds) {
                if ($udpClient.Available -gt 0) {
                    try {
                        $receivedEndpoint = New-Object System.Net.IPEndPoint ([System.Net.IPAddress]::Any, 0)
                        $response = $udpClient.Receive([ref]$receivedEndpoint)
                        $responseString = [System.Text.Encoding]::ASCII.GetString($response)

                        if (-not $foundServers.ContainsKey($receivedEndpoint.Address.ToString())) {
                            $foundServers.Add($receivedEndpoint.Address.ToString(), $true)

                            $rawString = $responseString.Substring(3,$responseString.Length-3)
                            $rawString = $rawString.Replace(';;',"`t")
                            $list = $rawString.Split("`t").trim()
                            $list = $list | Where-Object { $_ -ne "" }
                            foreach ($item in $list) {
                                $pairs = $item.Split(';')
                                $tempObj= [PSCustomObject]@{
                                    Ip = $($receivedEndpoint.Address)
                                }
                                for ($i = 0; $i -lt $pairs.Length; $i += 2) {
                                    $key = $pairs[$i]
                                    $value = $pairs[$i+1]
                                    Add-Member -InputObject $tempObj -MemberType NoteProperty -Name $key -Value $value
                                }
                                $result.Add($tempObj) | Out-Null
                            }
                        }
                    }
                    catch [System.Net.Sockets.SocketException] {
                        if ($_.Exception.ErrorCode -ne 10060) {
                            throw
                        }
                    }
                }
                Start-Sleep -Milliseconds 100
                $elapsedTime = (Get-Date) - $startTime
                $elapsedTime = $elapsedTime.TotalSeconds
            }
        }
        finally {
            $udpClient.Close()
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Find-MssqlServer -remoteIp '192.168.41.1'
 }
