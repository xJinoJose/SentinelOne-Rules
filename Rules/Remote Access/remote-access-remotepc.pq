| filter tgt.process.name in ('RemotePC.exe', 'RemotePCService.exe', 'RemotePCUI.exe', 'RemotePCUIU.exe')
        OR tgt.process.displayName contains 'RemotePC'
        OR tgt.process.publisher contains 'IDrive'
        OR tgt.process.publisher contains 'Pro Softnet'