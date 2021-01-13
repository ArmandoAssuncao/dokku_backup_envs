# Dokku Backup ENVs

Backup the envs of Dokku apps

## Dependencies

- aws-cli

## Usage

```sh
# In machine running dokku, download the script:
wget https://raw.githubusercontent.com/ArmandoAssuncao/dokku_backup_envs/master/dokku-backup-envs.sh
```

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

### Add in Crontab

```sh
0 */12 * * * BUCKET_NAME="bucket-name" AWS_ACCESS_KEY_ID="key_id" AWS_SECRET_ACCESS_KEY="secret" AWS_REGION=us-east-1 /bin/sh /root/scripts/dokku-backup-envs.sh
```

## Structure

the files are saves in the structure:
```
20201230_2359/
  hostname/
    ENV <- global ENV
    appname1/
      ENV
    appname2/
      ENV
...
```
