#!/usr/bin/env python3
""" fileinfo
The fileinfo is a command line utility  to show information about a file.
Usage: fileinfo <path> [--minimized]

Author: Evgen Rusakov (https://gitjub.com/revgen)
"""
__version__ = '0.1'
__all__ = ['FileInfo']

import argparse
import datetime
import enum
import json
import mimetypes
import os
import pathlib
import sys
from filetype import FileType, get_file_type
from mediainfo import get_media_info


MIME_TYPES = mimetypes.MimeTypes()


class FileInfo():
    """ Contains informatin about a specific file
    """
    # pylint: disable=too-many-instance-attributes
    def __init__(self, file_path: pathlib.Path, root_path: pathlib.Path = None):
        # print(f'Real path: {file_path}{os.linesep}Relative : {root_path}')
        self.path = file_path.relative_to(root_path) if root_path else file_path
        self.name = file_path.name
        if file_path.is_dir():
            self.type = FileType.DIRECTORY
        else:
            self.ext = (file_path.suffix or '').lower().strip('.')
            self.mimetype = MIME_TYPES.guess_type(file_path)[0]
            self.type = get_file_type(file_path)

        stat = file_path.stat()
        self.size = stat.st_size if not file_path.is_dir() else 0
        if self.size > 0:
            self.size_fmt = FileInfo._get_size_fmt(self.size)
        self.created = datetime.datetime.fromtimestamp(int(stat.st_ctime))
        self.updated = datetime.datetime.fromtimestamp(int(stat.st_mtime))
        for field in (get_media_info(self) or {}).items():
            setattr(self, field[0], field[1])

    def __str__(self):
        return self.to_json(True)

    def to_json(self, minimized: bool = False):
        """ Serialize object to JSON format
        """
        return json.dumps(self.__dict__, indent=None if minimized else 2,
                          default=FileInfo._obj_to_json, ensure_ascii=False)

    @staticmethod
    def _get_size_fmt(size_bytes):
        suffixes = ['B', 'KB', 'MB', 'GB', 'TB']
        idx = 0
        while size_bytes > 1024 and idx < len(suffixes):
            size_bytes = size_bytes / 1024
            idx += 1
        return f'{int(round(size_bytes, 0))}{suffixes[idx]}'

    @staticmethod
    def _obj_to_json(obj):
        """ Serialize simple object to the JSON format
        """
        if isinstance(obj, (datetime.datetime, datetime.date)):
            return obj.isoformat()
        if isinstance(obj, (pathlib.PosixPath)):
            return str(obj)
        if isinstance(obj, (enum.Enum)):
            return obj.name.lower()
        return obj

    @staticmethod
    def cli() -> int:
        """ Process command line interface for the script
        """
        try:
            parser = argparse.ArgumentParser(usage='%(prog)s [OPTION] [FILE]...',
                                             description='Utility to show information about a file.')
            parser.add_argument('--minimized', help='minimized json output', action='store_true', default=False)
            parser.add_argument('--relative', help='relative path', default=None)
            parser.add_argument('files', nargs='*')
            args = parser.parse_args()
            relative_path = pathlib.Path(args.relative).resolve() if args.relative else None
            if args.files:
                for raw_file_path in args.files:
                    file_info = FileInfo(pathlib.Path(raw_file_path).resolve(), relative_path)
                    print(file_info.to_json(args.minimized))
                return 0
            parser.print_help()
        except FileNotFoundError as ex:
            sys.stderr.write(f'{ex}{os.linesep}')
        except ValueError as ex:
            sys.stderr.write(f'{ex}{os.linesep}')
        return 1


if __name__ == '__main__':
    sys.exit(FileInfo.cli())
