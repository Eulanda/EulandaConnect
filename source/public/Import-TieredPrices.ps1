function Import-TieredPrices {
    param(
        [string]$articleNoName
        ,
        [string]$tierName
        ,
        [int]$tierIdx
        ,
        [string]$tierListname
        ,
        [string]$path
        ,
        [string]$udl
    )

    $myConn = Get-Conn -udl $udl
    $rs = $myConn.execute("SELECT ID FROM Preisliste where [Name] = '$tierListname'")
    $Id = $rs.fields('ID').Value

    Import-Module ImportExcel
    $data = Import-Excel -Path $path

    foreach ($row in $data) {
        $artnummer = [string]$row.$($articleNoName)
        $vk = $row.$($tierName)

        try {
            if ($artNummer.IndexOf("'") -gt 0) {
                Write-Host "kjlKJ"
            }
            $artId = Get-ArticleId -articleNo $artnummer -conn $myConn
            if ($artId) {
                $rs = New-Object -comobject ADODB.Recordset
                $sql = "SELECT p.Id, p.Preisliste, p.Staffel, p.MengeAb, p.ArtikelId, p.Vk FROM Preis p " + `
                    "JOIN Artikel art ON art.Id = p.ArtikelId AND PreisListe = $id AND art.ID = $artId " + `
                    "AND Staffel = $tierIdx"
                $rs.Open($sql, $myConn, 3, 3)

                if (! $rs.eof) {
                    $rs.fields('Vk').value = [double]$vk
                    $rs.update()
                } else {
                    $rs.AddNew()
                    $rs.fields('Preisliste').value = $id
                    $rs.fields('Staffel').value = $tierIdx
                    $rs.fields('MengeAb').value = 1
                    $rs.fields('ArtikelId').value = $artId

                    $rs.fields('Vk').value = [double]$vk
                    $rs.update()
                }
                Write-Host $artnummer
            } else {
                Write-Host $artnummer -ForegroundColor Yellow
            }
        }
        catch {
            Write-Error $_
        }

    }

}

Import-TieredPrices -path 'C:\Users\cn\Desktop\test.xlsx' `
    -articleNoName 'ARTNUMMER' `
    -tierName 'VK' `
    -tierIdx 1 `
    -tierListName 'BBY Retail' `
    -udl 'C:\temp\Eulanda_1 ProcosUSA.udl'
