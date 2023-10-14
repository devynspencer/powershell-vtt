@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'VirtualTabletop.psm1'

    # Version number of this module.
    ModuleVersion = '0.0.1'

    # Author of this module
    Author = 'Devyn Spencer'

    # Copyright statement for this module
    Copyright = '(c) 2023 Devyn Spencer. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'PowerShell module for managing and organizing virtual tabletop assets.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '7.1'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules = @()

    # Functions to export from this module
    FunctionsToExport = @(
    )

    # Private data to pass to the module specified in RootModule
    PrivateData = @{
        PSData = @{
            # Tags applied to this module for discovery in online galleries.
            Tags = @(
                'virtual tabletop',
                'asset management',
                'categorization',
                'backup',
                'organization',
                'automation'
            )

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/devynspencer/powershell-vtt/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/devynspencer/powershell-vtt'

            # Release notes for this module.
            ReleaseNotes = 'https://github.com/devynspencer/powershell-vtt/RELEASENOTES.md'
        }
    }
}
