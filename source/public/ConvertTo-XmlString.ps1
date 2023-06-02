function ConvertTo-XmlString {
    [CmdletBinding()]
    param (
        [System.__ComObject]$adoField
        ,
        [switch]$includeEmpty
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'adoType' -Scope 'Private' -Value ([int64]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [long]$adoType = $adoField.Type
        [object]$result = $adoField.Value

        switch ($adoType) {
            {$_ -in @($adChar, $adVarChar, $adLongVarChar, $adWChar, $adVarWChar, $adLongVarWChar, $adBSTR)} {

                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    [string]$result = [string]''
                } else {
                    [string]$result = [string]$result.trim()
                }
            }
            {$_ -in @($adSmallInt, $adInteger, $adTinyInt)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'0'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            {$_ -in @($adBigInt, $adUnsignedBigInt)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'0'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            {$_ -in @($adSingle, $adDouble)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'0.0'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            {$_ -in @($adCurrency, $adDecimal, $adNumeric)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'0.0'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            {$_ -in @($adDate, $adDBDate, $adDBTimeStamp)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                     } else {
                        [string]$result = [string](Convert-DateToIso -value ([datetime]::MinValue))
                     }
                } else {
                    [string]$result =  [string](Convert-DateToIso -value $result)
                }
            }
            {$_ -in @($adBoolean)} {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    if ($includeEmpty) {
                        [string]$result = [string]''
                    } else {
                        [string]$result = [string]'False'
                    }
                } else {
                    [string]$result = [string]$result
                }
            }
            default {
                if ($result -eq [System.DBNull]::Value -or $null -eq $result) {
                    [string]$result = [string]''
                } else {
                    [string]$result = [string]$result
                }
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    <# Test:
        $rs = New-Object -ComObject ADODB.Recordset
        $rs.Fields.Append("MyDateField", $adDBTimeStamp)
        $rs.Open()
        $rs.AddNew()
        $rs.Fields("MyDateField").Value = Get-Date
        $adoField = $rs.Fields("MyDateField")

        ConvertTo-XmlString -adoField $adoField -debug

        $rs.Close()
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($rs) | Out-Null
    #>
}
