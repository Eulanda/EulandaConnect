function Get-DeliverySql {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        New-Variable -Name 'paramsDelivery' -Scope 'Private' -Value (@{})
        New-Variable -Name 'sqlDetail' -Scope 'Private' -Value ('')
        New-Variable -Name 'sqlMaster' -Scope 'Private' -Value ('')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $paramsDelivery = Get-UsedParameters -validParams (Get-SingleDeliveryKeys) -boundParams $PSBoundParameters

        [string]$sqlMaster = @"
        SELECT
            lf.KopfNummer [Id.Alias],

            dbo.cnf_LfDruckAnschrift(lf.Id) [Anschrift],
            lf.AdresseID,
            lf.AnzahlPakete,
            af.Datum [AuftragDatum],
            af.Id [AuftragId],
            af.KopfNummer [AuftragNummer],
            lf.BearbeitetDurch,
            af.BestellNummer,
            af.BestelltDurch,
            lf.Datum,
            lf.DruckName1,
            lf.DruckName2,
            lf.DruckName3,
            af.ShopLEMail [EMail],
            af.FibuKonto,
            lf.Gewicht,
            lf.GewichtSum,
            lf.ID,
            lf.ILN,
            lf.Info,
            dbo.cnf_LandNachISO(lf.Land) [Land],
            lf.LieferBed,
            lf.KopfNummer [LieferscheinNummer],
            lf.Name1,
            lf.Name2,
            lf.Name3,
            lf.NameLang,
            lf.Nachtext,
            lf.Objekt,
            lf.Ort,
            lf.OrtLang,
            lf.PLZ,
            lf.Provinz,
            lf.SpedAuftragNr,
            lf.Strasse,
            af.ShopLTel [Tel],
            lf.TrackingNr,
            lf.UstId,
            lf.UserD1,
            lf.UserD2,
            lf.UserI1,
            lf.UserI2,
            lf.UserI3,
            lf.UserN1,
            lf.UserN2,
            lf.UserN3,
            lf.UserVC1,
            lf.UserVC2,
            lf.UserVC3,
            lf.VersandartName,
            lf.Vortext,
            lf.Zahlungsart
        FROM PRINT_Lieferschein [lf]
        JOIN Adresse [adr] ON adr.Id = lf.AdresseId
        JOIN Auftrag [af] ON af.Id = lf.Af_Id
        WHERE $(Get-DeliveryLink @paramsDelivery)
"@

        [string]$sqlDetail =   @"
        SELECT
            lfp.PosNummer [ID.ALIAS], -- special case, because it is sorted later by index 1

            art.ArtMatch,
            art.ArtNummer,
            art.Barcode,
            lfp.ErweitertePos,
            lfp.Gewicht,
            lfp.GewichtGes,
            lfp.ID,
            lfp.Info,
            CAST(((lfp.Menge + lfp.VerpackEH -1 ) / lfp.VerpackEH) AS int) [Kartons],
            (lfp.Menge / lfp.VerpackEH) [KartonsBerechnet],
            lfp.Kurztext1,
            lfp.Kurztext2,
            lfp.Langtext [Langtext],
            lfp.Menge,
            lfp.MengenEh,
            lfp.PosNummer,
            art.RabattGr,
            lfp.Ultrakurztext,
            lfp.uid,
            art.UrsprungsLand,
            lfp.UserD1,
            lfp.UserD2,
            lfp.UserI1,
            lfp.UserI2,
            lfp.UserI3,
            lfp.UserN1,
            lfp.UserN2,
            lfp.UserN3,
            lfp.UserVC1,
            lfp.UserVC2,
            lfp.UserVC3,
            lfp.VerpackEh,
            art.WarenGr,
            art.WarenNr
        FROM Master_LieferscheinPos [lfp]
        JOIN Lieferschein [lf] ON lf.Id = lfp.KopfId
        JOIN Artikel [art] ON art.Id = lfp.ArtikelId
        WHERE $(Get-DeliveryLink @paramsDelivery -alias 'lf')
"@
        $result =  [string[]]@($sqlMaster,$sqlDetail)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliverySql -deliveryId 28096 -debug
}
