
function Get-LoremIpsum {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [int]$minParagraphs = 1
        ,
        [Parameter(Mandatory = $false)]
        [int]$maxParagraphs = 5
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'numParagraphs' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'paragraph' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paragraphs' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $numParagraphs = Get-Random -Minimum $minParagraphs -Maximum $maxParagraphs

        $paragraphs = @()
        for ($i = 1; $i -le $numParagraphs; $i++) {
            $paragraph = "$(Get-RandomParagraph)"
            if (! $paragraphs) {
                $paragraphs = $paragraph
            } else { $paragraphs += "`r`n$paragraph" }

        }
        $result = $paragraphs.TrimEnd()
    }

    end {
        Get-CurrentVariables -initialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-LoremIpsum -minParagraphs 2
}
