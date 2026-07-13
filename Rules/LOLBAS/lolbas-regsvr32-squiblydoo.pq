| filter tgt.process.name = 'regsvr32.exe'
        AND tgt.process.cmdline contains 'scrobj.dll'
        AND (tgt.process.cmdline contains '/i:' or tgt.process.cmdline contains '-i:')