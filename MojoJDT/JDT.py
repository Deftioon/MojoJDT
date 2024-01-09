import sys

def print(string: str) -> None:
    sys.stdout.write(" " * len(str))
    sys.stdout.flush()
    sys.stdout.write(str)