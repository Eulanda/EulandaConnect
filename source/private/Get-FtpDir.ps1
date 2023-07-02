Function Get-FtpDir {
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
        [ValidateSet("file", "directory")]
        [string]$dirType = "file"
        ,
        [Parameter(Mandatory = $false)]
        [string]$mask = "*"
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'directoryName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'fileName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'line' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'Matches' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'reader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tokens' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string[]]$result = @()

        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($remoteFolder)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails
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

        Try {
            $ftpResponse = $ftpRequest.GetResponse()
            Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)

            $reader = New-Object System.IO.StreamReader($ftpResponse.GetResponseStream())

            while (!$reader.EndOfStream) {
                $line = $reader.ReadLine()

                $tokens = $line.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

                if ($line -match '^d') {
                    if ($dirType -eq "directory") {
                        $directoryName = [string]::Join(" ", $tokens[8..($tokens.Length-1)])
                        $result += $directoryName
                    }
                } elseif ($line -match '^-') {
                    if ($dirType -eq "file") {
                        $fileName = [string]::Join(" ", $tokens[8..($tokens.Length-1)])
                        $result += $fileName
                    }
                }
            }

            $reader.Close()
            $ftpResponse.Close()


            if (($mask) -and ($mask -ne '*')) {
                $result = $result | Where-Object { $_ -like $mask }
            }

            $result = $result | Sort-Object
        } catch {
            Throw ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
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
            $result = Get-FtpDir -server $server -user $user -password $secure -remoteFolder '/' -dirType directory
            $result
        }

        # Output or what ever is there
        #  inbox
        #  outbox
    #>
}
