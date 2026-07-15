| filter src.process.name = 'explorer.exe'
        AND tgt.process.name = 'cmd.exe'
        AND tgt.process.cmdline contains 'for /f'
        AND tgt.process.cmdline contains 'skip='