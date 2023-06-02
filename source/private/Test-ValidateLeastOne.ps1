Function Test-ValidateLeastOne {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $false)]
        [string[]]$validParams = @()
        ,
        [Parameter(ValueFromRemainingArguments = $false)]
        [string[]]$remainingArguments = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'remainingArguments', $myInvocation.Mycommand))
    )

    begin {
        $count = 0

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
        $parentFunction = Get-Command -Name $parentFunctionName -All | Where-Object { $_.CommandType -eq 'Function' } | Select-Object -First 1
        $commonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters
        $parentParameters = $parentFunction.Parameters.Keys | Where-Object { $_ -ne 'RemainingArguments' -and $commonParameters -notcontains $_ }

        if ($null -eq $remainingArguments -or $remainingArguments.Count -eq 0) {
            $remainingArguments = @()
            foreach ($param in $parentParameters) {
                $remainingArguments += "-$param"
                $remainingArguments += $null
            }
        }

        if ($validParams.Count -eq 0) {
            $validParams = $parentParameters
        }

        for ($i = 0; $i -lt $remainingArguments.Count; $i += 2) {
            $paramName = $remainingArguments[$i].Substring(1).TrimEnd(':')
            $paramValue = $remainingArguments[$i+1]
            if (-not [string]::IsNullOrEmpty($paramValue)) {
                if ($validParams -contains $paramName) {
                    $count++
                }
            }
        }
    }

    process {
        if ($count -lt 1) {
            $validParamsList = $ValidParams -join ', '
            $message = ((Get-ResStr 'PARAMS_AT_LEAST_ONE') -f $validParamsList, $parentFunctionName)
            throw $message
        }
    }
}
