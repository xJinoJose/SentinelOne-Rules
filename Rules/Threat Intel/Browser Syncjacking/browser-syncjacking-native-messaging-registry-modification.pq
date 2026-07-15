| filter event.type = 'Registry Value Set'
        AND registry.path contains 'NativeMessagingHosts'
        AND (src.process.name in ('cmd.exe', 'powershell.exe', 'reg.exe')
            OR src.process.imagePath contains '\Users\'
            OR src.process.imagePath contains '\ProgramData\'
            OR src.process.imagePath contains '\Temp\')