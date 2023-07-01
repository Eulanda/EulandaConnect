Import-Module -Name .\EulandaConnect.psd1

Describe "Get-FtpFileAge" -Tag 'Integration' {
    InModuleScope 'EulandaConnect' {
        BeforeAll {
            $pesterFolder = Resolve-Path -path ".\source\tests"
            $iniPath = Join-Path -path $pesterFolder "pester.ini"
            $ini = Read-IniFile -path $iniPath
            $path = $ini['SFTP']['SecurePasswordPath']
            $path = $path -replace '\$home', $HOME
            $secure = Import-Clixml -path $path
            $server = $ini['SFTP']['Server']
            $user = $ini['SFTP']['User']
        }

        It "Gets the age of the file 'License.md' in seconds and checks if it's within an acceptable range" {
            $result = Get-FtpFileAge -server $server -user $user -password $secure -remoteFile 'License.md'
            Write-Host "Alter: $result"

            # Calculate the acceptable range
            $now = Get-Date
            $earliest = [DateTime]::new(2023, 1, 1)
            $latest = $now.AddMinutes(-10)

            $earliestSeconds = ($now - $earliest).TotalSeconds
            $latestSeconds = ($now - $latest).TotalSeconds

            # Check if the age of the file is greater than 10 minutes and less than the difference in seconds since 01.01.2023
            $result | Should -BeLessOrEqual $earliestSeconds
            $result | Should -BeGreaterOrEqual $latestSeconds
        }
    }
}
