Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Convert-DataToXml' {
    Context 'Simple Hashtable input' {
        It 'converts a hashtable to XML' {
            $input = @{
                "Name" = "John"
                "Age" = 25
            }
            $output = Convert-DataToXml -data $input
            $output.Root.Name | Should -Be "John"
            $output.Root.Age | Should -Be 25
        }
    }

    Context 'Nested Hashtable input' {
        It 'converts nested hashtables to XML' {
            $input = @{
                "Person" = @{
                    "Name" = "John"
                    "Age" = 25
                }
            }
            $output = Convert-DataToXml -data $input
            $output.Root.Person.Name | Should -Be "John"
            $output.Root.Person.Age | Should -Be 25
        }
    }

    Context 'Array input' {
        It 'converts an array to XML' {
            $input = @(
                @{
                    "Name" = "John"
                    "Age" = 25
                },
                @{
                    "Name" = "Jane"
                    "Age" = 30
                }
            )
            $output = Convert-DataToXml -data $input
            $output.Root.Records.Record[0].Name | Should -Be "John"
            $output.Root.Records.Record[0].Age | Should -Be 25
            $output.Root.Records.Record[1].Name | Should -Be "Jane"
            $output.Root.Records.Record[1].Age | Should -Be 30
        }
    }
}
