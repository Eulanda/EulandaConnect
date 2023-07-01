Import-Module -Name .\EulandaConnect.psd1

Describe 'Convert-ToMultipart' {

    BeforeAll {
        # Create a simple image for testing
        $testImagePath = Join-Path -Path $env:TEMP -ChildPath 'PesterTest.png'
        $bitmap = New-Object System.Drawing.Bitmap 100, 100
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $brush = [System.Drawing.Brushes]::Black
        $graphics.FillRectangle($brush, 0, 0, 100, 100)
        $bitmap.Save($testImagePath, [System.Drawing.Imaging.ImageFormat]::Png)
    }

    InModuleScope 'EulandaConnect' {

        It 'should contain the boundary' {
            # Arrange
            $formParams = @{
                chat_id                        = '454563'
                caption                        = 'MyTestCaption'
                parse_mode                     = 'markdown'
                disable_content_type_detection = $false
                disable_notification           = $false
            }
            $uri = Join-Path -Path $env:TEMP -ChildPath 'PesterTest.png'
            $fileObject = Get-Item $uri -ErrorAction Stop
            $formParams.Add('photo', $fileObject)
            $boundary = [System.Guid]::NewGuid().ToString()

            # Act
            $actualOutput = Convert-ToMultipart -params $formParams -boundary $boundary

            # Assert
            $actualOutput | Should -Match $boundary
        }

        It 'should correctly format chat_id' {
            # Arrange
            $formParams = @{
                chat_id                        = '454563'
                caption                        = 'MyTestCaption'
                parse_mode                     = 'markdown'
                disable_content_type_detection = $false
                disable_notification           = $false
            }
            $uri = Join-Path -Path $env:TEMP -ChildPath 'PesterTest.png'
            $fileObject = Get-Item $uri -ErrorAction Stop
            $formParams.Add('photo', $fileObject)
            $boundary = [System.Guid]::NewGuid().ToString()

            # Act
            $actualOutput = Convert-ToMultipart -params $formParams -boundary $boundary

            # Assert
            $actualOutput | Should -Match "Content-Disposition: form-data; name=`"chat_id`"`r`n`r`n454563"
        }

        It 'should correctly format caption' {
            # Arrange
            $formParams = @{
                chat_id                        = '454563'
                caption                        = 'MyTestCaption'
                parse_mode                     = 'markdown'
                disable_content_type_detection = $false
                disable_notification           = $false
            }
            $uri = Join-Path -Path $env:TEMP -ChildPath 'PesterTest.png'
            $fileObject = Get-Item $uri -ErrorAction Stop
            $formParams.Add('photo', $fileObject)
            $boundary = [System.Guid]::NewGuid().ToString()

            # Act
            $actualOutput = Convert-ToMultipart -params $formParams -boundary $boundary

            # Assert
            $actualOutput | Should -Match "Content-Disposition: form-data; name=`"caption`"`r`n`r`nMyTestCaption"
        }

        It 'should correctly format photo' {
            # Arrange
            $formParams = @{
                chat_id                        = '454563'
                caption                        = 'MyTestCaption'
                parse_mode                     = 'markdown'
                disable_content_type_detection = $false
                disable_notification           = $false
            }
            $uri = Join-Path -Path $env:TEMP -ChildPath 'PesterTest.png'
            $fileObject = Get-Item $uri -ErrorAction Stop
            $formParams.Add('photo', $fileObject)
            $boundary = [System.Guid]::NewGuid().ToString()

            # Act
            $actualOutput = Convert-ToMultipart -params $formParams -boundary $boundary

            # Assert
            $actualOutput | Should -Match "Content-Disposition: form-data; name=`"photo`"; filename=`"PesterTest.png`""
        }
    }

    AfterAll {
        # Cleanup the test image after running the test
        $testImagePath = Join-Path -Path $env:TEMP -ChildPath 'PesterTest.png'
        Remove-Item $testImagePath -ErrorAction SilentlyContinue
    }
}
