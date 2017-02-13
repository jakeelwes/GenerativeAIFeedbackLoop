import json
import re
import random

number = random.random()
num = 0


base = open('densecap/vis/data/results.json')
data = base.read()
json = json.loads(data)

def checker(str):
    global num
    global number
    if "cat" in str or "black" in str or "white" in str:
    # if "sign" in str or "elephant" in str or "white" in str or "<UNK>" in str:
        print number
        if number > 0.15 or "<UNK>" in str:
            print("not " + str)
            num = num + 1
            number = random.random()
            first_cap = json['results'][0]['captions'][num]
            return checker(first_cap)
        else:
            # caption = str
            print str
            return str
    else:
        # caption = str
        print str
        return str




first_cap = json['results'][0]['captions'][0]
caption = checker(first_cap)

strCap = str(caption)
strCap = re.sub(r"\s+", '_', strCap)
print strCap


f = open('currentImage/caption.txt', 'r+')
f.write(strCap)
f.truncate()
f.close()
