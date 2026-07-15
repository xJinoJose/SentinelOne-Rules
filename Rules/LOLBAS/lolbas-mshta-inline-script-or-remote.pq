| filter tgt.process.name = 'mshta.exe'
        AND (tgt.process.cmdline contains 'javascript:'
            OR tgt.process.cmdline contains 'vbscript:'
            OR tgt.process.cmdline contains 'http://'
            OR tgt.process.cmdline contains 'https://')