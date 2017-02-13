import os
from collections import Counter
import re

s = ""

for file in os.listdir("web-interface/genImages"):
    if file.endswith(".txt"):
        with open("web-interface/genImages/" + file) as txt:
            # print(txt.read())
            s+=str(txt.read())

words = re.findall(r'\w+', s)
word_counts = Counter(words) #counts the number each time a word appears

print(word_counts.most_common(20))
