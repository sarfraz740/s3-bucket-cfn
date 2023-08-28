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

while true;do
echo "Enter the IAm user: "
read user_name

# Check if the IAM user exists
aws iam get-user --user-name "$user_name" | grep -q 'user_name'

# If the command returns a non-zero exit code, the IAM user does not exist
if [ $? -eq 0 ]; then
  echo "The IAM '$user_name' already exists. Please enter a new IAM user."
else
  echo "The IAM '$user_name' does not exist. You can use this IAM user."
  break
fi
done


while true;do
echo "Enter the IAm role: "
read role_name


# Check if the IAM role exists
aws iam get-role --role-name $role_name > /dev/null

# If the command exits with a zero exit code, the IAM role exists
if [ $? -eq 0 ]; then
  echo "The IAM role $role_name exists."
else
  echo "The IAM role $role_name does not exist."
  break
fi
done

echo "Enter the Stack-name name: "
read stack_name


#aws cloudformation create-stack --stack-name sarfraz11 --template-body file:///home/sarfraz/Desktop/CNF/template.yaml --parameters ParameterKey=BucketName,ParameterValue=$bucket_name
aws cloudformation create-stack --stack-name $stack_name --template-body file:///home/sarfraz/Desktop/CNF/template2.yaml --capabilities CAPABILITY_NAMED_IAM --parameters ParameterKey=BucketName,ParameterValue=$bucket_name ParameterKey=UserName,ParameterValue=$user_name ParameterKey=RoleName,ParameterValue=$role_name