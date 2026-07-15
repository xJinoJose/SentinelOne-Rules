| filter registry.keyPath contains 'RunMRU'
| filter registry.value contains 'powershell'
        OR registry.value contains 'mshta'
        OR registry.value contains 'wscript'
        OR registry.value contains 'curl'
        OR registry.value contains 'rundll32'
        OR registry.value contains 'wget'
| group count() by endpoint.name, user.name