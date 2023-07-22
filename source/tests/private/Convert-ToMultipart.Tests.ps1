Import-Module -Name .\EulandaConnect.psd1

Describe 'Convert-ToMultipart' {
    InModuleScope EulandaConnect {

        BeforeAll {
            # Create a simple image
            $imageFile = 'PesterTest.png'
            $testImagePath = Join-Path -Path $env:TEMP -ChildPath  $imageFile
            $bitmap = New-Object System.Drawing.Bitmap 100, 100
            $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
            $brush = [System.Drawing.Brushes]::Black
            $graphics.FillRectangle($brush, 0, 0, 100, 100)
            $bitmap.Save($testImagePath, [System.Drawing.Imaging.ImageFormat]::Png)

            # Arrange
            $formParams = @{
                chat_id                        = '454563'
                caption                        = 'MyTestCaption'
                parse_mode                     = 'markdown'
                disable_content_type_detection = $false
                disable_notification           = $false
            }
            $uri = Join-Path -Path $env:TEMP -ChildPath  $imageFile

            $fileObject = Get-Item $uri -ErrorAction Stop
            $formParams.Add('photo', $fileObject)
            $boundary = [System.Guid]::NewGuid().ToString()
        }

        It 'should contain the boundary' {
            $actualOutput = Convert-ToMultipart -params $formParams -boundary $boundary
            $actualOutput | Should -Match $boundary
        }

        It 'should correctly format chat_id' {
            $actualOutput = Convert-ToMultipart -params $formParams -boundary $boundary
            $actualOutput | Should -Match "Content-Disposition: form-data; name=`"chat_id`"`r`n`r`n454563"
        }

        It 'should correctly format caption' {
            $actualOutput = Convert-ToMultipart -params $formParams -boundary $boundary
            $actualOutput | Should -Match "Content-Disposition: form-data; name=`"caption`"`r`n`r`nMyTestCaption"
        }

        It 'should correctly format photo' {
            $actualOutput = Convert-ToMultipart -params $formParams -boundary $boundary
            $actualOutput | Should -Match "Content-Disposition: form-data; name=`"photo`"; filename=`"PesterTest.png`""
        }

        AfterAll {
            $testImagePath = Join-Path -Path $env:TEMP -ChildPath  $imageFile
            Remove-Item $testImagePath -ErrorAction SilentlyContinue
        }
    }
}
