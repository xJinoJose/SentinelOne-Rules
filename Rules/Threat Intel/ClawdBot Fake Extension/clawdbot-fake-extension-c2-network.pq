| filter (event.type = 'DNS Request'
        AND dns.request in ('clawdbot.getintwopc.site', 'darkgptprivate.com', 'bulletmailer.net', 'meeting.bulletmailer.net'))
        OR (event.type = 'IP Connect' and dst.ip.address = '179.43.176.32')