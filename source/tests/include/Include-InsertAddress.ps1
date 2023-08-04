# Insert address for Pester tests

$match = 'JOHN'

$conn = Get-Conn -udl $udl
$sql =  "INSERT INTO Adresse ([Match], Name1, Strasse, Plz, Ort, Karteikarte, ZielId) " + `
        "VALUES ('$match', 'John Doe', 'Star Avenue 42', '12345', 'Fantasy Town', 'Some Info', (SELECT TOP 1 Id FROM KonZiel))"
$conn.Execute($sql)

$sql = "SELECT Id FROM Adresse WHERE Match = '$match'"
$rs = $conn.Execute($sql)
$addressId = 0
if (($rs) -and (!$rs.eof)) { $addressId = $rs.fields(0).value }
$rs.close()


$conn.close()