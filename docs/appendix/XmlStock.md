# XML Stock

The XML file with the stock figures can be used for inbound and outbound processing. Outbound, for example, to transfer the new stocks from the ERP system to a sales platform and inbound to transfer the stock from an external warehouse such as that of a logistics provider.

In the simplest case, the XML node `LAGER` only has the field `BESTANDVERFUEGBAR`, which is the absolute stock. In addition, there are the fields `BESTANDVERFUEGBAR1` and `BESTANDVERFUEGBAR2`, which on the one hand contain the order lead time or, with the second, also take into account the goods ordered from the upstream supplier.

The structure is a subset of the XML description of a `article master data`. The field descriptions are natively in German. There is an alphabetical [field description](./appendix/Fields.md) in the glossary.

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
	<ARTIKELLISTE>
		<ARTIKEL>
			<ID.ALIAS>1101038</ID.ALIAS>
             <ARTNUMMER>1101038</ARTNUMMER>
			<LAGER>
				<BESTANDVERFUEGBAR>1</BESTANDVERFUEGBAR>
			</LAGER>
		</ARTIKEL>
		<ARTIKEL>
			<ID.ALIAS>1101037</ID.ALIAS>
			<ARTNUMMER>1101037</ARTNUMMER>
			<LAGER>
				<BESTANDVERFUEGBAR>1</BESTANDVERFUEGBAR>
			</LAGER>
		</ARTIKEL>
	</ARTIKELLISTE>
</EULANDA>
```

