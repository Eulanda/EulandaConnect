function Read-VersionFromSynopsis {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ) {
                throw ((Get-ResStr 'FILE_OR_FOLDER_DOES_NOT_EXIST') -f $_)
             } else {
                 $true
            }
        })]
        [ValidateScript({
            if($_ -notmatch "(\.ps1)") {
                throw ((Get-ResStr 'MUST_BE_PS1FILE') -f $_)
            } else {
                 $true
            }
        })]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(2, [int]::MaxValue)]
        [int]$maxLines = 250
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'arrSynopsis' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'content' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'endIndex' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'line' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'startIndex' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'synopsis' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [version]$result = "0.0"
        try {
            $content = Get-Content -Path $path -TotalCount $maxLines | Out-String
            $startIndex = $content.IndexOf(".NOTES")
            $endIndex = $content.IndexOf("#>") + 2
            if ($endIndex -gt $startIndex) {
                $synopsis = $content.Substring($startIndex, $endIndex - $startIndex)
                $arrSynopsis = $synopsis.Split("`n")
                foreach ($line in $arrSynopsis) {
                    if ($line.ToLower().Contains('version:')) {
                        [version]$result = $line.Substring($line.IndexOf(":") + 1).Trim()
                        break
                    }
                }
            }
        } catch { }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Read-VersionFromSynopsis -path '.\Debug.ps1'
}
