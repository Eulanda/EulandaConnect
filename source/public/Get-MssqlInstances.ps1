function Get-MssqlInstances {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [switch]$show
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'backupPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'tempFilesObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tcpIp' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'sqlService' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sqlServerRule' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'sqlBrowserRule' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'sharedMemory' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'regKeyCombi' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'regKey' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'pipeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'patchLevel' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'namedPipes' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'mdfFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'mdfFilePath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'tempObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'mdfFileInfo' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ldfFileInfo' -Scope 'Private' -Value ($null)
        New-Variable -Name 'binnPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'browserService' -Scope 'Private' -Value ($null)
        New-Variable -Name 'collation' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'combi' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'databaseLastModified' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'databaseName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'mdfFile' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'version' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'dataPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'filesResult' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        New-Variable -Name 'firewallChecked' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'instance' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'item' -Scope 'Private' -Value ($null)
        New-Variable -Name 'databaseSize' -Scope 'Private' -Value ([double]0.0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $regKey = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL"
        $result = New-Object System.Collections.ArrayList

        try {
            foreach ($instance in (Get-Item -Path $regKey | Select-Object -ExpandProperty Property)) {
                $regKey = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$instance\MSSQLServer\CurrentVersion"
                $version = (Get-ItemProperty -Path $regKey).CurrentVersion
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL"
                $combi = (Get-ItemProperty -Path $regKeyCombi).$instance
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\MSSQLServer"
                $backupPath = (Get-ItemProperty -Path $regKeyCombi).BackupDirectory
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\Setup"
                $binnPath = (Get-ItemProperty -Path $regKeyCombi).SQLBinRoot
                $collation = (Get-ItemProperty -Path $regKeyCombi).Collation
                $patchLevel = (Get-ItemProperty -Path $regKeyCombi).PatchLevel
                $dataPath = "$((Get-ItemProperty -Path $regKeyCombi).SQLDataRoot)\DATA"
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\MSSQLServer\SuperSocketNetLib\Tcp"
                $tcpIp = (Get-ItemProperty -Path $regKeyCombi).Enabled
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\MSSQLServer\SuperSocketNetLib\Sm"
                $sharedMemory = (Get-ItemProperty -Path $regKeyCombi).Enabled
                $regKeyCombi = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$combi\MSSQLServer\SuperSocketNetLib\Np"
                $namedPipes = (Get-ItemProperty -Path $regKeyCombi).Enabled
                $pipeName = (Get-ItemProperty -Path $regKeyCombi).PipeName

                $sqlService = Get-Service -Name "MSSQL`$${instance}" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Status
                $browserService = Get-Service -Name "SQLBrowser" -ErrorAction SilentlyContinue  | Select-Object -ExpandProperty Status

                [bool]$firewallChecked = $false
                [bool]$sqlBrowserRule= $false
                [bool]$sqlServerRule= $false

                try {
                    $firewallBrowser= Get-NetFirewallPortFilter -ErrorAction Stop | Where-Object LocalPort -eq 1434 | Get-NetFirewallRule -ErrorAction Stop | Where-Object Enabled -eq True | Where-Object Direction -eq Inbound
                    if ($firewallBrowser) {
                        [bool]$sqlBrowserRule= $true
                    }
                    # No Exception, so it was checked
                    [bool]$firewallChecked = $true
                }

                catch [Microsoft.Management.Infrastructure.CimException]  {
                }

                try {
                    $firewallSqlServer = Get-NetFirewallApplicationFilter -ErrorAction Stop | Where-Object Program -match "$($binnPath.Replace('\','\\'))\\sqlservr.exe" | Get-NetFirewallRule -ErrorAction Stop
                    if ($firewallSqlServer) {
                        [bool]$sqlServerRule= $true
                    }
                    # No Exception, so it was checked
                    [bool]$firewallChecked = $true
                }

                catch [Microsoft.Management.Infrastructure.CimException]  {
                }

                $mdfFiles = Get-ChildItem -Path "$dataPath\*.mdf" -Name | Sort-Object
                $filesResult = New-Object System.Collections.ArrayList
                foreach ($mdfFile in $mdfFiles) {
                    $databaseName = [System.IO.Path]::GetFileNameWithoutExtension($mdfFile)
                    $ldfFile = Get-ChildItem -Path "$dataPath\$databaseName*.ldf" -Name | Select-Object -First 1
                    if ($ldfFile) {
                        $mdfFilePath = [System.IO.Path]::Combine($dataPath, $mdfFile)
                        $mdfFileInfo = New-Object System.IO.FileInfo ([System.IO.Path]::Combine($dataPath, $mdfFile))
                        $ldfFileInfo = New-Object System.IO.FileInfo ([System.IO.Path]::Combine($dataPath, $ldfFile))
                        $databaseSize = [math]::Round(($mdfFileInfo.Length + $ldfFileInfo.Length) / 1MB, 2)
                        $databaseLastModified = [System.IO.File]::GetLastWriteTime($mdfFilePath).ToString("yyyy-MM-dd HH:mm:ss")
                        $tempFilesObj = [PSCustomObject]@{
                            MdfFile = [string]$mdfFile
                            LdfFile = [string]$ldfFile
                            MdfSize = [double]$mdfFileInfo.Length / 1MB
                            LdfSize = [double]$ldfFileInfo.Length / 1MB
                            TotalSize = [double]$databaseSize
                            LastModified = [string]$databaseLastModified
                        }
                        $filesResult.Add($tempFilesObj) | Out-Null
                    }
                }
                $tempObj = [PSCustomObject]@{
                    Instance = [string]$instance
                    Version = [version]$version
                    PatchLevel = [version]$patchLevel
                    Collation = [string]$collation
                    BinnPath = [string]$binnPath
                    DataPath = [string]$dataPath
                    BackupPath = [string]$BackupPath
                    SqlService = [string]$sqlService
                    BrowserService = [string]$browserService
                    TcpIp = [boolean]$tcpIp
                    SharedMemory = [boolean]$sharedMemory
                    NamedPipes = [boolean]$namedPipes
                    PipeName = [string]$pipeName
                    FirewallChecked = [bool]$firewallChecked
                    SqlBrowserRule = [bool]$sqlBrowserRule
                    SqlServerRule = [bool]$sqlServerRule
                    Files = [PSCustomObject]$filesResult
                }

                $result.Add($tempObj) | Out-Null
            }

            if ($show) {
                foreach ($item in $result) {
                    Write-Host ((Get-ResStr 'SERVER_SETTINGS_FOR') -f  $($item.Instance)) -ForegroundColor Yellow
                    $item  | Select-Object -Property Instance, Version, PatchLevel, Collation, BinnPath, DataPath, BackupPath, SqlService, BrowserService, NamedPipes, TcpIp, SharedMemory, FirewallChecked, SqlBrowserRule, SqlServerRule | Format-List | Out-Host
                    Write-Host ((Get-ResStr 'DATABASE_FILES_FOR') -f  $($item.Instance)) -ForegroundColor Blue
                    Write-Host (Get-ResStr 'SIZES_IN_MB') -ForegroundColor Blue
                    $item.Files | Format-List | Out-Host
                }
                If (! (Test-Administrator)) {
                    Write-Host (Get-ResStr 'FIREWALL_NOT_CHECKED') -ForegroundColor Red
                  }
            }

        }

        catch {
            if ($show) {
                Write-Host "$_" -ForegroundColor Red
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-MssqlInstances -show
}
