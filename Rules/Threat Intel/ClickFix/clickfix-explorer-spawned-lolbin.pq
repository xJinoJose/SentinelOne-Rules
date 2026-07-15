| filter src.process.name = 'explorer.exe'
        AND tgt.process.name in ('powershell.exe', 'mshta.exe', 'wscript.exe', 'cscript.exe', 'cmd.exe', 'curl.exe', 'bitsadmin.exe')
        AND (tgt.process.cmdline contains '-enc'
            OR tgt.process.cmdline contains '-EncodedCommand'
            OR tgt.process.cmdline contains '-w hidden'
            OR tgt.process.cmdline contains '-windowstyle hidden'
            OR tgt.process.cmdline contains 'iex'
            OR tgt.process.cmdline contains 'Invoke-Expression'
            OR tgt.process.cmdline contains 'IWR'
            OR tgt.process.cmdline contains 'Invoke-WebRequest')