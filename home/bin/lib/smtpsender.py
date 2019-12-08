#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import json
import os
import smtplib
import sys


def show_help():
    print('Small utility to send email using an smtpserver.')
    print('')
    print('Usage: smtpsender <recepient> <subject> [body]')
    print('')
    print('Configuration:')
    print('  This utility will load configuration file from:')
    print('    /etc/smtpsender.json')
    print('    ~/.smtpsender.json')
    print('')
    print(' To see a default configuration use a command:')
    print('    smtpsender default-config')
    print('')
    print(' You can use a system envuronemnt variables to configure:')
    print('    SMTP_SERVER      - server name with/without port')
    print('    SMTP_USERNAME    - username for authentication')
    print('    SMTP_PASSWORD    - password for authentication')
    print('    SMTP_TLS         - true/false')
    print('    SMTP_SENDER      - from which addresss an email will be send')
    print('    SMTP_BCC         - email address for bcc field')
    print('    SMTP_TIMEOUT     - timeout in seconds for connection (defailt: 10 sec)')
    print('')
    print('Copyright (c) 2018 Evgen Rusakov (https://github.com/revgen)')
    print('')
    print('The MIT License')
    print('')
    print('Permission is hereby granted, free of charge, to any person obtaining a copy')
    print('of this software and associated documentation files (the "Software"), to deal')
    print('in the Software without restriction, including without limitation the rights')
    print('to use, copy, modify, merge, publish, distribute, sublicense, and/or sell')
    print('copies of the Software, and to permit persons to whom the Software is')
    print('furnished to do so, subject to the following conditions:')
    print('')
    print('The above copyright notice and this permission notice shall be included in all')
    print('copies or substantial portions of the Software.')
    print('')
    print('THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR')
    print('IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,')
    print('FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE')
    print('AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER')
    print('LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,')
    print('OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE')
    print('SOFTWARE.')


class SmtpSender:
    DEF_TIMEOUT = 10

    def __init__(self, server=None, sender=None, username=None, password=None,
                 use_tls=False, debug=False):
        self.is_debug = debug or os.environ.get('SMTP_DEBUG') == 'true'
        cfg = self._load_config()

        self.smtp_server = server or cfg.get('server') or os.environ.get('SMTP_SERVER')
        self.username = username or cfg.get('username') or os.environ.get('SMTP_USERNAME')
        self.password = password or cfg.get('password') or os.environ.get('SMTP_PASSWORD')
        self.use_tls = use_tls or (cfg.get('tls') or os.environ.get('SMTP_TLS') == 'true')
        self.sender = sender or cfg.get('sender') or os.environ.get('SMTP_SENDER') or ''
        self.recepient = cfg.get('recepient') or os.environ.get('SMTP_RECEPIENT') or ''
        self.bcc = cfg.get('bcc') or os.environ.get('SMTP_BCC') or ''
        self.timeout = int(cfg.get('timeout') or os.environ.get('SMTP_TIMEOUT') or SmtpSender.DEF_TIMEOUT)

    def _load_config(self):
        config_files = ['/etc/smtpsender.json',
                        os.path.join(os.environ['HOME'], '.smtpsender.json')]
        values = {}
        for cfg_file in config_files:
            if os.path.exists(cfg_file):
                self.debug('Load config file: {0}'.format(cfg_file))
                values.update(json.load(open(cfg_file)))
            else:
                self.debug('Config file "{0}" not found. Skip.'.format(cfg_file))
        return values

    def debug(self, message):
        if self.is_debug:
            sys.stderr.write(message)
            sys.stderr.write(os.linesep)

    def send(self, recepient, subject, body=None):
        (host, port, _) = (self.smtp_server + '::').split(':')[0:3]
        port = int(port or 25)
        if not body:
            print('Read message body from stdin (Ctrl+D to end input):')
            body = sys.stdin.read()

        if not recepient:
            recepient = self.recepient

        msg = os.linesep.join([
            "From: " + self.sender,
            "To: " + recepient,
            "Subject: " + subject,
            "",
            body
        ])
        self.debug('Sending message to {0}: {1} (length={2})'
                   .format(recepient, subject, len(msg)))
        self.debug('Create client to {0}:{1}'.format(host, port))
        server = smtplib.SMTP(host, port, timeout=self.timeout)
        server.set_debuglevel(2 if self.is_debug else 0)
        server.ehlo()
        if self.use_tls:
            self.debug('Using TLS')
            # stmplib docs recommend calling ehlo() before & after starttls()
            server.starttls()
            server.ehlo()
            if not self.username or not self.password:
                raise ValueError('Username and password are required.')
            self.debug('Credentials: {0}/*****'.format(self.username))
            self.debug('Pssword: {0}'.format(self.password))
            server.login(self.username or '', self.password or '')
        # Field TO: recepients + bcc (remove spaces and empty items)
        to_addrs = recepient.split(',') + self.bcc.split(',')
        to_addrs = [b for b in [a.strip() for a in to_addrs] if b]
        server.sendmail(self.sender, to_addrs, msg)
        print('Send message to {0}: {1} (length={2}) - success'
              .format(recepient, subject, len(msg)))
        res = server.quit()
        self.debug('Server response: {0}'.format(res))


if __name__ == '__main__':
    if len(sys.argv) <= 1 or sys.argv[1] in ['--help', 'help']:
        show_help()
    elif sys.argv[1] == 'default-config':
        def_config = {
            'server': 'email-smtp.us-east-1.amazonaws.com:587',
            'username': '<change me with your AWS SES username>',
            'password': '<change me with your AWS SES password>',
            'tls': True,
            'sender': '<change me with your sender email adddress>'
        }
        print('{0}'.format(json.dumps(def_config, indent=2)))
    else:
        body = sys.argv[3] if len(sys.argv) > 3 else None
        SmtpSender().send(sys.argv[1], sys.argv[2], body)

