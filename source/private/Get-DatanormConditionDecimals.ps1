function Get-DatanormConditionDecimals {
    [CmdletBinding()]
    param(
        [string]$condition,
        [int]$indicator
    )
    <#
        .SYNOPSIS
        Returns a Datanorm condition with decimal places based on the provided condition indicator.

        .DESCRIPTION
        In Datanorm files, there is a condition indicator in the type P record,
        which determines the number of decimal places of another field.
        This function returns the condition with the correct number of decimal
        places based on the indicator.

        .PARAMETER condition
        A string representing the Datanorm condition.

        .PARAMETER indicator
        An integer representing the Datanorm condition indicator.
        The number of decimal places is determined based on this indicator.

        .EXAMPLE
        PS C:\> Get-DatanormConditionDecimals -condition '10000' -indicator 1
        This command will return '100,00'.

        .EXAMPLE
        PS C:\> Get-DatanormConditionDecimals -condition '10000' -indicator 2
        This command will return '10,000'.

        .EXAMPLE
        PS C:\> Get-DatanormConditionDecimals -condition '10000' -indicator 3
        This command will return '100,00'.

        .NOTES
        The function throws an exception if an invalid condition indicator is passed.
    #>

    switch ($indicator) {
        0 { return $condition }
        1 { return $condition.Insert($condition.Length - 2, ",") }
        2 { return $condition.Insert($condition.Length - 3, ",") }
        3 { return $condition.Insert($condition.Length - 2, ",") }
        default { Throw ((Get-ResStr 'INVALID_DATANORM_INDICATOR') -f $indicator, $myInvocation.Mycommand) }
    }

    <# Test:
        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features { $result = Get-DatanormConditionDecimals -condition '1234' -indicator 3; $result }
        # Result should be '12,34'
        & $Features { $result = Get-DatanormConditionDecimals -condition '1234' -indicator 2; $result }
        # Result should be '1,234'
    #>
}
