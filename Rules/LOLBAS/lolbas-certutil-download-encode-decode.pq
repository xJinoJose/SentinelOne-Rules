| filter tgt.process.name = 'certutil.exe'
        AND (tgt.process.cmdline contains '-urlcache'
            OR tgt.process.cmdline contains '-verifyctl'
            OR tgt.process.cmdline contains '-decode'
            OR tgt.process.cmdline contains '-encode')