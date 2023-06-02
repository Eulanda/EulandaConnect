function Get-HtmlStyle {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = @"
        <style>
        html {
            margin:    0 auto;
            max-width: 800px;
        }
        body {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
        }
        h1 {
            font-family: Arial, Helvetica, sans-serif;
            color: #e68a00;
            font-size: 28px;
        }
        h2 {
            font-family: Arial, Helvetica, sans-serif;
            color: #000099;
            font-size: 16px;
        }
        h3 {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 16px;
        }
        table {
            font-size: 12px;
            border: 0px;
            width: 600px;
            height: auto;
            font-family: Arial, Helvetica, sans-serif;
        }
        td {
            padding: 4px;
            margin: 0px;
            border: 0;
            vertical-align: top;
        }
        th {
            background: #395870;
            background: linear-gradient(#49708f, #293f50);
            color: #fff;
            font-size: 11px;
            text-transform: uppercase;
            padding: 10px 15px;
            vertical-align: middle;
        }
        tbody tr:nth-child(even) {
        background-color: #f0f0f2;
        }
        #CreationDate {
            font-family: Arial, Helvetica, sans-serif;
            color: #ff3300;
            font-size: 12px;
        }
        .StatusAttention {
            color: #ff0000;
        }
        .StatusNormal {
            color: #008000;
        }
        </style>
"@
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-HtmlStyle
}
