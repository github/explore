
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
from datetime import datetime
from urllib.parse import quote
from html.parser import HTMLParser

if not sys.version_info < (3,):
    unicode = str
    basestring = str


def u(u_string):
    """
    Convert a string to unicode working on both python 2 and 3.
    :param u_string: a string to convert to unicode.
    .. versionadded:: 0.1.5
    """
    if isinstance(u_string, unicode):
        return u_string
    return u_string.decode('utf-8')


def s(s_string):
    """
    Convert a byte stream to string working on both python 2 and 3.
    :param s_string: a byte stream to convert to string.
    .. versionadded:: 0.1.5
    """
    if isinstance(s_string, bytes):
        return s_string
    return s_string.encode('utf-8')


def html_unescape(_string):
    return HTMLParser().unescape(_string)


def escape(_string):
    return quote(u(_string).encode(), safe='~')


def filter_json_index_by_year(json_index_content):
    json_index_filtered = {}
    current_year = int(datetime.now().strftime('%Y'))
    for pid, data in json_index_content.items():
        post_year = int(data['date'].strftime('%Y'))
        if post_year >= (current_year - 2):
            json_index_filtered[pid] = data
    return json_index_filtered
