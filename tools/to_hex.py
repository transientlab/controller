import sys
if len(sys.argv) > 1:
    the_string = sys.argv[1]
else:
    the_string = input("Provide a string to be converted to hex:\n")

# panasonic: %1POWR0 
hex_string = ""
for c in the_string:
    hex_string += "\\" + hex(ord(c))[1:]


# panasonic
# hex_string += "\\x0d\\x0a"

# fn
hex_string += "\\x0d\\x0a"

print(hex_string)