function Get-SingleToken {
    [CmdletBinding()]
    param()

    return @("token", "encryptedToken", "secureToken", "pathToToken")
}