aws_region=${AWS_REGION:-us-east-1}
bucket_name=${BUCKET_NAME}
folder_date=$(date '+%Y%m%d_%H%M')
hostname=$HOSTNAME

dokku_dir='/home/dokku'
app_names=`ls $dokku_dir`

if [ -z "$bucket_name" ]; then
  echo "env BUCKET_NAME cannot be blank"
  exit 1
fi

for entry in $app_names
do
  env_file=$dokku_dir/$entry/ENV

  if [ -f "$env_file" ]; then
    AWS_REGION=$aws_region aws s3 cp $env_file s3://$bucket_name/$folder_date/$hostname/$entry/ENV
  fi
done

echo "OK!"