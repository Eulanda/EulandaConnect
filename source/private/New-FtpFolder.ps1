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
     # Test:  New-FtpFolder -server 'myftp.eulanda.eu'  -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -verbose -debug
}
