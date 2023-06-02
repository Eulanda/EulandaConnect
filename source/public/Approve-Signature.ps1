function Approve-Signature {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'filename' -Scope 'Private' -Value ''
        New-Variable -Name 'extension' -Scope 'Private' -Value ''
        New-Variable -Name 'folder' -Scope 'Private' -Value ''
        New-Variable -Name 'signFile' -Scope 'Private' -Value ''
        New-Variable -Name 'arguments' -Scope 'Private' -Value ('')
        New-Variable -Name 'exitCode' -Scope 'Private' -Value (0)
        New-Variable -Name 'outputContent' -Scope 'Private' -Value ('')
        New-Variable -Name 'process' -Scope 'Private' -Value $null
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $filename = [IO.Path]::GetFileNameWithoutExtension($path)
        $extension = [IO.Path]::GetExtension($path)
        $folder = [IO.Path]::GetDirectoryName($path)


        if ((! $folder) -or ($folder -eq '.')) {
            $folder= Get-Location
        }

        # If no path take the last folder
        if (! ($filename)) {
            if (! ($folder -in '.', '.\', '')) {
                $filename = Split-Path $folder -Leaf
            }
        }

        # if no extension take ps1, then psm1 then exe
        if (! ($extension)) {
            $extension= '.ps1'
            if (-not (Test-Path "$folder\$($filename)$($extension)" )) {
                $extension= '.psm1'
                if (-not (Test-Path "$folder\$($filename)$($extension)" )) {
                    $extension= '.exe'
                    if (-not (Test-Path "$folder\$($filename)$($extension)" )) {
                        # Change back to .ps1 so that Resolve-Path can render
                        # an exeption with the default extension
                        $extension= '.ps1'
                    }
                }
            }
        }

        # Test to see if undefined vars are in the exception
        # [string]$Tester = '42'

        [string]$signFile= Resolve-Path "$folder\$($filename)$($extension)"
        [string]$arguments = "sign /tr http://timestamp.sectigo.com?td=sha256 /td sha256 /fd sha256 /a ""$signFile"""
        Write-Host ((Get-ResStr 'SIGNING_FILE') -f $signFile) -ForegroundColor Blue

        $process = New-Object System.Diagnostics.Process
        $process.StartInfo.FileName = (Get-SignToolPath)
        $process.StartInfo.Arguments = $arguments
        $process.StartInfo.RedirectStandardOutput = $true
        $process.StartInfo.RedirectStandardError = $true
        $process.StartInfo.UseShellExecute = $false
        $process.StartInfo.CreateNoWindow = $true

        $process.Start() | Out-Null
        $outputContent = $process.StandardOutput.ReadToEnd() + $process.StandardError.ReadToEnd()
        $process.WaitForExit()
        $exitCode = $process.ExitCode
        $process.Dispose()

        if ($exitCode -ne 0 -and $outputContent -notmatch 'Successfully signed') {
            Write-Host -ForegroundColor Red ((Get-ResStr 'SIGNING_FAILED') -f $exitCode)
            Write-Host -ForegroundColor Red $outputContent
            throw ((Get-ResStr 'SIGNING_EXCEPTION') -f $exitCode)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Approve-Signature .\EulandaConnect.psm1
}
