function Test-SpecificParameters {
    param(
        [Parameter(Mandatory = $true)]
        [HashTable]$BoundParameters,
        [Parameter(Mandatory = $true)]
        [string]$CommandName
    )

    # List of common parameters to be excluded
    $commonParameters = @(
        'Verbose',
        'Debug',
        'ErrorAction',
        'WarningAction',
        'InformationAction',
        'ErrorVariable',
        'WarningVariable',
        'InformationVariable',
        'OutVariable',
        'OutBuffer',
        'PipelineVariable'
    )

    if (-not (Get-Command $CommandName -ErrorAction SilentlyContinue)) {
        Throw "The command '$CommandName' does not exist."
    }


    # Extract the names of the specific parameters
    $specificParameters = (Get-Command $CommandName).Parameters.Keys | Where-Object { $_ -notin $commonParameters }

    # Filter PSBoundParameters to get only the specific parameters
    $specificBoundParameters = @($BoundParameters.Keys | Where-Object { $_ -notin $commonParameters })

    # Raise an error if no specific parameters were passed
    if ($specificBoundParameters.Count -eq 0) {
        # Convert the parameter list into a formatted string
        $parameterList = ($specificParameters | ForEach-Object { "-$_" }) -join ', '
        Throw ((Get-ResStr 'PARAMS_AT_LEAST_ONE') -f $parameterList, $CommandName)
    }
}
