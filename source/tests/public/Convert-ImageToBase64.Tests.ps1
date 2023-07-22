Import-Module -Name .\EulandaConnect.psd1

Describe 'Convert-ImageToBase64' {

    BeforeAll {
        $imageFile = 'PesterTest.png'
        $testImagePath = Join-Path -Path $env:TEMP -ChildPath $imageFile
        $bitmap = New-Object System.Drawing.Bitmap 100, 100
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $brush = [System.Drawing.Brushes]::Black
        $graphics.FillRectangle($brush, 0, 0, 100, 100)
        $bitmap.Save($testImagePath, [System.Drawing.Imaging.ImageFormat]::Png)
    }

    It "Converts bitmap to base64 correctly" {
        $result = Convert-ImageToBase64 -path $testImagePath
        $result | Should -Match "^data:image/png;base64,"
    }

    AfterAll {
        Remove-Item -Path $testImagePath
    }
}
