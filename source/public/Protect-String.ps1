function Protect-String {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$plainText = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'plainText', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        $key = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'key', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'char' -Scope 'Private' -Value ($null)
        New-Variable -Name 'chars' -Scope 'Private' -Value ($null)
        New-Variable -Name 'securestring' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $key = Get-ProtectedKey $key
        $securestring = New-Object System.Security.SecureString
        $chars = $plainText.toCharArray()
        foreach ($char in $chars) {
            $secureString.AppendChar($char)
        }
        $result = ConvertFrom-SecureString -SecureString $secureString -Key $key
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Protect-String -plainText 'Hallo, i am John, John Doe!' -key 'MySpecialKey'
}
