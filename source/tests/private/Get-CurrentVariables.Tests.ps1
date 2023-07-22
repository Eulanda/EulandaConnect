Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-CurrentVariables' {
    InModuleScope EulandaConnect {

        It 'should return no new variables' {
            # Arrange
            $outputPath = Join-Path -Path $env:TEMP 'output.txt'

            # Act
            $initialVariables = Get-CurrentVariables -Debug:$true
            Get-CurrentVariables -InitialVariables $initialVariables -Debug:$true | Out-File -FilePath $outputPath

            # Assert
            $outputContent = Get-Content -Path $outputPath -Raw
            $outputContent | Should -Not -Match 'New variables'

            # Cleanup
            Remove-Item $outputPath -ErrorAction SilentlyContinue
        }

        It 'should return new variables' {
            # Arrange
            $outputPath = Join-Path -Path $env:TEMP 'output.txt'

            # Act
            $initialVariables = Get-CurrentVariables -Debug:$true
            $dummy = 'test1' # Create a new dummy variable
            if ($dummy) { $dummy = 'test2'}
            Get-CurrentVariables -InitialVariables $initialVariables -Debug:$true | Out-File -FilePath $outputPath

            # Assert
            $outputContent = Get-Content -Path $outputPath -Raw
            $newVariables = $outputContent.Split("`r`n")
            $newVariables.Count | Should -BeGreaterThan 0
            $outputContent | Should -Match 'New variables'

            # Cleanup
            Remove-Item $outputPath -ErrorAction SilentlyContinue
        }
    }
}
