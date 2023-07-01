function Convert-ToUTF7 {
    Param(
        [Parameter(Mandatory = $false)]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        <#
            # Used prior 2023-07-01
            $bytes = [System.Text.Encoding]::UTF8.GetBytes($value)
            [string]$result = [System.Text.Encoding]::UTF7.GetString($bytes)
        #>
        # New implementaion tested with Send-TelegramPhoto and special chars also with pester tests and seems to work in both
        $utf8 = [System.Text.Encoding]::UTF8
        $utf7 = [System.Text.Encoding]::UTF7
        $bytes = $utf8.GetBytes($value)
        $utf7Bytes = [System.Text.Encoding]::Convert($utf8, $utf7, $bytes)
        [string]$result = $utf7.GetString($utf7Bytes)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Convert-ToUTF7
}
