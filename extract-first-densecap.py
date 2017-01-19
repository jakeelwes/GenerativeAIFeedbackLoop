import json
import re


base = open('densecap/vis/data/results.json')

data = base.read()
json = json.loads(data)

first_cap = json['results'][0]['captions'][0]

strCap = str(first_cap)
strCap = re.sub(r"\s+", '_', strCap)

f = open('currentImage/caption.txt', 'r+')
f.write(strCap)
f.truncate()
f.close()
