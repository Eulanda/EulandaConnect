Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Show-Extensions' -Tag 'integration', 'registry' {

    $global:eul2RegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $global:eul2RegistryProperty = "HideFileExt"
    $global:eul2OriginalValue = (Get-ItemProperty -Path $global:eul2RegistryPath).$global:eul2RegistryProperty

    It 'Show-Extensions changes registry entry' {
        Show-Extensions
        $newValue = (Get-ItemProperty -Path $global:eul2RegistryPath).$global:eul2RegistryProperty
        $newValue | Should -Be 0
    }

    AfterAll {
        # Restore the original value of the registry entry
        Set-ItemProperty -Path $global:eul2RegistryPath -Name $global:eul2RegistryProperty -Value $global:eul2OriginalValue
        Update-Desktop
        # Remove the global variables
        Remove-Variable -Name eul2RegistryPath -Scope Global
        Remove-Variable -Name eul2RegistryProperty -Scope Global
        Remove-Variable -Name eul2OriginalValue -Scope Global
    }
}
