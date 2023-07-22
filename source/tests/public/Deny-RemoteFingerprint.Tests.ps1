Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Deny-RemoteFingerprint' -Tag 'integration', 'sftp' {

    $backupFilePath = $null

    BeforeAll {
        $pesterFolder = Resolve-Path -path ".\source\tests"
        $iniPath = Join-Path -path $pesterFolder "pester.ini"
        $ini = Read-IniFile -path $iniPath
        $server = $ini['SFTP']['Server']

        $originalFilePath = Join-Path -path $HOME ".poshssh\hosts.json"

        # Rename the file if it exists
        if (Test-Path -Path $originalFilePath) {
            # Find a backup file name that does not already exist
            $backupFileName = "hosts.json.bak"
            $backupCounter = 1
            while (Test-Path -Path (Join-Path -path $HOME ".poshssh\$backupFileName")) {
                $backupFileName = "hosts.json.bak$backupCounter"
                $backupCounter++
            }
            $backupFilePath = Join-Path -path $HOME ".poshssh\$backupFileName"

            Rename-Item -Path $originalFilePath -NewName $backupFilePath
        }
    }

    It "returns false when hosts.json file is missing" {

        # Call the function
        $result = Deny-RemoteFingerprint -server $server

        # Should return false as the file is missing
        $result | Should -BeFalse
    }

    It "returns true when the fingerprint does not match" {
        # Prepare the content with a mismatching fingerprint
        $jsonContent = @"
        {
            "Keys": {
                "$server": {
                    "HostKeyName": "ssh-ed25519",
                    "Fingerprint": "ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff"
                }
            }
        }
"@
        # Save to hosts.json
        Set-Content -Path $originalFilePath -Value $jsonContent

        # Call the function
        $result = Deny-RemoteFingerprint -server $server

        # Should return true as the fingerprint does not match
        $result | Should -BeTrue

        # Clean up, remove the file if it exists
        if (Test-Path -Path $originalFilePath) {
            Remove-Item -Path $originalFilePath
        }
    }

    AfterAll {
        # Clean up, remove the file if it exists
        if (Test-Path -Path $originalFilePath) {
            Remove-Item -Path $originalFilePath
        }
        # Rename the backup file back to original if it exists
        if ($backupFilePath -and (Test-Path -Path $backupFilePath)) {
            Rename-Item -Path $backupFilePath -NewName $originalFilePath
        }
    }
}
