| filter tgt.process.cmdline contains 'set /p="PK" >'
        OR (tgt.process.cmdline contains 'Set-Content'
            AND tgt.process.cmdline contains '-Value'
            AND tgt.process.cmdline contains '-Encoding Byte')