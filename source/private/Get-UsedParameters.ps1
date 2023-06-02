function Get-UsedParameters {
    param (
        [Parameter(Mandatory = $false)]
        [string[]]$validParams = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'validParams', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [System.Collections.Hashtable]$boundParams = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'boundParams', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'keyLower' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'validParamsLower' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
      # Convert the valid parameters to lowercase letters
      $validParamsLower = $validParams | ForEach-Object { $_.ToLower() }

      foreach ($key in $boundParams.Keys) {
          # Convert the current key to lowercase letters
          $keyLower = $key.ToLower()

          # Check if the lowercase key is included in the valid parameters
          if ($validParamsLower -contains $keyLower) {
              # Add the element with the original key to the result
              $result[$key] = $boundParams[$key]
          }
      }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $result
    }

}
