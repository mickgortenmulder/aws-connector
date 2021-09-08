# AWS Connector

This tool provides a AWS CLI connector where you can switch roles to the account you want access to.

# Supported OS
- Linux
- MacOS

# Get started
First start with making sure the generic .aws/config and .aws/credentials are configured so you can access the AWS account where your user lives that can perform assume-role to other accounts. Then install the Python module with pip and then start creating the config that allows you to start connections to assumable roles in AWS accounts.

## AWS config
This connector relies on the AWS config and credential setup to connect with the main account.
Information can be found here: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

## Install
```
pip3 install aws-connector
```

## Generate config
Copy the file config/config_template.yaml to ~/.aws/awsc-config.yaml and fill in the file before you start.

! Note: The configuration is case-sensitive

## Start
```
  awsc
```
