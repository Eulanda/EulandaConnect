function Confirm-System {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [switch]$all
        ,
        [Parameter(Mandatory = $false)]
        [switch]$administrator
        ,
        [Parameter(Mandatory = $false)]
        [switch]$controlledFolderAccess
        ,
        [Parameter(Mandatory = $false)]
        [switch]$memory
        ,
        [Parameter(Mandatory = $false)]
        [switch]$drives
        ,
        [Parameter(Mandatory = $false)]
        [switch]$network
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'item' -Scope 'Private' -Value ([PSCustomObject]@{})
        New-Variable -Name 'i' -Scope 'Private' -Value ([int]0)
        New-Variable -Name 'diskModel' -Scope 'Private' -Value ''
        New-Variable -Name 'lastSpaceIndex' -Scope 'Private' -Value ([int]0)
        New-Variable -Name 'lastWord' -Scope 'Private' -Value ''
        New-Variable -Name 'status' -Scope 'Private' -Value  ([object[]]$null)
        New-Variable -Name 'broadcastIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'cidr' -Scope 'Private' -Value ([int]0)
        New-Variable -Name 'firstIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'gatewayIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'gatewayName' -Scope 'Private' -Value ''
        New-Variable -Name 'lastIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'localIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'localSubnet' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'maxHosts' -Scope 'Private' -Value ([int]0)
        New-Variable -Name 'networkId' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'publicIp' -Scope 'Private' -Value  ([version]'0.0')
        New-Variable -Name 'result' -Scope 'Private' -Value  ([System.Collections.ArrayList]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {

        # ***************************************************
        # START ERROR HANDLING MISSING ET LEATS ONE PARAMETER
        # ***************************************************
        # List of general parameters to be excluded
        $commonParameters = @(
            'Verbose',
            'Debug',
            'ErrorAction',
            'WarningAction',
            'InformationAction',
            'ErrorVariable',
            'WarningVariable',
            'InformationVariable',
            'OutVariable',
            'OutBuffer',
            'PipelineVariable'
        )

        # Filter PSBoundParameters to get only the specific parameters
        $specificBoundParameters = @($PSBoundParameters.Keys | Where-Object { $_ -notin $commonParameters })

        # Raise an error if no specific parameters were passed
        if ($specificBoundParameters.Count -eq 0) {
            # Extract the names of the specific parameters
            $specificParameters = (Get-Command $MyInvocation.MyCommand).Parameters.Keys | Where-Object { $_ -notin $commonParameters }
            # Convert the parameter list into a formatted string
            $parameterList = ($specificParameters | ForEach-Object { "-$_" }) -join ', '
            Throw ((Get-ResStr 'PARAMS_AT_LEAST_ONE') -f $parameterList, $myInvocation.Mycommand)
        }

        # ***************************************************
        # END ERROR HANDLING
        # ***************************************************


        $result = New-Object System.Collections.ArrayList

        if ($all -or $administrator) {
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_ADMINISTRATIVE_RIGHTS')
                Value = [string](Test-Administrator)
            }
            $result.Add($item) | Out-Null
        }

        if ($all -or $controlledFolderAccess) {
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_RANSOMWARE')
                Value = [bool](Get-MpPreference | Select-Object EnableControlledFolderAccess).toString()
            }
            $result.Add($item) | Out-Null
        }

        if ($all -or $memory) {
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_MEMORY')
                Value = [string]((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB )
            }
            $result.Add($item) | Out-Null
        }

        if ($all -or $drives) {
            for ($i=0; $i -lt (Get-PsDrive -PsProvider FileSystem).count-1; $i++) {
                $item = [PSCustomObject]@{
                    Description = ((Get-ResStr 'CONFIRM_MEMORY') -f (Get-PsDrive -PsProvider FileSystem)[$i].Name)
                    Value = [string]([math]::Round((Get-PsDrive -PsProvider FileSystem)[$i].Free/1GB))
                }
                $result.Add($item) | Out-Null
            }

            $status = wmic diskdrive get model,status
            for ($i=1; $i -lt $Status.count-1; $i++) {
                if ($status[$i].trim()) {
                    $lastWord = ($status[$i].trim() -split " ")[-1]
                    $lastSpaceIndex = $status[$i].trim().LastIndexOf(" ")-1
                    $diskModel = $status[$i].Substring(0, $lastSpaceIndex).trim()
                    $item = [PSCustomObject]@{
                        Description = ((Get-ResStr 'CONFIRM_SMART') -f $diskModel)
                        Value = [string]$Lastword.trim()
                    }
                    $result.Add($item) | Out-Null
                }
            }
        }

        if ($all -or $network) {
            $gatewayIp = Get-GatewayIp
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_GATEWAY_IP')
                Value = [string]$gatewayIp
            }
            $result.Add($item) | Out-Null

            $gatewayName = Get-Hostname ($gatewayIp)
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_GATEWAY_NAME')
                Value = [string]$gatewayName
            }
            $result.Add($item) | Out-Null

            $localIp = Get-LocalIp
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_LOCAL_IP')
                Value = [string]$localIp
            }
            $result.Add($item) | Out-Null

            $localSubnet= Get-Subnet -localIp $localIp
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_LOCAL_SUBNET')
                Value = [string]$localSubnet
            }
            $result.Add($item) | Out-Null

            $cidr= Get-Cidr -subnet $localSubnet
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_LOCAL_CIDR')
                Value = [string]$cidr
            }
            $result.Add($item) | Out-Null

            $publicIp = Get-PublicIp
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_PUBLIC_IP')
                Value = [string]$publicIp
            }
            $result.Add($item) | Out-Null

            $maxHosts= Get-MaxHosts -cidr $cidr
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_MAX_HOSTS')
                Value = [string]$maxHosts
            }
            $result.Add($item) | Out-Null

            $networkId= Get-NetworkId -ip $localIp -cidr $cidr
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_NETWORK_ID')
                Value = [string]$networkId
            }
            $result.Add($item) | Out-Null

            $firstIp= Get-FirstIp -networkId $networkId -cidr $cidr
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_FIRST_IP')
                Value = [string]$firstIp
            }
            $result.Add($item) | Out-Null


            $lastIp= Get-LastIp -networkId $networkId -cidr $cidr
            $item = [PSCustomObject]@{
                Description =  (Get-ResStr 'CONFIRM_LAST_IP')
                Value = [string]$lastIp
            }
            $result.Add($item) | Out-Null


            $broadcastIp= Get-BroadcastIp -networkId $networkId -cidr $cidr
            $item = [PSCustomObject]@{
                Description = (Get-ResStr 'CONFIRM_BROADCAST_IP')
                Value = [string]$broadcastIp
            }
            $result.Add($item) | Out-Null
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Confirm-System -administrator -controlledFolderAccess -memory -drives -network
}
