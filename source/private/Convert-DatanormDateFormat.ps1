function Convert-DatanormDateFormat {
    param(
        [string]$date
    )
    <#
        .SYNOPSIS
        Converts a date string from the Datanorm date format (TTMMJJ) to the ISO 8601 date format (YYYY-MM-DD).

        .DESCRIPTION
        This function takes a date string formatted according to the Datanorm date standard (day, month, two-digit year) and converts it to the ISO 8601 date format.
        The function assumes that the input year is in the 2000s.

        .PARAMETER date
        The input date string to be converted from Datanorm format to ISO 8601 format.

        .EXAMPLE
        PS C:\> Convert-DatanormDateFormat -date '310122'
        This command converts the Datanorm date string '310122' (January 31, 2022) to the ISO 8601 date string '2022-01-31'.

        .NOTES
        This function is useful for processing Datanorm files, which use a different date format (TTMMJJ) than the widely used ISO 8601 standard.
        Invalid date strings that don't follow the expected format will trigger an exception.
    #>

    # Ensure the date string is in the expected format
    if ($date -match '^(\d{2})(\d{2})(\d{2})$') {
        # Extract the day, month and year
        $day = $Matches[1]
        $month = $Matches[2]
        $year = $Matches[3]

        # Construct a new date string in the format "YYYY-MM-DD"
        # Here we assume the year is in the 2000s
        $newDate = "20$year-$month-$day"

        return $newDate
    } else {
        Throw ((Get-ResStr 'WRONG_DATANORM_DATE_FORMAT') -f $myInvocation.Mycommand)
    }
}
