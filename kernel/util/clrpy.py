import string

for letter in list(string.ascii_lowercase):
    print(f"""class class{letter}:
    def __init__(self):
        self.name=\"{letter}\"
        self.upper=\"{letter}\"""")
    for x in ["blue","green","magenta","lilac","orange","red","cyan","white"]:
        print(f"""    def {x}(self):
        print(f\"setclr({x.upper() if x!="orange" else "LIGHT_RED"},0);printf(\\\"{letter}\\\");\")""")
    print(f"{letter}=class{letter}()")
xy="\\\"\\\\n\\\""
print(f"def nl():print(\"printf({xy});\")")