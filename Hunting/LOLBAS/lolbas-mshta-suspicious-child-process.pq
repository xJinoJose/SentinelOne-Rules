| filter src.process.name = 'mshta.exe'
        AND tgt.process.name in ('powershell.exe', 'cmd.exe', 'wscript.exe', 'cscript.exe', 'rundll32.exe', 'regsvr32.exe', 'wmic.exe')
| group count() by tgt.process.name, endpoint.name
| sort count desc