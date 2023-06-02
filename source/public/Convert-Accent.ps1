function Convert-Accent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'hash' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'item' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = $value
        # case sensitive
        $hash = New-Object hashtable
        $hash['ä']='ae'
        $hash['ö']='oe'
        $hash['ü']='ue'
        $hash['Ä']='Ae'
        $hash['Ö']='Oe'
        $hash['Ü']='Ue'
        $hash['ß']='ss'
        $hash['œ']='oe'
        $hash['â']='a'
        $hash['à']='a'
        $hash['á']='a'
        $hash['ç']='c'
        $hash['ê']='e'
        $hash['è']='e'
        $hash['é']='e'
        $hash['ë']='e'
        $hash['î']='i'
        $hash['ì']='i'
        $hash['í']='i'
        $hash['ï']='i'
        $hash['ô']='o'
        $hash['ò']='o'
        $hash['ó']='o'
        $hash['û']='u'
        $hash['ù']='u'
        $hash['ú']='u'
        $hash['Â']='A'
        $hash['À']='A'
        $hash['Á']='A'
        $hash['Ê']='E'
        $hash['È']='E'
        $hash['É']='E'
        $hash['Î']='I'
        $hash['Ì']='I'
        $hash['Í']='I'
        $hash['Ô']='O'
        $hash['Ò']='O'
        $hash['Ó']='O'
        $hash['Û']='U'
        $hash['Ù']='U'
        $hash['Ú']='U'

        foreach ($item in $hash.GetEnumerator()) {
            $result = $result -creplace  "$($item.key)", "$($item.value)"
        }
        $result = Convert-StringCase -value $result -strCase $strCase
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Convert-Accent -value 'Der Caffè ist übergut in Österreich!' -strCase 'Upper'
}
