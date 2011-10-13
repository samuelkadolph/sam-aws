# sam-ses-cli

sam-ses-cli includes an executable, called ses, for interacting with Amazon's Simple Email Service.

## Description

DESC

## Usage

```
Tasks:
  ses delete-verified-email-address ADDRESS                     # Deletes a verified email address
  ses get-send-quota                                            # Prints current sending limits
  ses get-send-statistics                                       # Pints sending statistics over the last two weeks
  ses help [TASK]                                               # Describe available tasks or one specific task
  ses list-verified-email-addresses                             # Lists verified email addresses
  ses send-email SOURCE SUBJECT BODY -t, --to=EMAIL [EMAIL...]  # Sends an email
  ses send-raw-email [RAW|FILE]                                 # Sends a raw email (will read from stdin if no argument is given)
  ses verify-email-address ADDRESS                              # Verifies an email address
  ses version                                                   # Prints the version of sam-aws

Options:
  -D, [--debug]                  # Enables debugging mode
  -V, [--verbose]                # Enables verbose mode
  -A, [--access-key=KEY]         # Specify the AWS access key to use
  -S, [--secret-key=KEY]         # Specify the AWS secret key to use
  -C, [--credentials-file=FILE]  # Override the path to the credentials file
                                 # Default: ~/.aws-credentials
```
