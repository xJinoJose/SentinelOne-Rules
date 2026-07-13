| filter src.process.name = 'regsvr32.exe'
        AND tgt.process.name in ('cmd.exe', 'powershell.exe', 'powershell_ise.exe', 'wscript.exe', 'cscript.exe', 'mshta.exe', 'rundll32.exe')