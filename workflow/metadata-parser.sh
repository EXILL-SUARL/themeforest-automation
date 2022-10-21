#!/usr/bin/python3

# Parse provided JSON files and combine them (usually for later use).

import sys
import os
import json
from slugify import slugify

if len(sys.argv) == 1:
  sys.exit(f'Please specify a path. \nusage: {sys.argv[0]} <target_json_files_seperated_by_space>')

sys.argv.pop(0)

data = {}

for file_path in sys.argv:
  if not os.path.exists(file_path):
    sys.exit(f'{file_path} does not exist')
  with open(file_path) as file:
    file_content = file.read()
    parsed_file = json.loads(file_content)
    stripped_filename = slugify(file_path, entities=True, decimal=False, hexadecimal=False, max_length=0,
      word_boundary=False, separator='_', save_order=False, stopwords=(), regex_pattern=None, lowercase=True, replacements=())
    data[stripped_filename] = parsed_file

print(json.dumps(data))
