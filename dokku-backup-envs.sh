#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

aws_region=${AWS_REGION:-us-east-1}
bucket_name=$BUCKET_NAME
folder_date=$(date "+%Y%m%d_%H%M")
dokku_dir="/home/dokku"
app_names=$(ls $dokku_dir)

dokku_hostname=$(cat $dokku_dir/HOSTNAME)
dokku_hostname_length=${#dokku_hostname}

if [ "$dokku_hostname_length" -gt 0 ]; then
  host_name=$dokku_hostname
else
  host_name=$(hostname)
fi

if [ -z "$bucket_name" ]; then
  echo "env BUCKET_NAME cannot be blank"
  exit 1
fi

awscli=$(which aws)

for entry in $app_names
do
  if [ "$entry" = "ENV" ]; then
    env_file=$dokku_dir/ENV # global ENV
    env_file_s3=ENV
  else
    env_file=$dokku_dir/$entry/ENV
    env_file_s3=$entry/ENV
  fi

  if [ -f "$env_file" ]; then
    AWS_REGION=$aws_region $awscli s3 cp "$env_file" "s3://$bucket_name/$folder_date/$host_name/$env_file_s3"
  fi
done

if [ "$?" -eq "0" ]; then
  echo "The backup finished successfully."
else
  echo "TheBackup has failed."
fi
