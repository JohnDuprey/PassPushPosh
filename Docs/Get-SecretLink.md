# Get-SecretLink

## SYNOPSIS
Returns a fully qualified secret link to a push of given URL Token

## SYNTAX

```powershell
Get-SecretLink [-URLToken] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Accepts a string value for a URL Token and retrieves a full URL link to the secret.
Returned value is a 1-step retrieval link depending on option selected during Push creation.
Returns false if URL Token is invalid, however it will return a URL if the token is valid
but the Push is expired or deleted.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SecretLink -URLToken gzv65wiiuciy
https://pwpush.com/p/gzv65wiiuciy/r
```

## PARAMETERS

### -URLToken
URL Token for the secret

```yaml
Type: String
Parameter Sets: (All)
Aliases: Token

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

- [string] URL Token value

## OUTPUTS

- [string] Fully qualified URL

## NOTES
Including this endpoint for completeness - however it is generally unnecessary.
The only thing this endpoint does is return a different value depending if "Use 1-click retrieval step"
was selected when the Push was created. 
Since both the 1-click and the direct links are available
regardless if that option is selected, the links are calculable and both are included by default in a
\[PasswordPush\] object.

As it returns false if a Push URL token is not valid you can use it to test if a Push exists without
burning a view.

## RELATED LINKS

[https://github.com/adamburley/PassPushPosh/blob/main/Docs/Get-SecretLink.md](https://github.com/adamburley/PassPushPosh/blob/main/Docs/Get-SecretLink.md)

[https://pwpush.com/api/1.0/passwords/preview.en.html](https://pwpush.com/api/1.0/passwords/preview.en.html)

