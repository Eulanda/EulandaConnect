function Rename-SftpFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
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
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

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
                port = $port
                certificate = $certificate
                user = $user
                password = $password
            }

            if (! (Test-SftpFolder @remoteParams -remoteFolder $remoteFolder)) {
                Throw ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f $remoteFolder, $myInvocation.Mycommand)
            }

            if (Test-SftpFolder @remoteParams -remoteFolder $newFolder) {
                Throw ((Get-ResStr 'REMOTE_FOLDER_EXISTS_ALREADY') -f $newFolder, $myInvocation.Mycommand)
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                Move-SFTPItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -Destination $newFolder
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }

    <# Test:

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
            Rename-SftpFolder -server $server -user $user -password $secure -remoteFolder '/inbox' -newFolder '/inbox-new'
        }

        # The 'inbox' folder example belongs to the ftp server test environment we recommend.
    #>
}
