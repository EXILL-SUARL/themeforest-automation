#!/usr/bin/python3

import sys
import os
import glob
import shutil

ignore_file = sys.argv[1]

if not os.path.exists(ignore_file):
    print('The path specified does not exist')
    sys.exit()

file = open(ignore_file, 'r')
for line in file:
  if not line.isspace() and not line.startswith('#'):
      # print(line.strip())
      for filePath in glob.glob(line.strip(), recursive=True):
        try:
          shutil.rmtree(filePath)
        except:
          print('Something went wrong.')
file.close()
