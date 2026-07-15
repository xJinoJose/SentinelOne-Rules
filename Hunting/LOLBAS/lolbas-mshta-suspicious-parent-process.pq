| filter tgt.process.name = 'mshta.exe'
        AND src.process.name in ('winword.exe', 'excel.exe', 'powerpnt.exe', 'outlook.exe', 'wscript.exe', 'cscript.exe', 'cmd.exe', 'explorer.exe')
| group count() by src.process.name, endpoint.name
| sort count desc