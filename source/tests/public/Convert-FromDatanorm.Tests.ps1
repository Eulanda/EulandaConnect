Import-Module -Name .\EulandaConnect.psd1

Describe "Convert-FromDatanorm" {
    It "should convert the Datanorm file to objects" {
        # Arrange

        $data = @(
            "V 120623J.W.Zander GmbH & Co.KG                 E-Business                              Hr.Gitzinger Tel.: 0761-5140219    04EUR",
            "A;A;8241335;00;ELTROPA Verdrahtungsbrcke 1ph 265mm sw;EVB 10/265 A2 10qmm Stift isol;1;0;Stk;257;EM01;01;;",
            "B;A;8241335;EVB 10/265 A2;456 01 31;;1;150;250;4003899170225;;010204;0;1;;;",
            "A;A;070175002;00;Elektro-Innenoberteil MS 3/8"" kompl.;mit Haubengriff Markierung rot;1;0;Stk;3230;AJAB;81;;",
            "B;A;070175002;obt10trt;453654;;0;;;4042707205537;;810699;0;10;;;",
            "A;A;070175003;00;Elektro-Innenoberteil MS 3/8"" kompl.;mit Haubengriff Markierung neutral;1;0;Stk;3290;AJAB;81;;",
            "B;A;070175003;obt10tne;453655;;0;;;4042707205568;;810699;0;10;;;",
            "A;A;4830297;00;ELTAKO Strombegrenzer 1200VA REG 0,02kA;SBR12-230V/240æF 16A;1;0;Stk;4950;ETK6;04;;",
            "B;A;4830297;SBR12-230V/240æ;22100430;;0;0;0;4010312205457;;041102;0;1;;;",
            "P;A;8241334;2;44;;;;;;;8241335;1;257;;;;;;;8241335;2;53;;;;;;;",
            "P;A;070175002;1;3230;;;;;;;070175002;2;1938;;;;;;;070175003;1;3290;;;;;;;",
            "P;A;070175003;2;1974;;;;;;;070508001;1;0;0; ;;;;;070508001;2;0;0; ;;;;;",
            ""
        )
        $randomName = [System.IO.Path]::GetRandomFileName()
        $randomName = $randomName -replace '\.',''

        $tempFolder = Join-Path -Path $env:TEMP -ChildPath $randomName
        New-Item -ItemType Directory -Path $tempFolder | Out-Null
        $tempFile = Join-Path -Path $tempFolder -ChildPath "DATANORM.001"
        $data | Out-File -FilePath $tempFile -Encoding ASCII

        # Act
        $result = Convert-FromDatanorm -Path $tempFile

        # Assert
        $result | Should -BeOfType [System.Management.Automation.PSCustomObject]

        # Assert the specific object
        $specificObject = $result.$datanorm.a["8241335"]
        $specificObject | Should -Not -BeNull
        $specificObject.ArtikelNummer | Should -Be "8241335"

        Remove-Item -Path $tempFolder -Force -Recurse
    }

    It "should handle empty files gracefully" {
        # Arrange
        $randomName = [System.IO.Path]::GetRandomFileName()
        $randomName = $randomName -replace '\.',''

        $tempFolder = Join-Path -Path $env:TEMP -ChildPath $randomName
        New-Item -ItemType Directory -Path $tempFolder | Out-Null
        $tempFile = Join-Path -Path $tempFolder -ChildPath "DATANORM.001"
        $data = ""
        $data | Out-File -FilePath $tempFile -Encoding ASCII

        # Act
        $result = Convert-FromDatanorm -Path $tempFile

        # Assert
        $result | Should -BeNullOrEmpty

        Remove-Item -Path $tempFolder -Force -Recurse
    }
}
