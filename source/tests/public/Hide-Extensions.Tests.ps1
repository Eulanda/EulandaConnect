Import-Module -Name .\EulandaConnect.psd1

Describe 'Hide-Extensions' {

    $global:eul1RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $global:eul1RegistryProperty = "HideFileExt"
    $global:eul1OriginalValue = (Get-ItemProperty -Path $global:eul1RegistryPath).$global:eul1RegistryProperty

    It 'Hide-Extensions changes registry entry' {
        Hide-Extensions
        $newValue = (Get-ItemProperty -Path $global:eul1RegistryPath).$global:eul1RegistryProperty
        $newValue | Should -Be 1
    }

    AfterAll {
        # Restore the original value of the registry entry
        Set-ItemProperty -Path $global:eul1RegistryPath -Name $global:eul1RegistryProperty -Value $global:eul1OriginalValue
        Update-Desktop
        # Remove the global variables
        Remove-Variable -Name eul1RegistryPath -Scope Global
        Remove-Variable -Name eul1RegistryProperty -Scope Global
        Remove-Variable -Name eul1OriginalValue -Scope Global
    }
}
