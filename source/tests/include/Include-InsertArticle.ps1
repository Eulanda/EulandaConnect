# Insert article for Pester tests

$articleNo = '0815'
$barcode = '2012345789012'
$packingUnit = 6
$text = 'Some less info'

$conn = Get-Conn -udl $udl
$sql = "INSERT INTO Artikel (ArtNummer, Barcode, Vk, VerpackEH, Kurztext1, Ultrakurztext, Langtext) VALUES ('$articleNo', '$barcode', 42.99, $packingUnit, '$text', '$text', '$text')"
$conn.Execute($sql)

$articleNo = '4711'
$barcode = '2012345789019'
$packingUnit = 12
$text = 'Some info'

$conn = Get-Conn -udl $udl
$sql = "INSERT INTO Artikel (ArtNummer, Barcode, Vk, VerpackEH, Kurztext1, Ultrakurztext, Langtext) VALUES ('$articleNo', '$barcode', 42.50, $packingUnit, '$text', '$text', '$text')"
$conn.Execute($sql)


$conn.close()