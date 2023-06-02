function Send-SftpFile {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server
        ,
        [parameter(Mandatory = $false)]
        [int]$port= 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFolder = '/'
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [parameter(Mandatory = $false)]
        [string]$localFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullLocalPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'fullTempPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tempPath' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if (! $remoteFile) {
                $remoteFile = $localFile
            }

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
            }

            [string]$fullLocalPath = Join-Path $localFolder $localFile
            if (! (Test-Path $fullLocalPath)) {
                Throw ((Get-ResStr 'LOCALFILE_OR_FOLDER_DONT_EXISTS') -f $fullLocalPath, $myInvocation.Mycommand)
            }

            if ($localFile -ne $remoteFile) {
                # Create Tempfolder with destination (remote) file name
                [string]$tempPath = $(New-TempDir)
                [string]$fullTempPath = Join-Path $tempPath $remoteFile
                Copy-Item -Path $fullLocalPath -Destination $fullTempPath -Force
            } else {
                [string]$fullTempPath = $fullLocalPath
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
                # Create remote folder if not exists
                if (! (Test-SftpPath -SessionId $SFTPSession.SessionId -Path $remoteFolder)) {
                    New-SFTPItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -ItemType 'Directory' -Recurse | Out-Null
                }

                Set-SFTPItem -SessionId $SFTPSession.SessionId -Path $fullTempPath -Destination $remoteFolder -Force
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            # Remove folder only, if the file was copied prior
            if ($tempPath) {
                Write-Verbose ((Get-ResStr 'REMOVE_TEMPFILES') -f $tempPath, $myInvocation.Mycommand)
                Remove-Item -Path $tempPath -recurse -force -ErrorAction SilentlyContinue
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Send-SftpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'text.txt'
}
