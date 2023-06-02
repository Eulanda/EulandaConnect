Function Rename-RemoteFile {
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
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'remoteParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($password.GetType().Name -eq 'String') {
            [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
        }
        if (Deny-RemoteFingerprint -server $server -protocol $protocol -port $port) {
            Throw ((Get-ResStr('DENY_FINGERPRINT')) -f $server)
        } else {
            $remoteParams = @{
                server = $server
                port = $port
                user = $user
                password = $password
            }

            if ($protocol -eq 'sftp') {
                Rename-SftpFile @remoteParams  -certificate $certificate -remoteFolder $remoteFolder -remoteFile $remoteFile -newFolder $newFolder -newFile $newFile
            } else {
                Rename-FtpFile @remoteParams -protocol $protocol -activeMode:$activeMode -remoteFolder $remoteFolder -remoteFile $remoteFile -newFolder $newFolder -newFile $newFile
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-RemoteFile -server 'myftp.eulanda.eu' -protocol 'sftp' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -remoteFile 'Eulanda_JohnDoe.zip' -newFile 'John.zip' -verbose
}
