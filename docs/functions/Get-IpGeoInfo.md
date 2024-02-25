---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-IpGeoInfo.md
schema: 2.0.0
---

# Get-IpGeoInfo

## SYNOPSIS
This PowerShell function retrieves geographic information for a specified IP address. The function uses the IP-API service to retrieve the information, which includes details like the country, region, city, latitude, longitude, ISP and more.

## SYNTAX

```
Get-IpGeoInfo [[-ip] <String>] [[-age] <Int32>] [[-apiWait] <Int32>] [[-xmlGeoPath] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
- The function makes a GET request to the IP-API service, passing the IP address as a parameter. The function also includes some additional features:

  - Global Hash Table: The function maintains a global hash table of IP addresses and their corresponding geo-information. This hash table, `$global:geoHashTable`, is accessible for further manipulation or data extraction. The geo-information includes various details such as:
    - `query`: IP used for the query.
    - `status`: success or fail.
    - `country`: Name of the country.
    - `countryCode`: Two-letter ISO 3166-1 alpha code of the country.
    - `region`: Region/state short code.
    - `regionName`: Region/state.
    - `city`: City name.
    - `zip`: Postal/Zip code.
    - `lat`: Latitude.
    - `lon`: Longitude.
    - `timezone`: City's timezone.
    - `isp`: ISP name.
    - `org`: Organization name.
    - `as`: AS number and name.
  - Caching of results: To avoid unnecessary API calls, the function saves the retrieved information in a XML file. Subsequent requests for the same IP address will retrieve the information from the cache instead of making a new API call.
  - Aging of cache entries: The function checks if the cache entry is older than a specified age (in months). If it is, a new API call is made to update the cache entry.
  - Waiting time between API calls: To avoid overloading the API, the function waits a specified amount of time (in milliseconds) between API calls.
  - IP address validation: The function includes some basic checks to validate the IP address and checks if it's a private or reserved IP address.

  To access specific information from the global hashtable `$global:geoHashTable`, simply use the key (in this case, the IP address). For example, to get the country code, you can do the following: `$countryCode = $global:geoHashTable["YourIP"].data.countryCode` .  This hashtable also contains `createDate` and `changeDate` properties, which can be accessed in a similar manner: `$createDate = $global:geoHashTable["YourIP"].createDate` or `$changeDate = $global:geoHashTable["YourIP"].changeDate`. Please replace `"YourIP"` with the actual IP address you want to get information for.

  Note: `$global:geoHashTable` contains the most recently retrieved geolocation data for each IP address. If the data for an IP address is not available, you need to call `Get-IpGeoInfo` function first, which will store the data in the hashtable for later use.

## EXAMPLES

### Example 1: Retrieve the geographic information  for an ip address
```powershell
PS C:\> $country = Get-IpGeoInfo -ip "8.8.8.8"
```

This will retrieve the geographic information for the IP address "8.8.8.8" and display verbose messages in this case it is 'US'.

## PARAMETERS

### -age
The age (in months) after which a cache entry should be updated. Default is 6 months.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiWait
The waiting time (in milliseconds) between API calls. Default is 2000 ms.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ip
The IP address for which to retrieve geographic information. This is a mandatory parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -xmlGeoPath
The path to the XML file used for caching. If only a filename is specified (without a path), the file is saved in the '.eulandaconnect' directory in the user's home folder.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Merge-IpGeoInfo](./functions/Merge-IpGeoInfo.md)




