Function Get-RemoteNextFilename {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [parameter(Mandatory = $false)]
        [string]$mask = '*'
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }

        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            if ($protocol -eq 'sftp') {
                $result = Get-SftpNextFilename -server $server -port $port -certificate $certificate -user $user -password $password -mask $mask -remoteFolder $remoteFolder
            } else {
                $result = Get-FtpNextFilename -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -mask $mask -remoteFolder $remoteFolder
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-RemoteNextFile -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure' -mask '*.xml' -remoteFolder '/EULANDA'  -verbose
}
