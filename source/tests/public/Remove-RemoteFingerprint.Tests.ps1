Import-Module -Name .\EulandaConnect.psd1

Describe 'Remove-RemoteFingerprint' -Tag 'integration', 'ftp', 'sftp' {

    BeforeAll {
        $backupFilePath = $null
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

    It "removes the remote fingerprint if it exists" {
        # Create a dummy fingerprint
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
        Remove-RemoteFingerprint -server $server

        # Check if the file still exists
        (Test-Path -Path $originalFilePath) | Should -BeTrue

        # Check if the fingerprint was removed
        $content = Get-Content -Path $originalFilePath | ConvertFrom-Json
        $content.Keys.$server | Should -BeNull
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
