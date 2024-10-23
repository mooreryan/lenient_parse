import sys

parse_function_name = sys.argv[1]
text = sys.argv[2]
parsed_number = None

if parse_function_name == "float":
    parsed_number = float(text)
elif parse_function_name == "int":
    parsed_number = int(text)
else:
    raise ValueError(f"Unknown parse function: {parse_function_name}")

print(parsed_number, end="")
