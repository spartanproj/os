from os import listdir
from os.path import isfile, join
import sys
location="initrd"
onlyfiles = [f for f in listdir(location) if isfile(join(location, f))]
try:
    with open("initrd.h","w") as initrd:
        for file in onlyfiles:
            filef=file.replace(".","")
            with open(location+"/"+file,"r") as file_contents:
                templist=file_contents.name.split("/")
                tempf=templist[len(templist)-1].replace(".","")
                initrd.write(f"file_t file_{filef} = create_readonly(\"{tempf}\",\"{filef}\");\n")
except Exception as e:
    sys.panic(f" Error from python: {Exception}")
    