function Get-FtpNextFilename {
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
        [parameter(Mandatory = $false)]
        [string]$mask = '*'
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'date' -Scope 'Private' -Value ($null)
        New-Variable -Name 'dateRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'dateResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileInfo' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'lastColonIndex' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'line' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'list' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'nextSpaceIndex' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'oldestFile' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileSlash' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'reader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            $remoteFolder = $($remoteFolder.TrimEnd('/'))
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {$remoteFolder = '/'}

        if ($remoteFolder -eq '/') {
            $fileSlash = ''
        } else {
            $fileSlash = '/'
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

        try {
            $ftpResponse = $ftpRequest.GetResponse()
            $reader = New-Object IO.StreamReader $ftpResponse.GetResponseStream()
            $list = @()
            while(-not $reader.EndOfStream){
                $line = $reader.ReadLine()
                # Each line looks like: '-rw-rw-rw- 1 ftp ftp        51153987 May 11 16:11 Eulanda_JohnDoe - Copy (2).zip'
                $lastColonIndex = $line.LastIndexOf(':')
                $nextSpaceIndex = $line.IndexOf(' ', $lastColonIndex)
                if ($nextSpaceIndex -gt $lastColonIndex) {
                    $fileName = $line.Substring($nextSpaceIndex + 1)
                }

                # Get LastWriteDate for each file
                $dateRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($remoteFolder)$($fileSlash)$($fileName)")
                $dateRequest.Credentials = $ftpRequest.Credentials
                $dateRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetDateTimestamp
                $dateResponse = $dateRequest.GetResponse()
                $date = $dateResponse.LastModified

                $fileInfo = New-Object PSObject -Property @{
                    Name = $fileName
                    LastWriteTime = $date
                }
                $list += ,$fileInfo
            }

            $reader.Close()
            Write-Verbose "$($myInvocation.Mycommand) status: $($ftpResponse.StatusDescription.Trim())"
            $ftpResponse.Close()

            # Filter the list
            $list = $list | Where-Object { $_.Name -like $mask }

            # Sort the list to get oldest
            if ($list) {
                if ($list.Count -gt 0) {
                    $oldestFile = $list | Sort-Object LastWriteTime | Select-Object -First 1
                    $result = $oldestFile.Name
                }
            }

        } catch {
            Throw ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-FtpNextFilename -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -mask '*.xml' -remoteFolder '/EULANDA'
}
