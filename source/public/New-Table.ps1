function New-Table {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$tableName = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tableName', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$columnNames = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'columnNames', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'count' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($columnNames.GetType().Name -eq "String") {
            [string[]]$columnNames = $columnNames.split(',')
        } elseif ($columnNames.GetType().BaseType.Name -ne "Array") {
            throw ((Get-ResStr 'COLUMNNAMES_STRING_ONLY') -f $myInvocation.Mycommand)
        }

        $tempTable = New-Object System.Data.DataTable

        if ($columnNames.count -ne 0) {
            do {
                Remove-Variable -Name datatype -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                $tempTable.Columns.Add() | Out-Null
                if ($columnNames[$count] -like "*/?*") {
                    $datatype = $columnNames[$count].Substring($columnNames[$count].IndexOf("/?")+2)
                    if ($datatype -eq 'int') {$datatype = 'Int32'}
                    if ($datatype -eq 'long') {$datatype = 'Int64'}
                    $columnNames[$count] = $columnNames[$count].Substring(0,$columnNames[$count].IndexOf("/?"))
                    $tempTable.Columns[$count].DataType = "System.$datatype"
                }
                $tempTable.Columns[$count].ColumnName = $columnNames[$count]
                $tempTable.Columns[$count].Caption = $columnNames[$count]
                $count++
            } until ($count -eq $columnNames.Count)
        }
        Set-Variable -Name $tableName -Scope Global -Value (New-Object System.Data.DataTable)
        Set-Variable -Name $tableName -Scope Global -Value $tempTable
        Remove-Variable -Name TempTable -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  New-Table -tableName 'MyTable' -columnNames 'Name,Value/?Int'
}
