function Get-Distance {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)] # Coordinates of the first point
        [ValidateRange(-90,90)]
        [Alias('lat1')]
        [double]$startLatitude = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'startLatitude', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(-180,180)]
        [Alias('long1')]
        [double]$startLongitude = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'startLongitude', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)] # Coordinates of the second point
        [ValidateRange(-90,90)]
        [Alias('lat2')]
        [double]$endLatitude = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'endLatitude', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(-180,180)]
        [Alias('long2')]
        [double]$endLongitude = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'endLongitude', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }


    process {
        $earthRadiusKm = 6371 # Earth's radius in kilometers

        # Convert degrees to radians
        $deltaLatitudeRadians = ($endLatitude - $startLatitude) * [Math]::PI / 180
        $deltaLongitudeRadians = ($endLongitude - $startLongitude) * [Math]::PI / 180

        # Haversine formula: a = sin²(Δlat/2) + cos(lat1).cos(lat2).sin²(Δlong/2)
        $halfChordSquared = [Math]::Sin($deltaLatitudeRadians / 2) * [Math]::Sin($deltaLatitudeRadians / 2) +
                            [Math]::Cos($startLatitude * [Math]::PI / 180) * [Math]::Cos($endLatitude * [Math]::PI / 180) *
                            [Math]::Sin($deltaLongitudeRadians / 2) * [Math]::Sin($deltaLongitudeRadians / 2)

        # Haversine formula: c = 2.atan2(√a, √(1−a))
        $angularDistanceRadians = 2 * [Math]::Atan2([Math]::Sqrt($halfChordSquared), [Math]::Sqrt(1 - $halfChordSquared))

        # Haversine formula: d = R.c
        $result = $earthRadiusKm * $angularDistanceRadians
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Distance -startLatitude 52.52 -startLongitude 13.405 -endLatitude 48.8566 -endLongitude 2.3522
    # Returns distance from Berlin to Paris which is 877 km
}
