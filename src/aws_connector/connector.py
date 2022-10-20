import os
import yaml
import boto
from boto.sts import STSConnection
from aws_connector.account_config import AccountConfig

class Connector:
    def __init__(self):
        self.config = AccountConfig()
        email = self.config.load_config()['email']
        mfa_account_id = str(self.config.load_config()['mfa_account_id'])
        self.mfa_serial = "arn:aws:iam::" + mfa_account_id + ":mfa/" + email

    def assume_role(self, account_name, role):
        mfa_code = input("Enter the MFA code: ")
        account = self.config.get_account(account_name)

        client = self.start_client()
        response = client.assume_role(
            role_arn="arn:aws:iam::" + str(account['id']) + ":role/" + role,
            role_session_name=mfa_code,
            mfa_serial_number=self.mfa_serial,
            mfa_token=mfa_code
        )
        self.set_env_and_switch_shell(response.credentials, account)

    def start_client(self):
        try:
            client = STSConnection()
            return client
        except boto.exception.NoAuthHandlerFound:
            print("Oops, possible configuration issue in .aws/credentials and/or .aws/config")
            print("More information found here: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html")
            exit(1)

    def set_env_and_switch_shell(self, credentials, account):
        shell = os.environ['SHELL']

        os.putenv('AWS_ACCESS_KEY_ID', credentials.__dict__['access_key'])
        os.putenv('AWS_SECRET_ACCESS_KEY', credentials.__dict__['secret_key'])
        os.putenv('AWS_SESSION_TOKEN', credentials.__dict__['session_token'])
        os.putenv('EXPIRATION', credentials.__dict__['expiration'])
        os.putenv('AWS_DEFAULT_REGION', account['default_region'])
        os.putenv('AWS_DEFAULT_OUTPUT', account['default_output'])
        print(f"Switched to {shell} with AWS credentials set for account {account['id']}")
        os.system(shell)
