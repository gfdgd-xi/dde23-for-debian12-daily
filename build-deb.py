#!/usr/bin/env python3
import os
import json

def ReadFile(path):
    with open(path, "r") as file:
        things = file.read()
    return things

programPath = os.path.split(os.path.realpath(__file__))[0]  # 返回 string
lists = json.loads(ReadFile(f"{programPath}/build.json"))
for i in lists:
    print(i)
    packageName = os.path.basename(i)
    os.system(f"git clone {i} --depth=1")
    os.system(f"cd '{programPath}/{packageName}' ; sudo apt build-dep . -y")
    os.system(f"cd '{programPath}/{packageName}' ; sudo dpkg-buildpackage -b")