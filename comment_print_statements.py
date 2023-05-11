#! /usr/bin/env python3

import sys
import argparse
import os
from pathlib import Path

FILE_TYPES = [".dart", ".py", ".cpp", ".c"] # list of supported file types to inspect.  you can change this if needed.
KEYS = ["import 'dart:developer';", "log(", "print("] # keys that lines must begin with for a line to be toggled (must begin with = ignoring whitespace, SELF_KEY, and comments.  you can change this if needed.
# if a keys file is provided, it should be plaintext, 1 key per line.
COMMENT_KEY = "//" # key signaling the beginning of a comment.  you can change this if needed.
SELF_KEY = "cec339cd" # last 8 chars of whirlpool hash of "log toggled by loggle.py".  SELF_KEY is used to identify lines that have been toggled by loggle.py.  you can change this if needed.  ideally it should be a short, unique string to avoid false matches and maintain readability.  NOTE: after running this script in disable mode, if you remove this tag from a line it will not be found by this script and will not be re-enabled.
TARGETS = [] # target files to operate on.
HITS = set() # used for collecting the filenames of files containing at least one instance of a key in KEYS.



def getErrorMsgParsingTargets(path):
    return "\ngot an error while walking directory:\n" + path


def make_file_types_lc():
    global FILE_TYPES
    for i in range(len(FILE_TYPES)):
        FILE_TYPES[i] = FILE_TYPES[i].lower()


def parse_keys(fn):
    """
    Read in and set the KEYS listed in the keys file if a keys file is provided.
    """
    global KEYS
    data = []
    with open(fn) as in_file:
        for line in in_file:
            l = line.strip()
            if l and not l.isspace():
                data.append(l)
    if data:
        KEYS = data


def parse_targets(fns):
    """
    Set TARGETS to the (absolute file paths) of the list of files provided and any files found recursively in any directories provided.
    """
    global TARGETS
    for f in fns:
        path = os.path.abspath(f)
        if os.path.isfile(path):
            for ext in FILE_TYPES:
                if path.lower().endswith(ext):
                    TARGETS.append(path)
                    break
        elif os.path.isdir(path):
            # subfiles = [os.path.join(dp, f) for dp, dn, filenames in os.walk(path) for f in filenames for ext in FILE_TYPES if f.lower().endswith(ext)]
            subfiles = []
            try:
                for root, dirs, files in os.walk(path):
                    for f in files:
                        for ext in FILE_TYPES:
                            if f.lower().endswith(ext):
                                subfiles.append(os.path.join(root, f))
                                break
                TARGETS.extend(subfiles)
            except:
                print(getErrorMsgParsingTargets(path))


def read_file(fn):
    data = []
    with open(fn) as in_file:
        for line in in_file:
            data.append(line)
    return data


def write_file(fn, data):
    with open(fn, "w") as out_file:
        for line in data:
            out_file.write(line)


def enable_file(fn):
    global HITS
    data = read_file(fn)
    new_data = []
    for line in data:
        if SELF_KEY in line:
            HITS.add(fn)
            try:
                first, second = line.split(COMMENT_KEY + " " + SELF_KEY + " ", 1)
                new_data.append(first + second)
            except:
                new_data.append(line)
                print("failed while splitting line for SELF_KEY: " + SELF_KEY + " in file: " + fn)
                pass
        else:
            new_data.append(line)
    write_file(fn, new_data)


def enable(fns):
    for f in fns:
        enable_file(f)


def disable_file(fn):
    global HITS
    data = read_file(fn)
    new_data = []
    for line in data:
        strip_line = line.strip()
        new_line = line
        for k in KEYS:
            if strip_line.startswith(k):
                HITS.add(fn)
                try:
                    before, after = line.split(k, 1)
                    new_line = before + COMMENT_KEY + " " + SELF_KEY + " " + k + after
                except:
                    new_line = line
                    print("failed while splitting line for key: " + k + " in file: " + fn)
                    pass
                break
        new_data.append(new_line)
    write_file(fn, new_data)


def disable(fns):
    for f in fns:
        disable_file(f)


def do_report(enabled):
    if HITS:
        if enabled:
            print("\nEnabled all instances of:\n")
        else:
            print("\nDisabled all instances of:\n")
        print(KEYS)
        print("\nfound in these files:\n")
        print(HITS)
    else:
        print("\nFound no instances of:\n")
        print(KEYS)
        print("\nin target files -- Nothing to do!\n")


def main(argv):
    make_file_types_lc() # make file types lowercase in case user added uppercase
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("-e", "--enable", action="store_true", help="enable logging statements")
    group.add_argument("-d", "--disable", action="store_true", help="disable logging statements")
    parser.add_argument("-k", "--keys", help="specify a keys file containing strings that should be toggled in code")
    parser.add_argument("-t", "--targets", nargs="+", help="files / directories to act on", required=True)
    args = parser.parse_args()

    if args.keys:
        parse_keys(args.keys)
    parse_targets(args.targets)

    if(args.enable):
        enable(TARGETS)
    else:
        disable(TARGETS)
    do_report(args.enable)


if __name__ == "__main__":
    main(sys.argv[1:])
