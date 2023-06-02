function Test-ValidateConn {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [object]$conn
    )

    if ($conn -and $conn -is [System.__ComObject]) {
        return $true
    }
    else {
        throw "The connection object is not a valid COM object."
    }
}
