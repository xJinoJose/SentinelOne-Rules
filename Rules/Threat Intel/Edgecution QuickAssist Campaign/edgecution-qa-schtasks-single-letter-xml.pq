| filter tgt.process.name = 'schtasks.exe'
        AND tgt.process.cmdline contains '/create'
        AND tgt.process.cmdline contains '/tn'
        AND tgt.process.cmdline contains '/xml'