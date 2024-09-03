﻿<#
    .SYNOPSIS
    Returns a fully qualified secret link to a push of given URL Token

    .DESCRIPTION
    Accepts a string value for a URL Token and retrieves a full URL link to the secret.
    Returned value is a 1-step retrieval link depending on option selected during Push creation.
    Returns false if URL Token is invalid, however it will return a URL if the token is valid
    but the Push is expired or deleted.

    .PARAMETER URLToken
    URL Token for the secret

    .INPUTS
    [string] URL Token value

    .OUTPUTS
    [string] Fully qualified URL

    .EXAMPLE
    Get-SecretLink -URLToken gzv65wiiuciy
    https://pwpush.com/p/gzv65wiiuciy/r

    .EXAMPLE
    Get-SecretLink -URLToken gzv65wiiuciy -Raw
    { "url": "https://pwpush.com/p/0fkapnbo_pwp4gi8uy0/r" }

    .LINK
    https://github.com/adamburley/PassPushPosh/blob/main/Docs/Get-SecretLink.md

    .LINK
    https://pwpush.com/api/1.0/passwords/preview.en.html

    .NOTES
    Including this endpoint for completeness - however it is generally unnecessary.
    The only thing this endpoint does is return a different value depending if "Use 1-click retrieval step"
    was selected when the Push was created.  Since both the 1-click and the direct links are available
    regardless if that option is selected, the links are calculable and both are included by default in a
    [PasswordPush] object.

    As it returns false if a Push URL token is not valid you can use it to test if a Push exists without
    burning a view.
    #>
function Get-SecretLink {
    [CmdletBinding()]
    [Alias('Get-PushPreview')]
    [OutputType('[string]')]
    param(
        [parameter(Mandatory, ValueFromPipeline)]
        [Alias('Token')]
        [ValidateLength(5, 256)]
        [string]$URLToken
    )
    begin { Initialize-PassPushPosh -Verbose:$VerbosePreference -Debug:$DebugPreference }
    process {
        Invoke-PasswordPusherAPI -Endpoint "p/$URLToken/preview.json" | Select-Object -ExpandProperty url
    }
}