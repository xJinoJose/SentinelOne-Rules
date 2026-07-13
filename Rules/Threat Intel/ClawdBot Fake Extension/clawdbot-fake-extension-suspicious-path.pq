| filter event.type = 'Process Creation'
        AND tgt.process.name = 'Code.exe'
        AND tgt.process.imagePath contains 'Lightshot'