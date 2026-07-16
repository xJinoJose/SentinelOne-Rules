| filter tgt.process.name = 'msedge.exe'
        AND tgt.process.cmdline contains '--load-extension='
        AND tgt.process.cmdline contains 'headless=new'
| group count() by endpoint.name, user.name
| sort count desc