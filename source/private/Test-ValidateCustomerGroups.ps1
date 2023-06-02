function Test-ValidateCustomerGroups {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
        [AllowEmptyString()]
        [string]$customerGroups
    )
    begin {
        $regexPattern = '^[\w\s-]*((,[\w\s-]+)+)?$'
    }
    process {
        if (-not [string]::IsNullOrEmpty($customerGroups)) {
            if ($customerGroups -notmatch $regexPattern) {
                throw ((Get-ResStr 'CUSTOMERGROPUP_NOT_VALID') -f $customerGroup, $myInvocation.Mycommand)
            }
        }
    }
    end {
        $true
    }
}
