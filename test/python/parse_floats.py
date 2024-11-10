import json
import sys

json_data = sys.argv[1]
data_list = json.loads(json_data)
output_values = []

for item in data_list:
    text = item["input"]

    try:
        value = float(text)
    except ValueError:
        value = "ValueError"

    output_values.append(str(value))

json_output = json.dumps(output_values)

print(json_output, end="")
