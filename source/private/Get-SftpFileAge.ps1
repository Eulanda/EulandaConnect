Function Get-SftpFileAge {
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
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileInfo' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'date' -Scope 'Private' -Value ([datetime]::MinValue)
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

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
                $fileInfo = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path "$($remoteFolder.TrimEnd('/'))" -File
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            foreach ($file in $fileInfo) {
                if ($file.FullName -eq "$($remoteFolder.TrimEnd('/'))/$remoteFile") {
                    $date = [datetime]::Now - $file.LastWriteTime
                    break
                }
            }
            $result = [int]$date.TotalSeconds


        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
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
            $result = Get-SftpFileAge -server $server -user $user -password $secure -remoteFile 'License.md'
            Write-Host "$result seconds from today"
        }

        # $result is a int32 value that indicates the file age until today
        # The file 'License.md' example belongs to the ftp server test environment we recommend.
    #>
}
