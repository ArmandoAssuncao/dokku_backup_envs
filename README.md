# Dokku Backup ENVs

Backup the envs of Dokku apps

## Dependencies

- aws-cli

## Usage

```sh
# make script executable
chmod +x ./dokku-backup-envs.sh
```

If the file `~/.aws/credentials` is configured, use:
```sh
BUCKET_NAME="your-bucket" ./dokku-backup-envs.sh
```

Or use (AWS_REGION is optional, default: us-east-1):
```sh
BUCKET_NAME="your-bucket" AWS_ACCESS_KEY_ID="key_id" AWS_SECRET_ACCESS_KEY="secret" AWS_REGION="us-east-1" ./dokku-backup-envs.sh
```

## Structure

the files are saves in the structure:
```
20201230_2359/
  hostname/
    appname1/
      ENV
    appname2/
      ENV
...
```
