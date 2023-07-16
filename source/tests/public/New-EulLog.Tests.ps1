Import-Module -Name .\EulandaConnect.psd1

Describe 'New-EulLog' {
    BeforeAll {
        $global:TestPath = "Path\To\Test"
        $global:TestName = "TestLog"
    }

    It 'New-EulLog creates EulLog' {
        $eulLog = New-EulLog -name $global:TestName -path $global:TestPath
        $eulLog | Should -Not -BeNullOrEmpty
        $eulLog.filePath | Should -Be "$global:TestPath\events\LOG_$global:TestName`_$(Get-Date -Uformat '%Y-%b').txt"
        $eulLog.name | Should -Be $global:TestName
    }

    It 'EulLog.Put logs message' {
        $eulLog = New-EulLog -name $global:TestName -path $global:TestPath
        $message = 'Test message'
        $eulLog.Put($message)
        $logContent = Get-Content -Path $eulLog.filePath
        $logContent.Where({ $_ -like "*$message*" }) | Should -Not -BeNullOrEmpty
    }

    # Cleanup after tests
    AfterAll {
        Remove-Item -Path "$global:TestPath\events\LOG_$global:TestName`_*.txt" -Force -ErrorAction SilentlyContinue
        Remove-Variable -Name TestName -Scope Global -ErrorAction SilentlyContinue
    }
}
