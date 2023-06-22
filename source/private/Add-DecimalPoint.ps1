function Add-DecimalPoint {
    param(
        [string]$number
        ,
        [int]$decimalPlaces = 2
        ,
        [Alias('decimal')]
        [string]$decimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
    )

    <#
        .SYNOPSIS
        Returns a number as a string with a specified number of decimal places.

        .DESCRIPTION
        The function takes a string representation of a number,
        and returns it with the specified number of decimal places.
        If the input string is empty, it will return "0,00".

        .PARAMETER number
        A string representation of the number to which the decimal point is to be added.

        .PARAMETER decimalPlaces
        The number of decimal places to be added to the number. Default is 2.

        .PARAMETER decimalSeparator
        The character to use as a decimal separator. The default is the current system's decimal separator.

        .EXAMPLE
        PS C:\> Add-DecimalPoint -number '10000' -decimalPlaces 2
        This command will return '100,00'.

        .EXAMPLE
        PS C:\> Add-DecimalPoint -number '10000' -decimalPlaces 3
        This command will return '10,000'.

        .EXAMPLE
        PS C:\> Add-DecimalPoint -number '10000' -decimalPlaces 2 -decimalSeparator '.'
        This command will return '100.00'.

        .NOTES
        The function appends leading zeros to numbers that are shorter than the number of decimal places specified.
        If a number starts with a decimal separator after the transformation, a '0' is prepended.
    #>


    # If the string is empty, return "0,00" (with two decimal places)
    if ([string]::IsNullOrEmpty($number)) {
        return "0," + "0" * $decimalPlaces
    }

    # If the number of digits is less than the decimalPlaces, prepend it with 0's
    while ($number.Length -lt $decimalPlaces) {
        $number = "0" + $number
    }

    # Insert the comma at the correct place
    $number = $number.Insert($number.Length - $decimalPlaces, $decimalSeparator)

    # If the number now starts with a comma, prepend it with a 0
    if ($number[0] -eq $decimalSeparator) {
        $number = "0" + $number
    }

    return $number
}
