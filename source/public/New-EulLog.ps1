Class EulLog : System.IDisposable  {
    [string]$filePath
    [string]$name

    EulLog($name, $path) {
        $this.Name = $name
        $this.FilePath = $this.ChkPath($path)
        $this.Put('Initialization')
    }

    [void]Dispose() {
        $this.Put('Finalization')
    }

    [string]Fname($name) {
        $monthYear = Get-Date -Uformat "%Y-%b"
        return "LOG_$name`_$monthYear.txt"
    }

    [string]ChkPath($path) {
        $fName = $this.Fname($this.name)
        if (!(Get-Content "$path\events\$fName")) {
            [void](New-Item -Path "$path\events\$fName" -ItemType File -Force)
        }
        return "$path\events\$fName"
    }

    # main entry for logging an event
    [void]Put($level, $group, $message) {
        $now = (Get-Date).tostring("yyyy-MM-dd HH:mm:ss")
        if (! (test-path variable:global:ecProcessId)) {
            $global:ecProcessId = "$([System.Guid]::NewGuid())"
        }
        $delim = "`t"
        $log= "{1}{0}{2}{0}{3}{0}{4}{0}{5}{0}{6}" -f $delim, $now, ($this.name), $global:ecProcessId,  $level,  $group,  $message
        Write-Verbose $log
        [int]$maxRetries = 30
        [int]$i = 0
        while ($i -lt $maxRetries) {
            try {
                $log | Out-File -FilePath $this.filePath -Append -NoClobber
                $i = $maxRetries
            }
            catch {
                $i++
                Write-Verbose ((Get-ResStr 'LOGFILE_RETRY') -f $_, $log, $i, $maxRetries)
                Start-Sleep -Seconds 0.1
            }
        }
    }

    # short way to log an event
    [void]Put($level, $message) {
        $this.Put($level,'(default)',$message)
    }

    # shortest way to log an event
    [void]Put($message) {
        $this.Put(0,'(default)',$message)
    }
}

function New-EulLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$name = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'name', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )
    Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
    return [EulLog]::New($name, $path)
}
