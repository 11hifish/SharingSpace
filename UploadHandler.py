from __future__ import print_function

import dropbox
import argparse
import contextlib
import datetime
import os
import six
import sys
import time
import unicodedata

def upload(dbx, name):
    """Upload a file.
    Return the request response, or None in case of error.
    """
    ## name : name of file
    ## dropboxFolder : the target folder in dropbox
    fullname = "./{}".format(name)
    dropboxFolder = "{DROPBOX FOLDERNAME}"
    path = '/{}/{}'.format(dropboxFolder, name)
    mtime = os.path.getmtime(fullname)
    with open(fullname, 'rb') as f:
        data = f.read()
    with stopwatch('upload %d bytes' % len(data)):
        try:
            res = dbx.files_upload(
                data, path,
                client_modified=datetime.datetime(*time.gmtime(mtime)[:6]),
                mute=True)
        except dropbox.exceptions.ApiError as err:
            print('*** API error', err)
            return None
    print('uploaded as', res.name.encode('utf8'))
    return res

@contextlib.contextmanager
def stopwatch(message):
    """Context manager to print how long a block of code took."""
    t0 = time.time()
    try:
        yield
    finally:
        t1 = time.time()
        print('Total elapsed time for %s: %.3f' % (message, t1 - t0))

