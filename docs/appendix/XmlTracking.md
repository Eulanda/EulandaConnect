# XML Tracking

The tracking numbers for a delivery can be used inbound and outbound. Inbound if, for example, a logistics company has dispatched goods and this information is to be transferred back to merchandise management, or outbound if a delivery is transmitted to sales platforms.

The structure is a subset of the XML description of a delivery note. The field descriptions are natively in German. There is an alphabetical [field description](./appendix/Fields.md) in the glossary.

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
            <TRACKINGLISTE>
                <TRACKING>
                    <SHIPMENTID>1Z12345642</SHIPMENTID>
                    <CARRIERNAME>UPS</CARRIERNAME>
                </TRACKING>
                <TRACKING>
                    <SHIPMENTID>1Z12345643</SHIPMENTID>
                    <CARRIERNAME>UPS</CARRIERNAME>
                </TRACKING>                
            </TRACKINGLISTE>
            </LIEFERSCHEINPOSLISTE>
        </LIEFERSCHEIN>
    </LIEFERSCHEINLISTE>
</EULANDA>
```

