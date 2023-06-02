function Test-ValidateConnStr {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$connStr
    )

    $regex = "^(?=.*Data Source=)(?=.*Initial Catalog=).*"
    if (![string]::IsNullOrEmpty($connStr) -and $connStr -notmatch $regex) {
        Throw "The connection string '$connStr' is not valid."
    }

    return $true
}
