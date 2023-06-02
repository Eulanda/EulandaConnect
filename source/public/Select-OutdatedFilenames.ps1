function Select-OutdatedFilenames {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string[]]$filenames = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'filenames', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$basename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'basename', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$extension = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'extension', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$history = 3
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'filteredFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'mask' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'Matches' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'outdatedFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'sortedFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Object[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($filenames) {
            if ($extension) {
                if ($extension[0] -ne ".") {
                    $extension = "." + $extension
                }
            }

            $mask = '^' + $basename + '-\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-\d{4}\' + $extension + '$'
            $filteredFiles = $filenames | Where-Object {
                $_ -match $mask
            }

            if ($filteredFiles) {
                if ($history) {
                    $sortedFiles =  [System.Array]($filteredFiles | Sort-Object -Property @{ Expression = {
                                try {
                                    [datetime]::ParseExact(($_.Name -match $dateRegex), "yyyy-MM-dd-HH-mm-ss-ffff", $null)
                                } catch {
                                    [datetime]::MinValue
                                }
                            }  }  )

                    $outdatedFiles = @()
                    if ($history -lt $sortedFiles.Count) {
                        foreach ($file in $sortedFiles[0..($sortedFiles.Count - ($history+1))]) {
                            $outdatedFiles = $outdatedFiles += $file
                        }
                    }
                    $result = $outdatedFiles
                } else {
                    $result = $filteredFiles
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Select-OutdatedFilenames -Filenames @('MyDatabase-2023-05-15-10-30-0001.zip', 'OtherFile.txt', 'MyDatabase-2023-05-15-11-45-0002.zip') -basename 'MyDatabase' -extension '.zip'
}
