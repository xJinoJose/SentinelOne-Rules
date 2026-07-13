| filter tgt.process.name in ('TeamViewer.exe', 'TeamViewer_Service.exe')
        OR tgt.process.displayName contains 'TeamViewer'
        OR tgt.process.publisher contains 'TeamViewer'