| filter tgt.process.name in ('Supremo.exe', 'SupremoService.exe', 'SupremoHelper.exe')
        OR tgt.process.displayName contains 'Supremo'
        OR tgt.process.publisher contains 'Nanosystems'