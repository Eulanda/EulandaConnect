Function New-RemoteFolder {
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
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
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
                New-SftpFolder -server $server -port $port -certificate $certificate -user $user -password $password -remoteFolder $remoteFolder
            } else {
                New-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }

    <# Test:

        $pesterFolder = Resolve-Path -path ".\source\tests"
        $iniPath = Join-Path -path $pesterFolder "pester.ini"
        $ini = Read-IniFile -path $iniPath
        $path = $ini['SFTP']['SecurePasswordPath']
        $path = $path -replace '\$home', $HOME
        $secure = Import-Clixml -path $path
        $server = $ini['SFTP']['Server']
        $user = $ini['SFTP']['User']

        $folderName = -join ((65..90) | Get-Random -Count 10 | % {[char]$_})
        New-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder "/$folderName"
        $result = Get-RemoteDir -server $server -protocol sftp -user $user -password $secure -dirType directory
        Write-Host "'$result' are all remote folders including the new '$folderName'"

    #>
}

