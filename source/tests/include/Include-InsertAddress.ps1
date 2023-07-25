# Insert address for Pester tests

$match = 'JOHN'

$conn = Get-Conn -udl $udl
$sql =  "INSERT INTO Adresse ([Match], Name1, Strasse, Plz, Ort, Karteikarte) " + `
        "VALUES ('$match', 'John Doe', 'Star Avenue 42', '12345', 'Fantasy Town', 'Some Info')"
$conn.Execute($sql)
$conn.close()