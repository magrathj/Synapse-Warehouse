import urllib.request, json

# Set GitHub URL
url = 'https://raw.githubusercontent.com/cwilliams87/Blog/main/07-2021/sampleEmployees'

import urllib.request, json 
with urllib.request.urlopen(url) as _url:
    data = json.load(_url)

# Serializing json
json_object = json.dumps(data, indent=4)

# Writing to sample.json
with open("infrastructure/tf/data/Employee.json", "w") as outfile:
    outfile.write(json_object)
