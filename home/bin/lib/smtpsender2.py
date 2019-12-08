#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# =============================================================================
# Simle tool to send email message using SMTP server.
# Usage: smtpsender --help
# =============================================================================
import argparse
import os
import smtplib
import sys
import textwrap

APP_DESCRIPTION = textwrap.dedent('''\
Simle console tool to send email message using SMTP server.
Copyright © 2018 Evgen Rusakov''')

APP_SYSTEM_ENV = textwrap.dedent('''\
System environment:
  SMTP_SERVER, SMTP_PORT, SMTP_STARTTLS, SMTP_USERNAME, SMTP_PASSWORD,
  SMTP_DEBUG, SENDER, RECEPIENT, SUBJECT''')


class DefEnv(argparse.Action):
    def __init__(self, env, required=True, default=None, **kwargs):
        if not default and env and env in os.environ:
            default = os.environ[env]
        if required and default:
            required = False
        super(DefEnv, self).__init__(default=default, required=required,
                                     **kwargs)

    def __call__(self, parser, namespace, values, option_string=None):
        setattr(namespace, self.dest, values)

    @staticmethod
    def env_to_bool(name):
        return os.environ.get(name, 'false').lower() in ['true', 'yes', 'on']


class SmtpSender:
    DEF_TIMEOUT = 10

    def __init__(self):
        if DefEnv.env_to_bool('SMTP_DEBUG') or DefEnv.env_to_bool('DEBUG'):
            self.debug = lambda m: print(m)
        else:
            self.debug = lambda m: m
        self.info = lambda m: print(m)
        self.args = self._get_parameters()
        if self.args.debug:
            self.debug = lambda m: print(m)

    def _get_parameters(self):
        self.debug('Get parameters from cli arguments and system environments')
        parser = argparse.ArgumentParser(
            formatter_class=argparse.RawDescriptionHelpFormatter,
            description=APP_DESCRIPTION,
            epilog=APP_SYSTEM_ENV)
        parser.add_argument('-S', '--server', action=DefEnv, required=True,
                            env='SMTP_SERVER', help='smtp server host name',
                            default='email-smtp.us-east-1.amazonaws.com')
        parser.add_argument('-P', '--port', action=DefEnv, env='SMTP_PORT',
                            required=True, help='smtp server port number',
                            default=587)
        parser.add_argument('-u', '--username', action=DefEnv, required=False,
                            env='SMTP_USERNAME', default='',
                            help='username for ESMTP authentication')
        parser.add_argument('-p', '--password', action=DefEnv, required=False,
                            env='SMTP_PASSWORD', default='',
                            help='password for ESMTP authentication')
        parser.add_argument('-t', '--recepient', action=DefEnv, required=True,
                            env='RECEPIENT',
                            help='email address of the recipient/s')
        parser.add_argument('-b', '--bcc', action=DefEnv, required=False,
                            env='BCC',
                            help='email address of the hidden recipient/s')
        parser.add_argument('-f', '--sender', action=DefEnv, required=True,
                            env='SENDER', help='email address of the sender')
        parser.add_argument('-s', '--subject', action=DefEnv, required=True,
                            env='SUBJECT', help='message subject')
        parser.add_argument('--starttls', action='store_true', required=False,
                            help='use STARTTLS if the server supports it',
                            default=DefEnv.env_to_bool('SMTP_STARTTLS'))
        parser.add_argument('--debug', action='store_true', required=False,
                            help='show verbose information',
                            default=DefEnv.env_to_bool('SMTP_DEBUG'))
        parser.add_argument('body', help='message body', nargs='*')
        args = parser.parse_args()
        if args.body:
            args.body = args.body[0]
        else:
            self.info('Read message body from stdin (Ctrl+D to end input):')
            args.body = sys.stdin.read()
        return args

    def send(self):
        args = self.args
        msg = os.linesep.join([
            "From: " + args.sender,
            "To: " + args.recepient,
            "Subject: " + args.subject,
            "",
            args.body
        ])
        self.info('Sending message to {0}: {1} (length={2})'
                  .format(args.recepient, args.subject, len(msg)))
        self.debug('Create client to {0}:{1}'.format(args.server, args.port))
        server = smtplib.SMTP(host=args.server, port=args.port,
                              timeout=SmtpSender.DEF_TIMEOUT)
        server.set_debuglevel(2 if args.debug else 0)
        if args.starttls:
            self.debug('Using TLS')
            # stmplib docs recommend calling ehlo() before & after starttls()
            server.ehlo()
            server.starttls()
        server.ehlo()
        if args.starttls:
            if not args.username or not args.password:
                raise ValueError('Username and password are required.')
            self.debug('Credentials: {0}/*****'.format(args.username))
            self.debug('Pssword: {0}'.format(args.password))
            server.login(args.username or '', args.password or '')
        to_addrs = [a.strip() for a in (args.recepient or '').split(',')] \
                   + [a.strip() for a in (args.bcc or '').split(',')]
        server.sendmail(args.sender, to_addrs, msg)
        self.info('Send message to {0}: {1} (length={2}) - success'
                  .format(args.recepient, args.subject, len(msg)))
        res = server.quit()
        self.debug('Server response: {0}'.format(res))


if __name__ == '__main__':
    SmtpSender().send()
