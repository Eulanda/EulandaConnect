function Get-ResStr {
    [CmdletBinding()]
    param (
        [string]$Key
    )

    begin {
        # Here we could not write STARTING_FUNCTION because of a recursion
        New-Variable -Name 'data' -Scope 'Private' -Value ($null)
        New-Variable -Name 'path' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'reslang' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'values' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlContent' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlFile' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlFiles' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($ecResx.count -eq 0) {
            Write-Verbose "Get-ResX Init"
            [string]$path = (Get-Module -Name EulandaConnect | Select-Object -ExpandProperty Path)
            [string]$path = Split-path $path

            $xmlFiles = Get-ChildItem "$path\*.resx"
            foreach ($xmlFile in $xmlFiles) {
                $reslang = $xmlFile.Name.Split('.')[1]

                $xmlContent = Get-Content $xmlFile -Raw
                $xml = [xml]$xmlContent

                foreach ($data in $xml.root.data) {
                    if ($ecResx[$data.name]) {
                        $ecResx[$data.name][$reslang]= $data.value
                    } else {
                        $values = @{}
                        $values[$reslang] = $data.value
                        $ecResx[$data.name] = $values
                    }
                }
            }
        }

        if ($ecResx.ContainsKey($key)) {
            if ($ecResx[$key].ContainsKey($ecCulture)) {
                $result = $ecResx[$Key][$ecCulture]
            } elseif ($ecResx[$key].ContainsKey('en-US')) {
                $result = $ecResx[$Key]['en-US']
            } else {
                $result = "?[$ecCulture`:$key]"
            }
        } else {
            $result = "?[$key]"
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ResStr -key 'OUT_WELCOME_COPYRIGHT'
}
