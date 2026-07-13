| filter tgt.process.name in ('SRServer.exe', 'SRService.exe', 'SRManager.exe')
        OR tgt.process.displayName contains 'Splashtop'
        OR tgt.process.publisher contains 'Splashtop'