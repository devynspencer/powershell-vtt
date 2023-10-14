function Rename-TabletopTokenImage {
    param (
        # Source directory containing downloaded tokens.
        [Parameter(Mandatory)]
        $SourceDirectory,

        # Destination directory to move renamed tokens to. Subdirectories created for each token type.
        [Parameter(Mandatory)]
        $DestinationDirectory,

        # File extension of input files. Other files ignored.
        [ValidateSet('jpg', 'jpeg', 'png', 'webp')]
        $FileExtension = 'png',

        # List of token types to search for in file names. Determines token type and output subdirectory.
        $TokenTypes = @(
            'aberration',
            'beast',
            'celestial',
            'construct',
            'diety',
            'dragon',
            'elemental',
            'environment',
            'fey',
            'giant',
            'goblinoid',
            'humanoid',
            'monstrosity',
            'ooze',
            'plant',
            'spell',
            'undead'
        )
    )

    # Ensure subdirectories exist for each token type
    foreach ($TokenType in $TokenTypes) {
        $SubDirectory = Join-Path -Path $DestinationDirectory -ChildPath $TokenType

        if (!(Test-Path $SubDirectory)) {
            Write-Host -ForegroundColor Cyan "Subdirectory [$SubDirectory] not found, creating..."

            $null = New-Item -ItemType Directory -Path $SubDirectory
        }
    }

    # Loop through the files in the source directory
    Write-Host -ForegroundColor Cyan "Renaming [$FileExtension] assets in directory [$SourceDirectory]"

    Get-ChildItem -Path $SourceDirectory -File -Filter "*.$FileExtension" | ForEach-Object {
        $OriginalName = $_.Name
        $Matched = $false

        Write-Host -ForegroundColor Cyan "Renaming asset file [$OriginalName]"

        # Loop through the patterns
        foreach ($TokenType in $TokenTypes) {
            $SubDirectory = Join-Path -Path $DestinationDirectory -ChildPath $TokenType

            if ($OriginalName -match $TokenType) {
                Write-Host -ForegroundColor Cyan "Matched type [$TokenType] for asset file [$OriginalName]"

                # TODO: Extract match pattern to parameter(s)
                # TODO: Add support for multiple possible match patterns

                # Generate new filename based on token type and token name (remove date and other extraneous characters)
                $NewName = $TokenType + '-' + $OriginalName -replace "_token-editor_token-uploads_$TokenType`_(\w+)_\d{4}-\d{2}-\d{2}T\d{2}_\d{2}_\d{2}\.\d{3}Z", '$1'
                $NewPath = Join-Path -Path $SubDirectory -ChildPath $NewName

                # TODO: Handle tokens with a numeric suffix (add a hyphen just before, i.e. rename $TokenType-$TokenName1.png to $TokenType-$TokenName-1.png)

                Write-Host -ForegroundColor DarkCyan "Moving asset [$NewName] to [$NewPath]"
                Move-Item -Path $_.FullName -Destination $NewPath -Force

                # Break from loop once a match is found
                $Matched = $true
                break
            }
        }

        # If no patterns were matched, move the file to a separate directory
        if (!$Matched) {
            $UnmatchedDirectory = Join-Path -Path $DestinationDirectory -ChildPath 'unmatched'
            $NewPath = Join-Path -Path $UnmatchedDirectory -ChildPath $OriginalName

            # Create directory for unmatched tokens if none exists
            if (!(Test-Path $UnmatchedDirectory)) {
                Write-Host -ForegroundColor Cyan "Subdirectory [$UnmatchedDirectory] not found, creating..."
                $null = New-Item -ItemType Directory -Path $UnmatchedDirectory
            }

            Write-Host -ForegroundColor Magenta "No match found for asset [$OriginalName], moving to [$NewPath]"
            Move-Item -Path $_.FullName -Destination $NewPath -Force
        }
    }
}
