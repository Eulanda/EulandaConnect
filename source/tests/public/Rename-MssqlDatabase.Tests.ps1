Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Rename-MssqlDatabase' -Tag 'integration', 'sql', 'sqladmin' {

    BeforeAll {
        $oldName = 'Eulanda_Pester'
        $newName = 'Eulanda_PesterNew'
        $udl = Resolve-Path '.\source\tests\Eulanda_1 Pester.udl'

        $connItems = Get-ConnItems -udl $udl
        $server = $connItems."Data Source"
        $password = ""
        $user = ""
        if ($connItems.ContainsKey("Password")) {
            $password = $connItems."Password"
        }
        if ($connItems.ContainsKey("User ID")) {
            $user = $connItems."User ID"
        }

        # Build params for Rename-MssqlDatabase
        $connParams = @{
            'server' = $server
        }
        if (($user) -and ($password)) {
            $connParams.Add('user', $user)
            $connParams.Add('password', $password)
        }

        # Build connection string for master database
        $udlContent = Get-Content -Path $udl


        $filteredContent = $udlContent | Where-Object {
            $_ -match '^.+=.+$'
        }

        $masterConnItems = @{}
        $filteredContent -split ';' | ForEach-Object {
            $keyValue = $_ -split '='
            if ($keyValue.Count -eq 2) {
                $key = $keyValue[0].Trim()
                $value = $keyValue[1].Trim()
                if ($key -ne '') {
                    $masterConnItems[$key] = $value
                }
            }
        }

        $masterConnItems.'Initial Catalog' = 'master'

        $masterConnStr = ($masterConnItems.GetEnumerator() | ForEach-Object {
            "$($_.Key)=$($_.Value)"
        }) -join ';'


        # This is only required if this test is called manually as a single test from the console prompt
        $conn = Get-Conn -udl $udl
        $sql = "SELECT IS_SRVROLEMEMBER('sysadmin')"
        $result = $conn.Execute($sql)
        if ($result.Fields.Item(0).Value -ne 1) {
            $skipThis = $true
        } else {
            $skipThis = $false
        }
        $conn.close()
    }

    It 'Rename database without oldname should throw' {
        { Rename-MssqlDatabase -newName $newName @connParams } | Should -Throw
    }

    It 'Rename database without newname should throw' {
        { Rename-MssqlDatabase -oldName $oldName @connParams } | Should -Throw
    }

    It 'Rename database without parameter should throw' {
        { Rename-MssqlDatabase } | Should -Throw
    }

    It 'Rename database with all parameters should not throw' {
        if ($skipThis) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        { Rename-MssqlDatabase -oldName $oldName -newName $newName @connParams } | Should -Not -Throw

        $conn = Get-Conn -connStr $masterConnStr
        $sql = "SELECT name FROM sys.databases WHERE name = '$newName'"
        $rs = $conn.Execute($sql)
        $result = $rs.EOF
        if ($result) {
            $rs.close()
        }
        $conn.close()
        $result | Should -BeFalse

    }

    AfterAll {
        if (! $skipThis) {
            $conn = Get-Conn -connStr $masterConnStr
            $sql = "SELECT name FROM sys.databases WHERE name = '$newName'"
            $rs = $conn.Execute($sql)
            if (! $rs.EOF) {
                $rs.close()
                $conn.close()
                Rename-MssqlDatabase -oldName $newName -newName $oldName @connParams
            } else {
                $conn.close()
            }
        }
    }
}
