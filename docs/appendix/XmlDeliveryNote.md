# XML Delivery Note

The delivery note is an XML document that is normally sent to a shipping company. The field descriptions are natively in German. There is an alphabetical [field description](./appendix/Fields.md) in the glossary.

```xml
<EULANDA>
    <METADATA>
        <VERSION>2.5.2</VERSION>
        <GENERATOR>EulandaConnect</GENERATOR>
        <DATEFORMAT>ISO8601</DATEFORMAT>
        <FLOATFORMAT>US</FLOATFORMAT>
        <COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
        <FIELDNAMES>NATIVE</FIELDNAMES>
        <DATE>2023-05-02T20:00:46</DATE>
        <PCNAME>STUDIO</PCNAME>
        <USERNAME>DAVE</USERNAME>
    </METADATA>
    <LIEFERSCHEINLISTE>
        <LIEFERSCHEIN>
            <ID.ALIAS>430147</ID.ALIAS>
            <ANSCHRIFT>Doe Limited
John Doe
44 Baker Street
W1B 3AD London </ANSCHRIFT>
            <ADRESSEID>65</ADRESSEID>
            <ANZAHLPAKETE>0</ANZAHLPAKETE>
            <AUFTRAGNUMMER>4711</AUFTRAGNUMMER>
            <AUFTRAGDATUM>2023-04-24T08:54:29.0+00:00</AUFTRAGDATUM>
            <AUFTRAGID>1131</AUFTRAGID>
            <BEARBEITETDURCH>Cane</BEARBEITETDURCH>
            <BESTELLNUMMER>PO 855</BESTELLNUMMER>
            <BESTELLTDURCH>John Doe</BESTELLTDURCH>
            <DATUM>2023-04-24T08:56:03.0+00:00</DATUM>
            <DRUCKNAME1></DRUCKNAME1>
            <DRUCKNAME2>Doe Limited</DRUCKNAME2>
            <DRUCKNAME3>John Doe</DRUCKNAME3>
            <EMAIL />
            <FIBUKONTO>10001</FIBUKONTO>
            <GEWICHT>0.0000</GEWICHT>
            <GEWICHTSUM>301.6000</GEWICHTSUM>
            <ID>1211</ID>
            <ILN />
            <INFO />
            <LAND>GB</LAND>
            <LIEFERBED />
            <LIEFERSCHEINNUMMER>0815</LIEFERSCHEINNUMMER>
            <NAME1>Doe Limited</NAME1>
            <NAME2 /></NAME2>
            <NAME3>John Doe</NAME3>
            <NAMELANG>Doe Limited John Doe</NAMELANG>
            <NACHTEXT />
            <OBJEKT>PO</OBJEKT>
            <ORT>London </ORT>
            <ORTLANG>GB-W1B 3AD London </ORTLANG>
            <PLZ>W1B 3AD</PLZ>
            <PROVINZ />
            <SPEDAUFTRAGNR />
            <STRASSE>44 Baker Street</STRASSE>
            <TEL />
            <TRACKINGNR />
            <USTID />
            <USERD1 />
            <USERD2 />
            <USERI1 />
            <USERI2 />
            <USERI3 />
            <USERN1 />
            <USERN2 />
            <USERN3 />
            <USERVC1 />
            <USERVC2 />
            <USERVC3 />
            <VERSANDARTNAME>DHL Courier</VERSANDARTNAME>
            <VORTEXT />
            <ZAHLUNGSART>MISC</ZAHLUNGSART>
            <LIEFERSCHEINPOSLISTE>
                <LIEFERSCHEINPOS>
                    <ID.ALIAS>1</ID.ALIAS>
                    <ARTMATCH>123456 COTTON BAG "S"</ARTMATCH>
                    <ARTNUMMER>COTTON BAG "S"</ARTNUMMER>
                    <BARCODE>1234567890123</BARCODE>
                    <ERWEITERTEPOS />
                    <GEWICHT>0.5800</GEWICHT>
                    <GEWICHTGES>150.8000</GEWICHTGES>
                    <ID>4031</ID>
                    <INFO>CAVE</INFO>
                    <KARTONS>10</KARTONS>
                    <KARTONSBERECHNET>9.99</KARTONSBERECHNET>
                    <KURZTEXT1>Mikes Cotton Bag "S"</KURZTEXT1>
                    <KURZTEXT2>107 x 61 x 9 cm</KURZTEXT2>
                    <LANGTEXT>Mikes Cotton BAG S
Buddy internal art no: 123456
107 x 61 x 9 cm
1 ctn = 26 pcs</LANGTEXT>
                    <MENGE>260.0000</MENGE>
                    <MENGENEH>piece(s)</MENGENEH>
                    <POSNUMMER>1</POSNUMMER>
                    <RABATTGR />
                    <ULTRAKURZTEXT>Cotton Bag "S"</ULTRAKURZTEXT>
                    <UID>80FD866A-18EB-4991-B868-52811D17F885</UID>
                    <URSPRUNGSLAND>IN</URSPRUNGSLAND>
                    <USERD1 />
                    <USERD2 />
                    <USERI1 />
                    <USERI2 />
                    <USERI3 />
                    <USERN1 />
                    <USERN2 />
                    <USERN3 />
                    <USERVC1 />
                    <USERVC2 />
                    <USERVC3 />
                    <VERPACKEH>26.00</VERPACKEH>
                    <WARENGR>TESSUTO</WARENGR>
                    <WARENNR>4202929890</WARENNR>
                </LIEFERSCHEINPOS>
                <LIEFERSCHEINPOS>
                    <ID.ALIAS>2</ID.ALIAS>
                    <ARTMATCH>123457 COTTON BAG "L"</ARTMATCH>
                    <ARTNUMMER>COTTON BAG "L"</ARTNUMMER>
                    <BARCODE>1234567890124</BARCODE>
                    <ERWEITERTEPOS />
                    <GEWICHT>0.5800</GEWICHT>
                    <GEWICHTGES>150.8000</GEWICHTGES>
                    <ID>4032</ID>
                    <INFO>CAVE</INFO>
                    <KARTONS>10</KARTONS>
                    <KARTONSBERECHNET>10.00000000000000</KARTONSBERECHNET>
                    <KURZTEXT1>Cotton Bag "L"</KURZTEXT1>
                    <KURZTEXT2>155 x 61 x 9.5 cm</KURZTEXT2>
                    <LANGTEXT>COTTON BAG L
Buddy internal art no: 123457
155 x 61 x 9.5 cm
1 ctn = 26 pcs</LANGTEXT>
                    <MENGE>260.0000</MENGE>
                    <MENGENEH>piece(s)</MENGENEH>
                    <POSNUMMER>2</POSNUMMER>
                    <RABATTGR />
                    <ULTRAKURZTEXT>Cotton Bag "L" </ULTRAKURZTEXT>
                    <UID>39D54B75-1EE6-4208-B82C-7B449DB988AB</UID>
                    <URSPRUNGSLAND>IN</URSPRUNGSLAND>
                    <USERD1 />
                    <USERD2 />
                    <USERI1 />
                    <USERI2 />
                    <USERI3 />
                    <USERN1 />
                    <USERN2 />
                    <USERN3 />
                    <USERVC1 />
                    <USERVC2 />
                    <USERVC3 />
                    <VERPACKEH>26.00</VERPACKEH>
                    <WARENGR>TESSUTO</WARENGR>
                    <WARENNR>4202929890</WARENNR>
                </LIEFERSCHEINPOS>
            </LIEFERSCHEINPOSLISTE>
        </LIEFERSCHEIN>
    </LIEFERSCHEINLISTE>
</EULANDA>
```

