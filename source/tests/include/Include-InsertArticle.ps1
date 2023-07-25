# Insert article for Pester tests

$articleNo = '4711'
$barcode = '1234567890123'
$packingUnit = 12

$conn = Get-Conn -udl $udl
$sql = "INSERT INTO Artikel (ArtNummer, Barcode, Vk, VerpackEH, Kurztext1) VALUES ($articleNo, $barcode, 42.50, $packingUnit, 'Some Info')"
$conn.Execute($sql)
$conn.close()