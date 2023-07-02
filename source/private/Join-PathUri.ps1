function Join-PathUri {
    param(
        [Parameter(Mandatory=$false)]
        [string]$base
        ,
        [Parameter(Mandatory=$false)]
        [string]$path
    )

    #  Make string variable, also if it is null
    if (! $base) { $base = [string]''}
    if (! $path) { $path = [string]''}

    #  Removes leading slash from path if present
    if ($path.StartsWith("/")) {
        $path = $path.Substring(1)
    }

    # Removes trailing slash from base, if present
    if ($base.EndsWith("/")) {
        $base = $base.Substring(0, $base.Length-1)
    }

    # Connects the two parts securely with a slash
    $result = "$base/$path"

    return $result

    <# Test:

        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features {
            $base = '/'
            $path = '/inbox'
            $result = Join-PathUri -base $base -path $path
            "'$result' should be something like  '/inbox'"
        }

    #>
}