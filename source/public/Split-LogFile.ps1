function Split-LogFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            $path = [System.IO.Path]::GetDirectoryName($_)
            if (Test-Path -Path $path) {
                $true
            }
            else {
                throw ((Get-ResStr 'LOGFILE_PATH_MISSED') -f $path, $myInvocation.Mycommand)
            }
        })]
        [string]$inputPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'inputPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if (Test-Path -Path $_) {
                $true
            }
            else {
                throw ((Get-ResStr 'PATHIN_DOES_NOT_EXIST') -f $_)
            }
        })]
        [string]$outputFolder = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'outputFolder', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if ($_ -notmatch '\{1\}') {
                throw (Get-ResStr 'VALIDATE_PARAM__ELEMENT_MISSED')
            }
            if ($_ -match '\{0\}') {
                $index0 = $_.IndexOf("{0}")
                $index1 = $_.IndexOf("{1}")
                if ($index0 -eq 0 -or $index0 -gt $index1) {
                    throw (Get-ResStr 'VALIDATE_PARAM_SEQUENCE')
                }
            }
            return $true
        })]
        [string]$outputMask = "filezilla-server.{0}-{1}.log"
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            $validDateMasks = 'yyyy', 'MM', 'dd', 'HH', 'mm', 'ss', 'ffff'
            $isValid = $true
            foreach ($mask in $validDateMasks) {
                if ($_ -notmatch $mask) {
                    $isValid = $false
                    break
                }
            }
            if ($isValid) {
                $true
            } else {
                throw ((Get-ResStr 'VALIDATE_PARAM_DATEMASK') -f $_)
            }
        })]
        [string]$dateMask = "yyyy-MM-dd-HH-mm-ss-ffff"
        ,
        [Parameter(Mandatory = $false)]
        [int]$maxFileSize = 2MB
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $inputFolder = Split-Path -Path $inputPath

        $files = Get-ChildItem -Path $inputPath
        $sortedFiles = $files | Sort-Object LastWriteTime -Descending
        $fileNames = $sortedFiles | ForEach-Object { $_.Name }

        $currentFileSize = 0
        $lines = New-Object System.Collections.Generic.List[System.Object]

        # Searches files that match the pattern and extracts the highest counter
        $splitPattern = $outputMask -split '\{[0-9]\}'  # filezilla-server.{0}-{1}.log
        $pre = $splitPattern[0]   # "filezilla-server."
        $post = $splitPattern[2]  # ".log"

        $fileCounter = (Get-ChildItem -Path $outputFolder -Filter "$pre*$post" |
                        ForEach-Object { if($_.BaseName -match "-(\d+)$") { [int]$matches[1] } } |
                        Sort-Object -Descending | Select-Object -First 1)


        # If nothing was found, it is started with 0
        if ($null -eq $fileCounter -or $fileCounter -eq '') {
            $fileCounter = 0
        }

        # Check if the last file size is less than the max size, if so, add contents to $lines and update $currentFileSize
        if ($fileCounter) {
            $latestSplitFile = Get-ChildItem -Path $outputFolder -Filter "$pre*$post" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
            if ($latestSplitFile.Length -lt $maxFileSize) {
                $fileContent = Get-Content -Path $latestSplitFile.FullName
                foreach ($line in $fileContent) {
                    $lineSize = ([System.Text.ASCIIEncoding]::ASCII.GetByteCount($line) + 2) # +2 für Zeilenumbruch
                    $lines.Add($line)
                    $currentFileSize += $lineSize
                }
                Remove-Item -Path $latestSplitFile.FullName -Force # Removes the file because it will be overwritten
                $fileCounter-- # Decrement the file counter because the file was deleted and its content will be used in the next process
            }
        }

        # Reads the file content line by line
        foreach ($inputFile in $fileNames) {
            Write-Verbose "Source log file: $inputFile"
            Get-Content (Join-Path -path $inputFolder -ChildPath $inputFile) | ForEach-Object {
                $line = $_
                $lineSize = ([System.Text.ASCIIEncoding]::ASCII.GetByteCount($line) + 2) # +2 für Zeilenumbruch

                # Writes the collected content to the file if the current file size exceeds the maxFileSize
                if ($currentFileSize + $lineSize -gt $maxFileSize) {
                    $fileCounter++
                    $dateString = Get-Date -Format $dateMask
                    $fileName = $outputMask -f $dateString, $fileCounter
                    $outputFile = Join-Path -Path $outputFolder -ChildPath $fileName
                    Write-Verbose ((Get-ResStr 'OUTPUT_SPLITFILE') -f $outputFile)
                    $currentFileSize = 0
                    $lines | Out-File -FilePath $outputFile
                    $lines.Clear()
                    Start-Sleep -Milliseconds 1 # Wait to be sure that the next time the file name changes
                }

                # Adds the current line to the collection
                $lines.Add($line)

                # Updates the current file size
                $currentFileSize += $lineSize
            }
        }
        # Writes the remaining lines to the file
        if ($lines.Count -gt 0) {
            $fileCounter++
            $dateString = Get-Date -Format $dateMask
            $fileName = $outputMask -f $dateString, $fileCounter
            $outputFile = Join-Path -Path $outputFolder -ChildPath $fileName
            Write-Verbose ((Get-ResStr 'OUTPUT_SPLITFILE') -f $outputFile)
            $currentFileSize = 0
            $lines | Out-File -FilePath $outputFile
            $lines.Clear()
            Start-Sleep -Milliseconds 1 # Wait to be sure that the next time the file name changes
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Split-LogFile -inputPath 'C:\FileZillaLog\Logs\filezilla-server.*.log' -outputFolder 'C:\FileZillaLog\SplitLogs'
}
