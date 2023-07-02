function Rename-FtpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($newFolder) {
            [string]$newFolder = "$($newFolder.TrimEnd('/'))"
            if (! $newFolder) { $newFolder = '/'}
        } else {
            $newFolder = '/'
        }

        if ($remoteFolder -eq '/') {
            Throw ((Get-ResStr 'REMOTE_FOLDER_ISEMPTY_OR_ROOT') -f 'old', $myInvocation.Mycommand)
        }

        if ($newFolder -eq '/') {
            Throw ((Get-ResStr 'REMOTE_FOLDER_ISEMPTY_OR_ROOT') -f 'new', $myInvocation.Mycommand)
        }

        $remoteParams = @{
            server = $server
            protocol = $protocol
            port = $port
            activeMode = $activeMode
            user = $user
            password = $password
        }

        if (! (Test-FtpFolder @remoteParams -remoteFolder $remoteFolder)) {
            Throw ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f $remoteFolder, $myInvocation.Mycommand)
        }

        if (Test-FtpFolder @remoteParams -remoteFolder $newFolder) {
            Throw ((Get-ResStr 'REMOTE_FOLDER_EXISTS_ALREADY') -f $newFolder, $myInvocation.Mycommand)
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($remoteFolder)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::Rename
        $ftpRequest.UseBinary = $true
        $ftpRequest.KeepAlive = $false

        if ($protocol -eq 'ftps') {
            $ftpRequest.EnableSsl = $true
        } else {
            $ftpRequest.EnableSsl = $false
        }

        if ($activeMode) {
            $ftpRequest.UsePassive = $false
        } else {
            $ftpRequest.UsePassive = $true
        }

        $ftpRequest.RenameTo = $newFolder
        $ftpResponse = $ftpRequest.GetResponse()
        Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
        $ftpResponse.Close()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }

    <#

        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features {
            $pesterFolder = Resolve-Path -path ".\source\tests"
            $iniPath = Join-Path -path $pesterFolder "pester.ini"
            $ini = Read-IniFile -path $iniPath
            $path = $ini['SFTP']['SecurePasswordPath']
            $path = $path -replace '\$home', $HOME
            $secure = Import-Clixml -path $path
            $server = $ini['SFTP']['Server']
            $user = $ini['SFTP']['User']
            Rename-FtpFolder -server $server -user $user -password $secure -remoteFolder '/inbox' -newFolder '/inbox-new'
        }

        # The 'inbox' folder example belongs to the ftp server test environment we recommend.
    #>
}
