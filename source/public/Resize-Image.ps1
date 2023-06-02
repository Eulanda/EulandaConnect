function Resize-Image {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Position = 0, Mandatory = $false)]
        [ValidateScript({
            if (Test-Path $_) { $true } else { throw ((Get-ResStr 'PATH_NOT_EXISTS') -f $_) }
        })]
        [string]$pathIn = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'pathIn', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [string]$pathOut
        ,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$modifier = "-resized"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(10, 100)]
        [int]$quality = 65
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(32, 5000)]
        [int]$maxWidth = 1200
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(32, 5000)]
        [int]$maxHeight = 1200
        ,
        [Parameter(Mandatory = $false)]
        [switch]$passthru
    )
    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'directoryIn' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'directoryOut' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'extensionIn' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'extensionOut' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'filenameIn' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'filenameOut' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'img' -Scope 'Private' -Value ($null)
        New-Variable -Name 'imgNew' -Scope 'Private' -Value ($null)
        New-Variable -Name 'imgProcess' -Scope 'Private' -Value ($null)
        New-Variable -Name 'module' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'pathOutOrg' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'results' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'useDefaultOutputPath' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'wiaFormatJpg' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference

        try {
            $useDefaultOutputPath = $pathOut -eq ''
            $pathOutOrg = $pathOut
            [string]$module= "WIA.ImageFile"
            $img = New-Object -COMObject $module
            $imgNew = New-Object -COMObject $module
            [string]$module= "WIA.ImageProcess"
            $imgProcess = New-Object -COMObject $module
            $wiaFormatJpg = "{B96B3CAE-0728-11D3-9D7B-0000F81EF32E}"
            $results = @()
        }
        catch {
            throw ((Get-ResStr 'WIA_NOT_INSTALLED') -f $module)
        }
    }

    Process {
        if ($useDefaultOutputPath) {
            $directoryIn = Split-Path $pathIn
            $filenameIn = [System.IO.Path]::GetFileNameWithoutExtension($pathIn)
            $extensionIn = [System.IO.Path]::GetExtension($pathIn)
            $pathOut = Join-Path $directoryIn ("$($filenameIn)$($modifier)$($extensionIn)")
        } else {
            $pathOut = $pathOutOrg
            $directoryOut = Split-Path $pathOut
            $filenameOut = [System.IO.Path]::GetFileNameWithoutExtension($pathOut)
            $extensionOut = [System.IO.Path]::GetExtension($pathOut)

            $directoryIn = Split-Path $pathIn
            $filenameIn = [System.IO.Path]::GetFileNameWithoutExtension($pathIn)
            $extensionIn = [System.IO.Path]::GetExtension($pathIn)

            write-verbose (Get-ResStr 'WIA_OUTPUT')
            write-verbose ((Get-ResStr 'WIA_DIR_OUT') -f $directoryOut)
            write-verbose ((Get-ResStr 'WIA_FILE_OUT') -f $filenameOut)
            write-verbose ((Get-ResStr 'WIA_EXT_OUT') -f $extensionOut)

            write-verbose (Get-ResStr 'WIA_INPUT')
            write-verbose ((Get-ResStr 'WIA_DIR_IN') -f $directoryIn)
            write-verbose ((Get-ResStr 'WIA_FILE_IN') -f $filenameIn)
            write-verbose ((Get-ResStr 'WIA_EXT_IN') -f $extensionIn)

            if ($directoryOut -eq $directoryIn) {
                if ($filenameOut -eq $filenameIn) {
                    $filenameOut = $filenameIn + "$modifier"
                }
            } elseif (($filenameOut -eq $filenameIn) -and ($extensionOut -eq $extensionIn)) {
                $filenameOut = $filenameIn + "$modifier"
            } elseif (! $extensionOut) {
                $filenameOut = $filenameIn
                $extensionOut = $extensionIn
                $directoryOut = $pathOut
            }

            $pathOut = Join-Path $directoryOut ($filenameOut + $extensionOut)
        }

        write-verbose (Get-ResStr 'WIA_USED')
        write-verbose ((Get-ResStr 'WIA_PATH_IN') -f $pathIn)
        write-verbose ((Get-ResStr 'WIA_PATH_OUT') -f $pathOut)

        $img.LoadFile($pathIn)

        $imgProcess.Filters.Add($imgProcess.FilterInfos("Scale").FilterID)
        $imgProcess.Filters(1).Properties("MaximumWidth") = $maxWidth
        $imgProcess.Filters(1).Properties("MaximumHeight") = $maxHeight

        $imgProcess.Filters.Add($imgProcess.FilterInfos("Convert").FilterID)
        $imgProcess.Filters(2).Properties("FormatID").Value = $wiaFormatJpg
        $imgProcess.Filters(2).Properties("Quality").Value =  [string]$quality

        $imgNew = $imgProcess.Apply($img)
        If (Test-Path $pathOut) { Remove-Item -path $pathOut -force }
        $imgNew.SaveFile($pathOut)
        $imgProcess.Filters.Remove(2) # Remove the filter backwards
        $imgProcess.Filters.Remove(1)

        $result = [PSCustomObject]@{
            PathOut = $pathOut
        }

        $results += $result

        if ($passthru) {
            # Return $result
        }
    }

    End {
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$imgProcess)
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$img)
        [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$imgNew)
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        if ($passthru) {
            Return $results
        }
    }
    # Test: Resize-Image -pathIn c:\temp\eulanda.jpg -pathOut c:\temp\eulanda-neu.jpg -maxWidth 50
}
