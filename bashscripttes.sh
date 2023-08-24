#!/bin/bash
while true; do
echo "Enter the S3 bucket name: "
read bucket_name

# Check if the bucket exists
aws s3api head-bucket --bucket "$bucket_name"

if [ $? -eq 0 ]; then
  echo "The bucket '$bucket_name' already exists. Please enter a new bucket name."
else
  echo "Bucket '$bucket_name' does not exist. You can use this bucket name."
  break
fi
done
echo "Enter the Stack-name name: "
read stack_name
#echo "bucket-name"


aws cloudformation create-stack --stack-name $stack_name --template-body file:///home/sarfraz/Desktop/CNF/template.yaml --parameters ParameterKey=BucketName,ParameterValue=$bucket_name