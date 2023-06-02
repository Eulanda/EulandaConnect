Function Convert-StringCase {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'culture' -Scope 'Private' -Value ($null)
        New-Variable -Name 'words' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'wordsCapitalized' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $value
        switch ( $strCase.ToLower() ) {
            'none' { $result = $result }
            'upper' { $result = $result.ToUpper() }
            'lower' { $result = $result.ToLower() }
            'capital' {
                $culture = [System.Globalization.CultureInfo]::CurrentCulture
                $words = $result.Split(' ')
                $wordsCapitalized = $words | ForEach-Object { $culture.TextInfo.ToTitleCase($_) }
                $result = $wordsCapitalized -join ' '
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-StringCase -value 'Der Caffè ist übergut in Österreich!' -strCase capital
}
