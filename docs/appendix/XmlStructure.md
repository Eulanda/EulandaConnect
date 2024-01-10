# XML-Structure

The following structure is used for transmitting item master data, address master data, order entries, price lists, and stock numbers. Certain branches are included depending on the task at hand. The file names are product-(uid).xml, stock-(uid).xml, prices-(uid).xml, address-(uid).xml, and order-(uid).xml. The (uid) stands for a placeholder of a 32-bit uid such as product-9155C2C8-DD27-4EED-B96E-70DDD222EB91.xml.

> **NOTE**: The following description is brief, for a more detailed explanation, please refer to a separate GitHub project at: https://github.com/Eulanda/EulandaXML/blob/master/EulandaXML-EN.md



```xml
<?xml version="1.0" encoding="UTF-8"?>
<EULANDA>
    <METADATA>
        <VERSION>2.3.1</VERSION>
        <GENERATOR>EulandaConnect</GENERATOR>
        <DATEFORMAT>ISO8601</DATEFORMAT>
        <FLOATFORMAT>US</FLOATFORMAT>
        <COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
        <FIELDNAMES>NATIVE</FIELDNAMES>
        <DATE>2018-08-04T12:21:59</DATE>
        <PCNAME>SQL</PCNAME>
        <USERNAME>ADMINISTRATOR</USERNAME>
        <DATABASEVERSION>5.63</DATABASEVERSION>
    </METADATA>
    <!-- INFO: Node MERKMALBAUM is a must -->
    <MERKMALBAUM>
        <!-- INFO: If not used this node at least one empty is needed like <ARTIKEL /> -->
        <ARTIKEL>
            <PFAD>\SHOP</PFAD>
            <MERKMAL>
                <NAME>Bedienersprache</NAME>
                <MERKMALTYP>1</MERKMALTYP>
                <!-- INFO: For diffrent languages use seperators in a single line with CRLF  -->
                <BESCHREIBUNG>
                    [DE]
				   Über Sprachpakete kann die...
                    [IT]
                    I pacchetti linguistici possono...
                </BESCHREIBUNG>
                <!-- INFO: Without path, tehy are taken from DMS folder  -->
                <BILD>enterprise_bedienersprache.jpg</BILD>
                <PUBLISHED>1</PUBLISHED>
                <TOP>0</TOP>
                <SQLBEDINGUNG />
                <UID>{9155C2C8-DD27-4EED-B96E-70DDD222EB91}</UID>
                <COLOR>536870911</COLOR>
            </MERKMAL>
            <!-- REPEAT: MERKMAL -->
        </ARTIKEL>
    </MERKMALBAUM>
    <!-- INFO: Node RABATTLISTE is a must -->
    <RABATTLISTE>
        <!-- INFO: Only rebates in this context are exported -->
        <RABATT>
            <RG>SOFTWARE</RG>
            <KG>HC</KG>
            <BEZ>Description</BEZ>
            <RABATT>15.50</RABATT>
        </RABATT>
        <!-- REPEAT: RABATT -->
    </RABATTLISTE>
    <ARTIKELLISTE>
        <ARTIKEL>
            <ID.ALIAS>5513</ID.ALIAS>
            <CHANGEDATE>2018-07-06T13:25:34</CHANGEDATE>
            <ARTNUMMER>5513</ARTNUMMER>
            <ARTMATCH>PLUGIN SHOP NOP FRANCHISE</ARTMATCH>
            <BARCODE>4014751055130</BARCODE>
            <RABATTGR>Plugins Eulanda</RABATTGR>
            <MWSTSATZ>19.00</MWSTSATZ>
            <MWSTGR>3</MWSTGR>
            <WAEHRUNG>EUR</WAEHRUNG>
            <GEWICHT>0.00</GEWICHT>
            <SHOPEXPORTDATUM>2018-07-06T13:25:34</SHOPEXPORTDATUM>
            <SHOPFREIGABEFLG>1</SHOPFREIGABEFLG>
            <AUSLAUFFLG>0</AUSLAUFFLG>
            <NEUFLG>0</NEUFLG>
            <SONDERFLG>0</SONDERFLG>
            <LOESCHFLG>0</LOESCHFLG>
            <VERPACKEH>1.00</VERPACKEH>
            <PREISEH>1.00</PREISEH>
            <VK>25000.00</VK>
            <BRUTTOFLG>0</BRUTTOFLG>
            <VKNETTO>25000.00</VKNETTO>
            <VKBRUTTO>29750.00</VKBRUTTO>
            <LAGERTYP>17</LAGERTYP>
            <VOLUMEN>0.00</VOLUMEN>
            <KURZTEXT1>nopCommerce Franchise-System</KURZTEXT1>
            <KURZTEXT2>nopCommerce Franchise-System</KURZTEXT2>
            <ULTRAKURZTEXT>nopCommerce Franchise-System</ULTRAKURZTEXT>
            <!-- INFO: For diffrent languages use seperators in a single line with CRLF  -->
            <LANGTEXT>nopCommerce Franchise-System</LANGTEXT>
            <!-- INFO: For diffrent languages use seperators in a single line with CRLF  -->
            <INFO>nopCommerce Franchise-System</INFO>
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
            <SHOP>
                <!-- INFO: Two double quotes means that the field content is to be deleted.  --> 
                <ARTICLETYPE>1</ARTICLETYPE>
                <BASEDIVISOR>0.00</BASEDIVISOR>
                <BASEUNIT>""</BASEUNIT>
                <CROSS1>""</CROSS1>
                <CROSS2>""</CROSS2>
                <CROSS3>""</CROSS3>
                <CROSS4>""</CROSS4>
                <CROSS5>""</CROSS5>
                <CROSS6>""</CROSS6>
                <CROSS7>""</CROSS7>
                <CROSS8>""</CROSS8>
                <DIMENSIONDEPTH>0</DIMENSIONDEPTH>
                <DIMENSIONHEIGHT>0</DIMENSIONHEIGHT>
                <IMAGE1>""</IMAGE1>
                <IMAGE10>""</IMAGE10>
                <IMAGE11>""</IMAGE11>
                <IMAGE12>""</IMAGE12>
                <IMAGE13>""</IMAGE13>
                <IMAGE14>""</IMAGE14>
                <IMAGE15>""</IMAGE15>
                <IMAGE2>""</IMAGE2>
                <IMAGE3>""</IMAGE3>
                <IMAGE4>""</IMAGE4>
                <IMAGE5>""</IMAGE5>
                <IMAGE6>""</IMAGE6>
                <IMAGE7>""</IMAGE7>
                <IMAGE8>""</IMAGE8>
                <IMAGE9>""</IMAGE9>
                <INFOURL>""</INFOURL>
                <INFOURLTEXT>""</INFOURLTEXT>
                <METADESCRIPTION>""</METADESCRIPTION>
                <METAKEYWORDS>""</METAKEYWORDS>
                <METATITLE>""</METATITLE>
                <SALESSIZE>0.00</SALESSIZE>
                <SALESUNIT>""</SALESUNIT>
                <SHIPPINGFREE>0</SHIPPINGFREE>
                <SHIPPINGWEIGHT>0.00</SHIPPINGWEIGHT>
                <SUGGESTEDLISTPRICE>0.00</SUGGESTEDLISTPRICE>
                <UP1>""</UP1>
                <UP2>""</UP2>
                <UP3>""</UP3>
                <UP4>""</UP4>
                <UP5>""</UP5>
                <UP6>""</UP6>
                <UP7>""</UP7>
                <UP8>""</UP8>
            </SHOP>
            <LAGER>
                <!-- INFO: Physical stock, stock with sales orders, stock with purchase orders -->
                <BESTANDVERFUEGBAR>1000.00</BESTANDVERFUEGBAR>
                <BESTANDVERFUEGBAR1>800.00</BESTANDVERFUEGBAR1>
                <BESTANDVERFUEGBAR2>1100.00</BESTANDVERFUEGBAR2>
            </LAGER>
             <!-- INFO: Tier price list -->
            <PREISLISTE>
                <!-- INFO: Price entry starting with the quantity (MENGEAB) -->
                <PREIS>
                    <NAME>HC</NAME>
                    <WAEHRUNG>EUR</WAEHRUNG>
                    <BRUTTOFLG>0</BRUTTOFLG>
                    <STAFFEL>1</STAFFEL>
                    <MENGEAB>1</MENGEAB>
                    <VK>16250.00</VK>
                </PREIS>
                <!-- REPEAT: PREIS -->
            </PREISLISTE>
            <MERKMALLISTE>
                <!-- INFO: Articles can be contained multiple time in the tree -->
                <MERKMAL>
                    <PFAD>\SHOP\Test</PFAD>
                </MERKMAL>
                <!-- REPEAT: MERKMAL -->
            </MERKMALLISTE>
        </ARTIKEL>
        <!-- REPEAT: ARTIKEL -->
    </ARTIKELLISTE>
    <ADRESSELISTE>
        <ADRESSE>
            <!-- INFO: ID.ALIAS is unique 1:1 field Match -->
            <ID.ALIAS>SHOPIFY=FACEMONTY@TOOLHEROS.DE</ID.ALIAS>
            <MATCH>SHOPIFY=FACEMONTY@WTOOLHEROS.DE</MATCH>
            <NAME1>Harald</NAME1>
            <NAME2>Schmitz</NAME2>
            <NAME3 />
            <STRASSE>Langgasse 15</STRASSE>
            <PLZ>65510</PLZ>
            <ORT>Idstein</ORT>
            <LAND>DE</LAND>
            <EMAIL>facemonty@toolheros.de</EMAIL>
            <TEL />
            <ZIELID.ALIAS>SHOP.PAID</ZIELID.ALIAS>
            <!-- INFO: The user fields are optional -->
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
        </ADRESSE>
        <!-- REPEAT: ADRESSE -->
    </ADRESSELISTE>
    <AUFTRAGLISTE>
        <AUFTRAG>
            <DATUM>19-09-2021T21:16:05</DATUM>
            <BESTELLDATUM>2021-09-19T21:16:01</BESTELLDATUM>
            <!-- INFO: The field BESTELLNUMMER must be UNIQUE -->
            <BESTELLNUMMER>NW-3930</BESTELLNUMMER>
            <OBJEKT>Onlineshop</OBJEKT>
            <BRUTTOFLG>1</BRUTTOFLG>
            <ADRESSEID.ALIAS>SHOPIFY=FACEMONTY@TOOLHEROS.DE</ADRESSEID.ALIAS>
            <NAME1>Harald</NAME1>
            <NAME2>Schmitz</NAME2>
            <NAME3 />
            <STRASSE>Langgasse 15</STRASSE>
            <PLZ>65510</PLZ>
            <ORT>Idstein</ORT>
            <LAND>DE</LAND>
            <SHOPEMAIL>facemonty@toolheros.de</SHOPEMAIL>
            <SHOPTEL />
            <ZIELID.ALIAS>SHOP.PREPAID</ZIELID.ALIAS>
            <LADRESSEID.ALIAS>SHOPIFY=SHIPPING</LADRESSEID.ALIAS>
            <LNAME1>Harald</LNAME1>
            <LNAME2>Schmitz</LNAME2>
            <LNAME3 />
            <LSTRASSE>Marktplatz 15</LSTRASSE>
            <LPLZ>65510</LPLZ>
            <LORT>Hünstetten</LORT>
            <LLAND>DE</LLAND>
            <SHOPLEMAIL>facemonty@toolheros.de</SHOPLEMAIL>
            <SHOPLTEL />
            <!-- INFO: The user fields are optional -->
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
            <SHOP>
                <SHIPPINGINFO>
                    <COST>4.99</COST>
                </SHIPPINGINFO>
            </SHOP>
            <AUFTRAGPOSLISTE>
                <AUFTRAGPOS>
                    <ARTIKELID.ALIAS>S0221265</ARTIKELID.ALIAS>
                    <MENGE>1</MENGE>
                    <VKRAB>33.44</VKRAB>
                    <VKVRAB>33.44</VKVRAB>
                    <BASIS>30.08</BASIS>
                    <!-- INFO: The user fields are optional -->
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
                </AUFTRAGPOS>
                <!-- REPEAT: AUFTRAGPOS -->
            </AUFTRAGPOSLISTE>
        </AUFTRAG>
        <!-- REPEAT: AUFTRAG -->
    </AUFTRAGLISTE>
    <LIEFERSCHEINLISTE>
      <LIEFERSCHEIN>
	    <ID.ALIAS>430952</ID.ALIAS>
        <ANSCHRIFT>Company Enterprise Systems Ltd.
				 Mr. Smith
				 Bakers Street 2
				 12500 Maple, NY
		</ANSCHRIFT>
         <ADRESSEID>13</ADRESSEID>
         <ANZAHLPAKETE>0</ANZAHLPAKETE>
         <AUFTRAGNUMMER>530973</AUFTRAGNUMMER>
         <AUFTRAGDATUM>2023-04-21T21:32:15.0+00:00</AUFTRAGDATUM>
         <AUFTRAGID>2121</AUFTRAGID>
         <AUFTRAGNUMMER>130973</AUFTRAGNUMMER>
         <BEARBEITETDURCH>CARLA</BEARBEITETDURCH>
         <BESTELLNUMMER>67731</BESTELLNUMMER>
         <BESTELLTDURCH>Mr. Smith</BESTELLTDURCH>
         <DATUM>2023-04-21T21:32:16.0+00:00</DATUM>
         <DRUCKNAME1></DRUCKNAME1>
         <DRUCKNAME2>Company Enterprise Systems Ltd.</DRUCKNAME2>
         <DRUCKNAME3>Mr. Smith</DRUCKNAME3>
         <EMAIL>john@doe.com</EMAIL>
         <FIBUKONTO>10052</FIBUKONTO>
         <GEWICHT>10.1000</GEWICHT>
         <GEWICHTSUM>10.22</GEWICHTSUM>
         <ID>2476</ID>
         <ILN />
         <INFO />
         <LAND>US</LAND>
         <LIEFERBED />
         <LIEFERSCHEINNUMMER>430952</LIEFERSCHEINNUMMER>
         <NAME1>Company Enterprise Systems Ltd.</NAME1>
         <NAME2></NAME2>
         <NAME3>Mr. Smith</NAME3>
         <NAMELANG>Company Enterprise Systems Ltd. Mr. Smith</NAMELANG>
         <NACHTEXT />
         <OBJEKT>PO 112074</OBJEKT>
         <ORT>Maple</ORT>
         <ORTLANG>USA - 12500 Maple</ORTLANG>
         <PLZ>12500</PLZ>
         <PROVINZ>NY</PROVINZ>
         <SPEDAUFTRAGNR />
         <STRASSE>Bakers Street 2</STRASSE>
         <TEL />
         <TRACKINGLISTE>
             <TRACKING>
                 <SHIPMENTID>1Z12345642</SHIPMENTID>
                 <CARRIERNAME>UPS</CARRIERNAME>
             </TRACKING>
             <!-- REPEAT: TRACKING -->
         </TRACKINGLISTE>
         <USTID />
         <USERD1>0001-01-01T00:00:00.0+00:00</USERD1>
         <USERD2>0001-01-01T00:00:00.0+00:00</USERD2>
         <USERI1>0</USERI1>
         <USERI2>0</USERI2>
         <USERI3>0</USERI3>
         <USERN1>0.0</USERN1>
         <USERN2>0.0</USERN2>
         <USERN3>0.0</USERN3>
         <USERVC1 />
         <USERVC2 />
         <USERVC3 />
         <VERSANDARTNAME>GND FedEx</VERSANDARTNAME>
         <VORTEXT />
         <ZAHLUNGSART>MISC</ZAHLUNGSART>      
         <LIEFERSCHEINPOSLISTE>
           <LIEFERSCHEINPOS>
             <POSNUMMER>1</POSNUMMER>
             <ARTMATCH>SCREWS</ARTMATCH>
             <ARTNUMMER>AB-4711</ARTNUMMER>
             <BARCODE>1255604310</BARCODE>
             <ERWEITERTEPOS />
             <GEWICHT>7.7000</GEWICHT>
             <GEWICHTGES>8.4000</GEWICHTGES>
             <ID>12824</ID>
             <INFO>Smurfit Kappa</INFO>
             <KARTONS>4</KARTONS>
             <KARTONSBERECHNET>3.6000000000</KARTONSBERECHNET>
             <KURZTEXT1 />
             <KURZTEXT2 />
             <LANGTEXT />
             <MENGE>12.0000</MENGE>
             <MENGENEH>piece(s)</MENGENEH>
             <RABATTGR />
             <ULTRAKURZTEXT />
             <UID>D34A5C45-2A73-4197-A99D-96DF1705825E</UID>
             <URSPRUNGSLAND>GB</URSPRUNGSLAND>
             <USERD1>0001-01-01T00:00:00.0+00:00</USERD1>
             <USERD2>0001-01-01T00:00:00.0+00:00</USERD2>
             <USERI1>0</USERI1>
             <USERI2>0</USERI2>
             <USERI3>0</USERI3>
             <USERN1>0.0</USERN1>
             <USERN2>0.0</USERN2>
             <USERN3>0.0</USERN3>
             <USERVC1 />
             <USERVC2 />
             <USERVC3 />
             <VERPACKEH>5.00</VERPACKEH>
             <WARENGR>Boxes</WARENGR>
             <WARENNR />
           </LIEFERSCHEINPOS>
           <!-- REPEAT: LIEFERSCHEINPOS -->
         </LIEFERSCHEINPOSLISTE>
      </LIEFERSCHEIN>
      <!-- REPEAT: LIEFERSCHEIN -->
    </LIEFERSCHEINLISTE>
</EULANDA>
```