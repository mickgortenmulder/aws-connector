import os
import yaml

class AccountConfig:
    def __init__(self):
        homedir = os.getenv("HOME")
        self.config_location = f"{homedir}/.aws/aws-connector/config.yaml"

    def load_config(self):
        with open(self.config_location, 'r') as stream:
            try:
                return(yaml.load(stream, Loader=yaml.FullLoader))
            except yaml.YAMLError as exc:
                print(exc)

    def verify_config(self):
        os.path.isfile("/users/mickgortenmulder/.aws/config")
        os.path.isfile("/users/mickgortenmulder/.aws/credentials")

    def get_account(self, name):
        return self.load_config()['accounts'][name]

    def get_accounts(self):
        return self.load_config()['accounts'].keys()

    def get_account_roles(self, account):
        return self.load_config()['accounts'][account]['available_roles']
