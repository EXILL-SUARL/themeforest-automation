#!/pyenv/versions/3.11.0/bin/python3

# Similar to .gitignore except it will delete matching glob paths.

import sys
import os
import glob
import shutil
from pathlib import Path

ignore_file = None

if len(sys.argv) == 1:
  sys.exit(f'Please specify a path. \nusage: {sys.argv[0]} <target_globfile>')
else:
  ignore_file = os.path.abspath(sys.argv[1])

cwd = Path(ignore_file).parent.absolute()

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
    for filePath in glob.glob(line.strip(), root_dir=cwd, recursive=True):
      remove(os.path.join(cwd, filePath))
      print(f'Successfully deleted {line.strip()} (if it existed)')
file.close()
