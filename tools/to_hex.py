import sys
if len(sys.argv) > 1:
    the_string = sys.argv[1]
else:
    the_string = input("Provide a string to be converted to hex:\n")

hex_string = ""
for c in the_string:
    hex_string += "\\" + hex(ord(c))[1:]
hex_string += "\\x0d\\x0a"

print(hex_string)