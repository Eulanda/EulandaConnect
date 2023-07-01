function New-FtpFolder {
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
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'folder' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'folders' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $folders = $remoteFolder -split '/'
        $path = ""
        foreach ($folder in $folders) {
            if ($folder) {
                $path = $path + '/' + $folder
                if (-not(Test-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $path  )) {
                    $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$path")
                    $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
                    $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
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
                    $ftpResponse = $ftpRequest.GetResponse()
                    Write-Verbose "$($myInvocation.Mycommand) status: $($ftpResponse.StatusDescription.Trim())"
                    $ftpResponse.Close()
                }
            }
        }
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

            $folderName = -join ((65..90) | Get-Random -Count 10 | % {[char]$_})
            New-FtpFolder -server $server -user $user -password $secure -remoteFolder "/$folderName"
            $result = Get-FtpDir -server $server -user $user -password $secure -dirType directory
            Write-Host "'$result' are all folders on ftp including the new '$folderName' one which was created for pester tests"
        }

    #>
}
