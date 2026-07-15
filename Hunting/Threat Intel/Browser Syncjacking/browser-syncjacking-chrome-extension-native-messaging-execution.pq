| filter src.process.cmdline contains 'chrome-extension://'
        AND tgt.process.name NOT IN ('chrome.exe', 'msedge.exe', 'brave.exe', 'opera.exe')