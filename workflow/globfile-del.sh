#!/usr/bin/python3

# Similar to .gitignore except it will delete the glob paths that match against the working directory.

import sys
import os
import glob
import shutil

ignore_file = None

if len(sys.argv) == 1:
  sys.exit('Please specify a path.')
else:
  ignore_file = sys.argv[1]

if not os.path.exists(ignore_file):
  sys.exit('The path specified does not exist')

def remove(path):
  if os.path.isfile(path) or os.path.islink(path):
    try:
      os.remove(path)
    except:
      raise
  elif os.path.isdir(path):
    try:
      shutil.rmtree(path)
    except:
      raise
  else:
    raise ValueError("file {} is not a file or dir.".format(path))

file = open(ignore_file, 'r')
for line in file:
  if not line.isspace() and not line.startswith('#'):
    for filePath in glob.glob(line.strip(), recursive=True):
      remove(filePath)
      print(f'Successfully deleted {line.strip()} (if it existed)')
file.close()
