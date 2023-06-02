Function Test-ValidateSingle {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [string[]]$validParams = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'validParams', $myInvocation.Mycommand))
        ,
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$remainingArguments
    )

    begin {
        $count = 0
        # $RemainingArguments contains all parameters of the calling function.
        # In $RemainingArguments each entry with even index is a parameter name and each odd is
        # the parameter value. Each parameter name is stored as with a leading hyphen and a
        # closing colon, such as '-udl:'. Before comparison the characters are removed.
        if ($null -ne $remainingArguments -and $remainingArguments.GetType().IsArray) {
            for ($i = 0; $i -lt $remainingArguments.Count; $i += 2) {
                $paramName = $remainingArguments[$i].Substring(1, $remainingArguments[$i].Length - 2)
                $paramValue = $remainingArguments[$i+1]
                if (-not [string]::IsNullOrEmpty($paramValue)) {
                    if ($validParams -contains $paramName) {
                        $count++
                    }
                }
            }
        }
    }

    process {
        if ($count -ne 1) {
            $validParamsList = $ValidParams -join ', '
            $parentFunctionName = ""
            $callStack = Get-PSCallStack
            for ($i = 1; $i -lt $callStack.Count; $i++) {
                $fn = $callStack[$i].FunctionName
                if ($fn -ne $MyInvocation.MyCommand.Name) {
                    $parentFunctionName = $fn
                    break
                }
            }
            $parentFunctionName = $parentFunctionName.Replace("<Begin>", "").TrimEnd()
            $message = ((Get-ResStr 'PARAMS_EXACTLY_ONE') -f $validParamsList, $parentFunctionName)
            throw $message
        }
    }
}
