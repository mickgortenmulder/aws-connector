import os

class Version():
    def __init__(self):
        self.version = os.system("grep version pyproject.toml | awk '{print $3}'")
