function Get-TranslateSection {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$text = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'text', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [ValidateLength(2,2)]
        [string]$iso = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'iso', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$sub
        ,
        [Parameter(Mandatory = $false)]
        [string]$subDefault
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'arrLines' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'arrResult' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        New-Variable -Name 'delim' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'isoCurrent' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'isoTemp' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'line' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'subCurrent' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'subTemp' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $iso = $iso.ToUpper()
        $sub = $sub.ToUpper()
        $subDefault = $subDefault.ToUpper()

        [string]$isoTemp = ""
        [string]$subTemp = ""
        [string]$isoCurrent = ""
        [string]$subCurrent = ""

        [System.Collections.ArrayList]$arrResult = @()
        $arrLines = $text.Replace("`r`n", "`n").Split("`n")

        Foreach ($line in $arrLines) {
            if ((Get-TranslateIsDelim -value $line) -eq $true) {
                [string[]]$delim = Get-TranslateExtractTag -value $line
                [string]$isoTemp = $delim[0]
                [string]$subTemp = $delim[1]

                If (($isoCurrent -eq $iso) -and ($subCurrent -eq $sub)) {
                    break
                }

                if ((! $isoCurrent) -and ($isoTemp -eq $iso) -and ($subTemp -eq $sub)) {
                    [System.Collections.ArrayList]$arrResult = @()
                    $isoCurrent = $isoTemp
                    $subCurrent = $subTemp
                }
            } else {
                # Iso tag language separator found and sort by it
                if ((($isoCurrent -eq $iso) -and ($subCurrent -eq $sub)) -or
                    ((! $isoCurrent) -and (! $isoTemp) -and (!$sub)) -or
                    ((! $isoCurrent) -and ($isoTemp -eq "00") -and ($subTemp -eq $sub))) {
                       $arrResult.add($line) | Out-Null
                    }
            }
        }
        if (($arrResult.count -eq 0) -and ($sub) -and ($subDefault)) { $arrResult.Add($subDefault) | Out-Null }
        $result = $arrResult -join "`r`n"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-TranslateSection -text "This is my default text, It is used when no language is found`r`n[EN]`r`nThe moon always has the same face`r`n[DE]`r`nDer Mond hat immer das selbe Gesicht`r`n[IT]`r`nLa luna ha sempre la stessa faccia" -iso 'IT'
}
