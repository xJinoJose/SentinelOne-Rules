| filter tgt.process.name = 'client32.exe'
        AND (http.uri contains 'fakeurl.htm'
            OR http.userAgent contains 'NetSupport Manager')