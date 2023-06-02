function New-Snapshot {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if ($_ -match "^[a-zA-Z]:$") {
                if (Test-Path $_) {
                    $true
                }
                else {
                    throw (( Get-ResStr 'DRIVE_NOT_EXISTS') -f $_, $myInvocation.Mycommand)
                }
            }
            else {
                throw (( Get-ResStr 'DRIVE_FORMAT_ERROR') -f 'volume', $myInvocation.Mycommand)
            }
        })]
        [string]$volume = $($ENV:SystemDrive)
        ,
        [Parameter(Mandatory = $false)]
        $symbolicLink = "$volume\ecSnapshot"
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'snapshot' -Scope 'Private' -Value ($null)
        New-Variable -Name 'snapshotPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (Test-Administrator) {
            Write-Verbose ((Get-ResStr 'VERBOSE_SNAPSHOT_CREATING') -f $volume, $symbolicLink)
            $snapshot = Invoke-CimMethod -ClassName Win32_ShadowCopy -MethodName Create -Arguments @{Volume = "$volume\"}
            $snapshotPath = (Get-CimInstance -ClassName Win32_ShadowCopy | Where-Object { $_.ID -eq $snapshot.ShadowID }).DeviceObject
            if (! ($snapshotPath.EndsWith('\'))) {
                $snapshotPath += '\'
            }

            # If for some reason exists from prior operations
            Remove-SymbolicLink -symbolicLink $symbolicLink

            # The output as function result must be prevented
            # $cmdOutput = Invoke-Expression -Command "cmd /c mklink /d '$symbolicLink' '$snapshotPath'"
            # Write-Verbose $cmdOutput
            New-SymbolicLink -symbolicLink $symbolicLink -target $snapshotPath

            $result = [PSCustomObject]@{
                shadowId = $snapshot.ShadowID
                volume = $volume
                snapshotPath = $snapshotPath
                symbolicLink = $symbolicLink
            }
        } else {
            throw ((Get-ResStr 'ADMIN_RIGHTS_NEEDED') -f $myInvocation.MyCommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $result
    }
    # Test:   $snap = NewSnapshot
}
