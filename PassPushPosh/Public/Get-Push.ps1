function Get-Push {
    <#
    .SYNOPSIS
    Retrieve the secret contents of a Push
    
    .DESCRIPTION
    Accepts a URL Token string, returns a Push object
    
    .INPUTS
    [string]

    .OUTPUTS
    [PasswordPush]

    .EXAMPLE
    Get-Push -URLToken gzv65wiiuciy
    
    TODO example output

    .EXAMPLE
    Get-Push -URLToken gzv65wiiuciy -Raw

    TODO example output
    
    .NOTES
    TODO rewrite
    #>
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param(
        # URL Token for the secret
        [parameter(Mandatory,ValueFromPipeline,Position=0)]
        [ValidateNotNullOrEmpty()]
        [Alias('Token')]
        $URLToken,

        # Returns raw json response from call
        [Parameter()]
        [switch]
        $Raw

    )
    begin { Initialize-PassPushPosh -Verbose:$VerbosePreference -Debug:$DebugPreference }

    process {
        try {
            $response = Invoke-WebRequest -Uri $Script:PPPBaseUrl/p/$URLToken.json -Method Get -ErrorAction Stop
            if ($DebugPreference -eq [System.Management.Automation.ActionPreference]::Continue) {
                Set-Variable -Scope Global -Name PPPLastCall -Value $response
                Write-Debug 'Response to Invoke-WebRequest set to PPPLastCall Global variable'
            }
            if ($Raw) {
                Write-Debug "Returning raw object:`n$($response.Content)"
                return $response.Content
            }
            return $response.Content | ConvertTo-PasswordPush
        } catch {
            Write-Verbose "An exception was caught: $($_.Exception.Message)"
            if ($DebugPreference -eq [System.Management.Automation.ActionPreference]::Continue) {
                Set-Variable -Scope Global -Name PPPLastError -Value $_
                Write-Debug -Message 'Response object set to global variable $PPPLastError'
            }
        }
    }
}