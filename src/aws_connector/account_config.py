import os
from pathlib import Path
import yaml

class AccountConfig:
    def __init__(self):
        self.homedir = os.getenv("HOME")
        self.config_location = f"{self.homedir}/.aws/awsc-config.yaml"

    def load_config(self):
        with open(self.config_location, 'r') as stream:
            try:
                return(yaml.load(stream, Loader=yaml.FullLoader))
            except yaml.YAMLError as exc:
                print(exc)

    def verify_config(self):
        for config_file in self.required_configs():
            try:
                cf = Path(config_file)
                my_abs_path = cf.resolve(strict=True)
            except FileNotFoundError:
                print("Oops, you're missing some configuration.")
                print("More information found here: https://github.com/mickgortenmulder/aws-connector#generate-config")
                exit(1)

    def required_configs(self):
        config_files = []
        config_files.append(f"{self.homedir}/.aws/config")
        config_files.append(f"{self.homedir}/.aws/credentials")
        config_files.append(f"{self.homedir}/.aws/awsc-config.yaml")

        return config_files

    def get_account(self, name):
        return self.load_config()['accounts'][name]

    def get_accounts(self):
        return self.load_config()['accounts'].keys()

    def get_account_roles(self, account):
        return self.load_config()['accounts'][account]['available_roles']
