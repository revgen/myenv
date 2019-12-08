#!/usr/bin/env python3
""" filetype
The filetype is a command line utility to show file type.

Author: Evgen Rusakov (https://gitjub.com/revgen)
"""
__version__ = '0.2'
__all__ = ['get_file_type', 'FileType']

import argparse
import enum
import pathlib
import sys


class FileType(enum.Enum):
    """Collection of all file types
    """
    DIRECTORY = 'directory'
    VIDEO = 'video'
    AUDIO = 'audio'
    PICTURE = 'picture'
    ICON = 'icon'
    BOOK = 'book'
    DOCUMENT = 'document'
    SPREADSHEET = 'spreadsheet'
    PRESENTATION = 'presencation'
    EMAIL = 'email'
    CODE = 'code'
    SHELL = 'shell'
    WEB = 'web'
    FONT = 'FONT'
    CONFIG = 'config'
    DB = 'db'
    BACKUP = 'backup'
    ARCHIVE = 'archive'
    PACKAGE = 'package'
    BINNARY = 'binnary'
    HASH = 'hash'
    CRYPT = 'crypt'
    TEXT = 'text'
    DISK = 'disk'
    GOOGLE = 'google'
    PLAYLIST = 'playlist'
    UNKNOWN = 'unknown'


FILE_EXT_TO_TYPE = {
    'avi': FileType.VIDEO, 'mov': FileType.VIDEO, 'mpg': FileType.VIDEO,
    'mp4': FileType.VIDEO, 'webm': FileType.VIDEO, 'wmv': FileType.VIDEO, 'flv': FileType.VIDEO,
    'mp3': FileType.AUDIO, 'wav': FileType.AUDIO, 'snd': FileType.AUDIO, 'ogg': FileType.AUDIO,
    'png': FileType.PICTURE, 'tiff': FileType.PICTURE, 'webp': FileType.PICTURE,
    'bmp': FileType.PICTURE, 'gif': FileType.PICTURE, 'jpeg': FileType.PICTURE,
    'jpg': FileType.PICTURE, 'svg': FileType.PICTURE, 'svgz': FileType.PICTURE,
    'ico': FileType.ICON, 'icns': FileType.ICON,
    'mobi': FileType.BOOK, 'epub': FileType.BOOK, 'fb2': FileType.BOOK,
    'doc': FileType.DOCUMENT, 'docx': FileType.DOCUMENT, 'dot': FileType.DOCUMENT, 'dotx': FileType.DOCUMENT,
    'odt': FileType.DOCUMENT, 'rtf': FileType.DOCUMENT, 'pdf': FileType.DOCUMENT, 'djvu': FileType.DOCUMENT,
    'wpd': FileType.DOCUMENT, 'pages': FileType.DOCUMENT,
    'xls': FileType.SPREADSHEET, 'xlsx': FileType.SPREADSHEET, 'xlsm': FileType.SPREADSHEET,
    'xlb': FileType.SPREADSHEET, 'ods': FileType.SPREADSHEET, 'numbers': FileType.SPREADSHEET,
    'ppt': FileType.PRESENTATION, 'pptx': FileType.PRESENTATION, 'pot': FileType.PRESENTATION,
    'pps': FileType.PRESENTATION, 'odp': FileType.SPREADSHEET,
    'eml': FileType.EMAIL, 'msg': FileType.EMAIL,
    'js': FileType.CODE, 'ejs': FileType.CODE, 'mjs': FileType.CODE, 'py': FileType.CODE, 'pyc': FileType.CODE,
    'rb': FileType.CODE, 'tcl': FileType.CODE, 'php': FileType.CODE, 'c': FileType.CODE, 'cpp': FileType.CODE,
    'd': FileType.CODE, 'xslt': FileType.CODE, 'cs': FileType.CODE, 'java': FileType.CODE, 'jsx': FileType.CODE,
    'h': FileType.CODE, 'sql': FileType.CODE, 'wsf': FileType.CODE, 'less': FileType.CODE, 'sass': FileType.CODE,
    'scss': FileType.CODE, 'pl': FileType.CODE, 'vb': FileType.CODE, 'swift': FileType.CODE,
    'gradle': FileType.CODE, 'groovy': FileType.CODE, 'jsp': FileType.CODE, 'xsl': FileType.CODE,
    'scala': FileType.CODE, 'script': FileType.CODE, 'wasm': FileType.CODE, 'json': FileType.CODE,
    'csv': FileType.CODE, 'xml': FileType.CODE, 'yaml': FileType.CODE, 'yml': FileType.CODE,
    'sh': FileType.SHELL, 'bash': FileType.SHELL, 'bat': FileType.SHELL, 'cmd': FileType.SHELL,
    'ps1': FileType.SHELL,
    'fnt': FileType.FONT, 'fon': FileType.FONT, 'otf': FileType.FONT, 'ttf': FileType.FONT, 'woff': FileType.FONT,
    'woff2': FileType.FONT,
    'bak': FileType.BACKUP, 'backup': FileType.BACKUP,
    'cfg': FileType.AUDIO, 'conf': FileType.AUDIO, 'config': FileType.AUDIO,
    'ini': FileType.AUDIO, 'setting': FileType.AUDIO, 'property': FileType.AUDIO,
    'md5': FileType.HASH, 'hash': FileType.HASH, 'sha': FileType.HASH,
    'sha1': FileType.HASH, 'sha256': FileType.HASH, 'sha512': FileType.HASH,
    'bin': FileType.BINNARY, 'cgi': FileType.BINNARY, 'dll': FileType.BINNARY, 'exe': FileType.BINNARY,
    'log': FileType.TEXT, 'txt': FileType.TEXT, 'nfo': FileType.TEXT, 'asc': FileType.TEXT,
    'crt': FileType.CRYPT, 'cer': FileType.CRYPT, 'ptx': FileType.CRYPT, 'aes': FileType.CRYPT,
    'crypt': FileType.CRYPT, 'enc': FileType.CRYPT, 'gpg': FileType.CRYPT,
    'apk': FileType.PACKAGE, 'jar': FileType.PACKAGE, 'rpm': FileType.PACKAGE, 'deb': FileType.PACKAGE,
    'msi': FileType.PACKAGE, 'pkg': FileType.PACKAGE, 'iso': FileType.PACKAGE, 'pack': FileType.PACKAGE,
    'snap': FileType.PACKAGE,
    'zip': FileType.ARCHIVE, 'tar': FileType.ARCHIVE, 'gz': FileType.ARCHIVE, 'tgz': FileType.ARCHIVE,
    'bz2': FileType.ARCHIVE, 'cab': FileType.ARCHIVE, '7z': FileType.ARCHIVE, 'rar': FileType.ARCHIVE,
    'archive': FileType.ARCHIVE,
    'db': FileType.DB, 'mdb': FileType.DB, 'dbf': FileType.DB, 'sqlite': FileType.DB, 'sqkite3': FileType.DB,
    'html': FileType.WEB, 'htm': FileType.WEB, 'xhtml': FileType.WEB, 'mhtml': FileType.WEB,
    'shtml': FileType.WEB, 'css': FileType.WEB, 'md': FileType.WEB, 'markdown': FileType.WEB,
    'rss': FileType.WEB, 'atom': FileType.WEB, 'swf': FileType.WEB, 'url': FileType.WEB,
    'img': FileType.DISK, 'gb': FileType.DISK, 'gba': FileType.DISK, 'sfc': FileType.DISK, 'smc': FileType.DISK,
    'rom': FileType.DISK, 'sness': FileType.DISK, 'nes': FileType.DISK,
    'gsheet': FileType.GOOGLE, 'gsite': FileType.GOOGLE, 'gdoc': FileType.GOOGLE, 'gmap': FileType.GOOGLE,
    'gform': FileType.GOOGLE,
    'm3u': FileType.PLAYLIST, 'm3u8': FileType.PLAYLIST, 'pls': FileType.PLAYLIST,
}


def get_file_type(file_path: pathlib.Path, file_ext_to_types: dict = None) -> FileType:
    """Return file type by file extension
    Arguments:
    file_path -- pathlib.Path: path file name full or relative (required)
    file_ext_to_types -- dictionary with file_extension to file_type mapping
    """
    if file_path.is_dir():
        return FileType.DIRECTORY
    return (file_ext_to_types or FILE_EXT_TO_TYPE).get((file_path.suffix or '').strip('.'), None)


def cli() -> int:
    """Process command line interface for the script
    """
    parser = argparse.ArgumentParser(usage='%(prog)s [OPTION] [FILE]...',
                                     description='Utility to show file type')
    parser.add_argument('--simple', '-s', help='show type only', action='store_true', default=False)
    parser.add_argument('files', nargs='*')
    args = parser.parse_args()
    if args.files:
        for raw_file_path in args.files:
            file_type = get_file_type(pathlib.Path(raw_file_path)) or FileType.UNKNOWN
            if args.simple:
                print(file_type.name)
            else:
                print(f'{file_type.name:12}: {raw_file_path}')
        return 0
    parser.print_help()
    return 1


if __name__ == '__main__':
    sys.exit(cli())
