
    $shopFolder = 'Shop'

    $hardwareFolder = 'Hardware'
    $hardwarePath = "\$shopFolder\$hardwareFolder"
    $hardwareId = 0

    $softwareFolder = 'Software'
    $softwarePath = "\$shopFolder\$softwareFolder"
    $softwareId = 0

    $propertyId = 0

    $sql = @"
    DECLARE @rootId int
    DECLARE @shopId int
    DECLARE @hardwareId int
    DECLARE @softwareId int

    -- Get the root of the article property
    SELECT  @rootId = MIN(id) FROM Merkmal WHERE Tabelle = 'Artikel'

    -- insert folder 'Shop' to the root of article property
    INSERT INTO Merkmal
               (ParentID, MerkmalTyp, Tabelle, [Name])
         VALUES
               (@rootId, 0, 'Artikel', '$shopFolder' )

    -- get the id of the shop folder which is then the root of the following items
    SELECT  @shopId = MAX(id) FROM Merkmal WHERE Tabelle = 'Artikel'

    -- insert a hardware catalog (typ=1) under folder shop
    INSERT INTO Merkmal
               (ParentID, MerkmalTyp, Tabelle, [Name])
         VALUES
               (@shopId, 1, 'Artikel', '$hardwareFolder' )

    SELECT  @hardwareId = MAX(id) FROM Merkmal WHERE Tabelle = 'Artikel'

    -- insert a software catalog (typ=1) under folder shop
    INSERT INTO Merkmal
               (ParentID, MerkmalTyp, Tabelle, [Name])
         VALUES
               (@shopId, 1, 'Artikel', '$softwareFolder' )

    SELECT  @softwareId = MAX(id) FROM Merkmal WHERE Tabelle = 'Artikel'

    -- return all relevant values, also not used rootId and shopId
    SELECT @rootId [RootId], @shopId [ShopId], @hardwareId [HardwareId], @softwareId [SoftwareId]
"@

$conn = Get-Conn -udl $udl
$rs = $conn.Execute($sql)
$rs = Get-AdoRs -recordset $rs
if (($rs) -and (!$rs.eof)) {
      $hardwareId = $rs.Fields.Item('HardwareId').Value
      $softwareId = $rs.Fields.Item('SoftwareId').Value
      $propertyId = $hardwareId
}
$rs.close()

$conn.close()