| filter tgt.process.name = 'regsvr32.exe'
        AND (tgt.process.cmdline contains '\\Temp\\'
            OR tgt.process.cmdline contains '\\AppData\\'
            OR tgt.process.cmdline contains '\\Downloads\\'
            OR tgt.process.cmdline contains '\\Users\\Public\\'
            OR tgt.process.cmdline contains '\\ProgramData\\')