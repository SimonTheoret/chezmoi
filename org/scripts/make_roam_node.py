#!/usr/bin/env python
import argparse
from pathlib import Path

def make_node(id: str) -> str:
    node = f" :PROPERTIES: \n :ID: {id} \n :END:\n\n"
    return node

def main(file: str)->None:
    with open(file, "r") as f:
        content: list[str] = f.readlines()
        if content is None:
            content = []
        file_name_no_ext: str = str(Path(file).stem)
        node_content: str = make_node(file_name_no_ext)
        content.insert(0, node_content)
    with open(file, "w") as f:
        for line in content:
            f.write(line)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog="MakeRoamNode", description="Simple program to convert a file into a Org-Roam node")
    parser.add_argument("--file","-f", type=str, required=True )
    args = parser.parse_args()
    main(args.file)

